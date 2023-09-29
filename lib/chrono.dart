import "package:chrono/locales/en/configuration.dart";
import "package:chrono/ported/RegExpMatchArray.dart";
import "package:chrono/ported/StringUtils.dart";

import "debugging.dart" show AsyncDebugBlock, DebugHandler;
import 'locales/en/index.dart' as en_chrono;
import 'locales/ru/index.dart' as ru_chrono;
import "results.dart"
    show ReferenceWithTimezone, ParsingComponents, ParsingResult;
import "types.dart"
    show Component, ParsedResult, ParsingOption;

/**
 * Chrono configuration.
 * It is simply an ordered list of parsers and refiners
 */
class Configuration {
  List<Parser> parsers;

  List<Refiner> refiners;

  Configuration(this.parsers, this.refiners);
}

/**
 * An abstraction for Chrono *Parser*.
 *
 * Each parser should recognize and handle a certain date format.
 * Chrono uses multiple parses (and refiners) together for parsing the input.
 *
 * The parser implementation must provide {@Link pattern | pattern()} for the date format.
 *
 * The {@Link extract | extract()} method is called with the pattern's *match*.
 * The matching and extracting is controlled and adjusted to avoid for overlapping results.
 */
abstract class Parser {
  const Parser();
  RegExp pattern(ParsingContext context);

  dynamic /* ParsingComponents | ParsingResult | dynamic | null */ extract(
      ParsingContext context, RegExpMatchArray match);
}

class CustomParser implements Parser {
  /* ParsingComponents | ParsingResult | dynamic | null */ Function(ParsingContext context, RegExpMatchArray match) extractor;
  RegExp Function(ParsingContext context) patternGetter;

  @override
  extract(ParsingContext context, RegExpMatchArray match) {
    return extractor(context, match);
  }

  @override
  RegExp pattern(ParsingContext context) {
    return patternGetter(context);
  }

  CustomParser(this.extractor, this.patternGetter);
}

/**
 * A abstraction for Chrono *Refiner*.
 *
 * Each refiner takes the list of results (from parsers or other refiners) and returns another list of results.
 * Chrono applies each refiner in order and return the output from the last refiner.
 */
abstract class Refiner {
  List<ParsingResult> refine(
      ParsingContext context, List<ParsingResult> results);
// dynamic /* (context: ParsingContext, results: ParsingResult[]) => ParsingResult[] */ refine;
}

class CustomRefiner implements Refiner {
  List<ParsingResult> Function(
      ParsingContext context, List<ParsingResult> results) refineFunction;

  @override
  List<ParsingResult> refine(
      ParsingContext context, List<ParsingResult> results) {
    return refineFunction(context, results);
  }

  CustomRefiner(this.refineFunction);
}

/**
 * The Chrono object.
 */
class Chrono {
  static final ru = Ru();
  static final en = En();
  late List<Parser> parsers;

  late List<Refiner> refiners;

  // var defaultConfig = ;

  Chrono([Configuration? configuration]) {
    configuration =
        configuration ?? ENDefaultConfiguration.createCasualConfiguration();
    parsers = configuration.parsers;
    refiners = configuration.refiners;
  }

  /**
   * Create a shallow copy of the Chrono object with the same configuration (`parsers` and `refiners`)
   */
  Chrono clone() {
    return Chrono(Configuration(parsers.toList(), refiners.toList()));
  }

  /**
   * A shortcut for calling {@Link parse | parse() } then transform the result into Javascript's Date object
   *
   */
  DateTime? parseDate(String text,
      [dynamic /* ParsingReference | Date */ referenceDate,
      ParsingOption? option]) {
    final results = parse(text, referenceDate: referenceDate, option:option);
    return results.length > 0 ? results[0].start.date() : null;
  }

  List<ParsedResult> parse(String text,
  {dynamic /* ParsingReference | Date */ referenceDate,
      ParsingOption? option}) {
    final context = ParsingContext(text, referenceDate, option);
    List<ParsingResult> results = [];
    for (var parser in parsers) {
      final parsedResults = Chrono.executeParser(context, parser);
      results = results + parsedResults;
    }
    results.sort((a, b) {
      return a.index - b.index;
    });
    for (var refiner in refiners) {
      results = refiner.refine(context, results);
    }
    return results;
  }

  static List<ParsingResult> executeParser(
      ParsingContext context, Parser parser) {
    final List<ParsingResult> results = [];
    final pattern = parser.pattern(context);

    final originalText = context.text;
    var remainingText = context.text;
    var match = pattern.exec(remainingText);
    while (match != null && match.matches.isNotEmpty) {
      // Calculate match index on the full text;
      final index = match.index + originalText.length - remainingText.length;
      match.index = index;
      final result = parser.extract(context, match);
      if (result == null) {
        // If fails, move on by 1
        try {
          remainingText = originalText.substringTs(match.index + 1);
        } on RangeError {
          remainingText = '';
        }
        ;
        match = pattern.exec(remainingText);
        continue;
      }
      late ParsingResult parsedResult;
      if (result is ParsingResult) {
        parsedResult = result;
      } else if (result is ParsingComponents) {
        parsedResult = context.createParsingResult(match.index, match[0]);
        parsedResult.start = result;
      } else {
        parsedResult =
            context.createParsingResult(match.index, match[0], result);
      }
      final parsedIndex = parsedResult.index;
      final parsedText = parsedResult.text;
      context.debug(() => print(
          '''executeParser extracted (at index=${parsedIndex}) \'${parsedText}\''''));
      results.add(parsedResult);
      remainingText = originalText.substringTs(parsedIndex + parsedText.length);
      match = pattern.exec(remainingText);
    }
    return results;
  }
}

class ParsingContext implements DebugHandler {
  late String text;

  late ParsingOption? option;

  late ReferenceWithTimezone reference;

  /**
   * . Use `reference.instant` instead.
   */
  late DateTime refDate;

  ParsingContext(this.text,
      [dynamic /* ParsingReference | Date */ refDate, this.option]) {
    reference = ReferenceWithTimezone(refDate);
    this.refDate = reference.instant;
  }

  ParsingComponents createParsingComponents([dynamic? components]) {
    if (components is ParsingComponents) {
      return components;
    }
    return ParsingComponents(reference, components);
  }

  ParsingResult createParsingResult(
      num index, dynamic /* num | String */ textOrEndIndex,
      [dynamic /* dynamic | ParsingComponents */ startComponents,
      dynamic /* dynamic | ParsingComponents */ endComponents]) {
    final text = textOrEndIndex is String
        ? textOrEndIndex
        : this.text.substringTs(index.toInt(), textOrEndIndex);
    final start = startComponents != null
        ? createParsingComponents(startComponents)
        : null;
    final end = endComponents != null
        ? createParsingComponents(endComponents)
        : null;
    return ParsingResult(reference, index.toInt(), text, start, end);
  }

  @override
  get debug {
    return (AsyncDebugBlock block) {
      if (option?.debug != null) {
        if (option!.debug is Function) {
          option!.debug(block);
        } else {
          final DebugHandler handler = (option!.debug as DebugHandler);
          handler.debug(block);
        }
      }
    };
  }
}

class Ru {
  final casual = ru_chrono.casual;
  final strict = ru_chrono.strict;
}

class En {
  final casual = en_chrono.casual;
  final strict = en_chrono.strict;
}

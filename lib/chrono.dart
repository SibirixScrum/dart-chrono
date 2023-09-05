import "package:chrono/ported/RegExpMatchArray.dart";

import "debugging.dart" show AsyncDebugBlock, DebugHandler;
import 'locales/ru/index.dart' as ru;
import "results.dart"
    show ReferenceWithTimezone, ParsingComponents, ParsingResult;
import "types.dart"
    show Component, ParsedResult, ParsingOption, ParsingReference;

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
  RegExp pattern(ParsingContext context);

  dynamic /* ParsingComponents | ParsingResult | dynamic | null */ extract(
      ParsingContext context, RegExpMatchArray match);
}

/**
 * A abstraction for Chrono *Refiner*.
 *
 * Each refiner takes the list of results (from parsers or other refiners) and returns another list of results.
 * Chrono applies each refiner in order and return the output from the last refiner.
 */
abstract class Refiner {
  List<ParsingResult> refine(ParsingContext context,
      List<ParsingResult> results);
// dynamic /* (context: ParsingContext, results: ParsingResult[]) => ParsingResult[] */ refine;
}

/**
 * The Chrono object.
 */
class Chrono {
  late List<Parser> parsers;

  late List<Refiner> refiners;

  // var defaultConfig = ;

  Chrono([Configuration? configuration]) {
    configuration = configuration ?? ru.createCasualConfiguration();
    parsers = configuration.parsers;
    refiners = configuration.refiners;
  }

  /**
   * Create a shallow copy of the Chrono object with the same configuration (`parsers` and `refiners`)
   */
  Chrono clone() {
    return new Chrono(Configuration(parsers, refiners));
  }

  /**
   * A shortcut for calling {@Link parse | parse() } then transform the result into Javascript's Date object
   *
   */
  dynamic /* Date | null */ parseDate(String text,
      [dynamic /* ParsingReference | Date */ referenceDate,
        ParsingOption? option]) {
    final results = this.parse(text, referenceDate, option);
    return results.length > 0 ? results[0].start.date() : null;
  }


  List<ParsedResult> parse(String text,
      [dynamic /* ParsingReference | Date */ referenceDate,
        ParsingOption? option]) {
    final context = new ParsingContext(text, referenceDate, option);
    List<ParsingResult> results = [];
    this.parsers.forEach((parser) {
      final parsedResults = Chrono.executeParser(context, parser);
      results = results + parsedResults;
    });
    results.sort((a, b) {
      return a.index - b.index;
    });
    this.refiners.forEach((refiner) {
      results = refiner.refine(context, results);
    });
    return results;
  }

  static List<ParsingResult> executeParser(ParsingContext context,
      Parser parser) {
    final List<ParsingResult> results = [];
    final pattern = parser.pattern(context);
    final isCaseSensitive = pattern.isCaseSensitive;
    final originalText = context.text;
    var remainingText = context.text;
    var match = pattern.exec(remainingText);
    while (match != null && match.matches.isNotEmpty) {
      //todo что такое match: странный объект RegExpExecArray, понять, что за индекс такой
      // Calculate match index on the full text;
      final index = match.index + originalText.length - remainingText.length;
      match.index = index;
      final result = parser.extract(context, match);
      if (result == null) {
        // If fails, move on by 1
        try {
          remainingText = originalText.substring(match.index + 1);
        } on RangeError {
          remainingText = '';
        };
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
      context.debug(() =>
          print(
              '''executeParser extracted (at index=${parsedIndex}) \'${parsedText}\''''));
      results.add(parsedResult);
      remainingText = originalText.substring(parsedIndex + parsedText.length);
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

  ParsingContext(String text,
      [dynamic /* ParsingReference | Date */ refDate, ParsingOption? option]) {
    this.text = text;
    this.reference = new ReferenceWithTimezone(refDate);
    this.option = option;
    this.refDate = this.reference.instant;
  }

  ParsingComponents createParsingComponents(
      [dynamic /* dynamic | ParsingComponents */ components]) {
    if (components is ParsingComponents) {
      return components;
    }
    return new ParsingComponents(this.reference, components);
  }

  ParsingResult createParsingResult(num index,
      dynamic /* num | String */ textOrEndIndex,
      [dynamic /* dynamic | ParsingComponents */ startComponents,
        dynamic /* dynamic | ParsingComponents */ endComponents]) {
    final text = textOrEndIndex is String
        ? textOrEndIndex
        : this.text.substring(index.toInt(), textOrEndIndex);
    final start =
    startComponents != null
        ? this.createParsingComponents(startComponents)
        : null;
    final end =
    endComponents != null ? this.createParsingComponents(endComponents) : null;
    return new ParsingResult(this.reference, index.toInt(), text, start, end);
  }

  @override
  get debug {
    return (AsyncDebugBlock block) {
      if (this.option?.debug != null) {
        if (this.option!.debug is Function) {
          this.option!.debug(block);
        } else {
          final DebugHandler handler = (this.option!.debug as DebugHandler);
          handler.debug(block);
        }
      }
    };
  }
}

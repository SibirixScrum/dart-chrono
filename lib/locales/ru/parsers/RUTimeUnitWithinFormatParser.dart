import "package:chrono/ported/RegExpMatchArray.dart";

import "../../../chrono.dart" show ParsingContext;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../../../results.dart" show ParsingComponents;
import "../constants.dart" show TIME_UNITS_PATTERN, parseTimeUnits, REGEX_PARTS;

final PATTERN =
    '''(?:(?:около|примерно)\\s*(?:~\\s*)?)?(${TIME_UNITS_PATTERN})${REGEX_PARTS["rightBoundary"]!}''';
final PATTERN_WITH_PREFIX = new RegExp(
    '''(?:в течение|в течении)\\s*${PATTERN}''',
    caseSensitive: !REGEX_PARTS["flags"]!.contains("i"),
    dotAll: REGEX_PARTS["flags"]!.contains("d"),
    multiLine: REGEX_PARTS["flags"]!.contains("m"),
    unicode: REGEX_PARTS["flags"]!.contains("u"));
final PATTERN_WITHOUT_PREFIX = new RegExp(PATTERN, caseSensitive: true);

class RUTimeUnitWithinFormatParser
    extends AbstractParserWithWordBoundaryChecking {
  String patternLeftBoundary() {
    return REGEX_PARTS["leftBoundary"]!;
  }

  RegExp innerPattern(ParsingContext context) {
    return context.option?.forwardDate != null
        ? PATTERN_WITHOUT_PREFIX
        : PATTERN_WITH_PREFIX;
  }

  ParsingComponents innerExtract(
      ParsingContext context, RegExpMatchArray match) {
    final timeUnits = parseTimeUnits(match[1]);
    return ParsingComponents.createRelativeFromReference(
        context.reference, timeUnits);
  }
}

import "../constants.dart" show TIME_UNITS_PATTERN, parseTimeUnits, REGEX_PARTS;
import "../../../chrono.dart" show ParsingContext;
import "../../../results.dart" show ParsingComponents;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;

final PATTERN =
    '''(?:(?:около|примерно)\\s*(?:~\\s*)?)?(${ TIME_UNITS_PATTERN})${ REGEX_PARTS . rightBoundary}''';
final PATTERN_WITH_PREFIX =
    new RegExp('''(?:в течение|в течении)\\s*${ PATTERN}''', REGEX_PARTS.flags);
final PATTERN_WITHOUT_PREFIX = new RegExp(PATTERN, "i");

class RUTimeUnitWithinFormatParser
    extends AbstractParserWithWordBoundaryChecking {
  String patternLeftBoundary() {
    return REGEX_PARTS.leftBoundary;
  }

  RegExp innerPattern(ParsingContext context) {
    return context.option.forwardDate
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

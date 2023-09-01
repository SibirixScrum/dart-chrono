import "../../../chrono.dart" show ParsingContext;
import "../constants.dart" show parseTimeUnits, REGEX_PARTS, TIME_UNITS_PATTERN;
import "../../../results.dart" show ParsingComponents;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../../../utils/timeunits.dart" show reverseTimeUnits;

final PATTERN = new RegExp(
    '''(${ TIME_UNITS_PATTERN})\\s{0,5}назад(?=(?:\\W|\$))''',
    REGEX_PARTS.flags);

class RUTimeUnitAgoFormatParser extends AbstractParserWithWordBoundaryChecking {
  String patternLeftBoundary() {
    return REGEX_PARTS.leftBoundary;
  }

  RegExp innerPattern() {
    return PATTERN;
  }

  innerExtract(ParsingContext context, RegExpMatchArray match) {
    final timeUnits = parseTimeUnits(match[1]);
    final outputTimeUnits = reverseTimeUnits(timeUnits);
    return ParsingComponents.createRelativeFromReference(
        context.reference, outputTimeUnits);
  }
}

import "../../../chrono.dart" show ParsingContext;
import "../constants.dart"
    show parseTimeUnits, TIME_UNITS_NO_ABBR_PATTERN, TIME_UNITS_PATTERN;
import "../../../results.dart" show ParsingComponents;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../../../utils/timeunits.dart" show reverseTimeUnits;

final PATTERN = new RegExp(
    '''(${ TIME_UNITS_PATTERN})\\s{0,5}(?:ago|before|earlier)(?=\\W|\$)''',
    "i");
final STRICT_PATTERN = new RegExp(
    '''(${ TIME_UNITS_NO_ABBR_PATTERN})\\s{0,5}(?:ago|before|earlier)(?=\\W|\$)''',
    "i");

class ENTimeUnitAgoFormatParser extends AbstractParserWithWordBoundaryChecking {
  bool strictMode;
  ENTimeUnitAgoFormatParser(this.strictMode) : super() {
    /* super call moved to initializer */;
  }
  RegExp innerPattern() {
    return this.strictMode ? STRICT_PATTERN : PATTERN;
  }

  innerExtract(ParsingContext context, RegExpMatchArray match) {
    final timeUnits = parseTimeUnits(match[1]);
    final outputTimeUnits = reverseTimeUnits(timeUnits);
    return ParsingComponents.createRelativeFromReference(
        context.reference, outputTimeUnits);
  }
}

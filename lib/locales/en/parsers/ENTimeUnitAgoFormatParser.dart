import "package:chrono/ported/RegExpMatchArray.dart";

import "../../../chrono.dart" show ParsingContext;
import "../constants.dart"
    show parseTimeUnits, TIME_UNITS_NO_ABBR_PATTERN, TIME_UNITS_PATTERN;
import "../../../results.dart" show ParsingComponents;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../../../utils/timeunits.dart" show reverseTimeUnits;

final PATTERN = RegExp(
    '''($TIME_UNITS_PATTERN)\\s{0,5}(?:ago|before|earlier)(?=\\W|\$)''',
    caseSensitive: false);
final STRICT_PATTERN = RegExp(
    '''($TIME_UNITS_NO_ABBR_PATTERN)\\s{0,5}(?:ago|before|earlier)(?=\\W|\$)''',
    caseSensitive: false);

class ENTimeUnitAgoFormatParser extends AbstractParserWithWordBoundaryChecking {
  bool strictMode;
  ENTimeUnitAgoFormatParser(this.strictMode) : super() {
    /* super call moved to initializer */;
  }
  @override
  RegExp innerPattern(ParsingContext context) {
    return strictMode ? STRICT_PATTERN : PATTERN;
  }

  @override
  innerExtract(ParsingContext context, RegExpMatchArray match) {
    final timeUnits = parseTimeUnits(match[1]);
    final outputTimeUnits = reverseTimeUnits(timeUnits);
    return ParsingComponents.createRelativeFromReference(
        context.reference, outputTimeUnits);
  }
}

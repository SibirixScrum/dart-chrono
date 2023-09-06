import "../../../chrono.dart" show ParsingContext;
import "../constants.dart"
    show parseTimeUnits, TIME_UNITS_NO_ABBR_PATTERN, TIME_UNITS_PATTERN;
import "../../../results.dart" show ParsingComponents;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;

final PATTERN = new RegExp(
    '''(${ TIME_UNITS_PATTERN})\\s{0,5}(?:later|after|from now|henceforth|forward|out)''' +
        "(?=(?:\\W|\$))",
    "i");
final STRICT_PATTERN = new RegExp(
    "" +
        "(" +
        TIME_UNITS_NO_ABBR_PATTERN +
        ")" +
        "(later|from now)" +
        "(?=(?:\\W|\$))",
    "i");
const GROUP_NUM_TIMEUNITS = 1;

class ENTimeUnitLaterFormatParser
    extends AbstractParserWithWordBoundaryChecking {
  bool strictMode;
  ENTimeUnitLaterFormatParser(this.strictMode) : super() {
    /* super call moved to initializer */;
  }
  RegExp innerPattern() {
    return this.strictMode ? STRICT_PATTERN : PATTERN;
  }

  innerExtract(ParsingContext context, RegExpMatchArray match) {
    final fragments = parseTimeUnits(match[GROUP_NUM_TIMEUNITS]);
    return ParsingComponents.createRelativeFromReference(
        context.reference, fragments);
  }
}

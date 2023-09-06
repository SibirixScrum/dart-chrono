import "../../../chrono.dart" show ParsingContext;
import "../../../calculation/years.dart" show findYearClosestToRef;
import "../constants.dart" show MONTH_DICTIONARY;
import "../constants.dart"
    show ORDINAL_NUMBER_PATTERN, parseOrdinalNumberPattern;
import "../constants.dart" show YEAR_PATTERN, parseYear;
import "../../../utils/pattern.dart" show matchAnyPattern;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;

final PATTERN = new RegExp(
    '''(${ matchAnyPattern ( MONTH_DICTIONARY )})''' +
        "(?:-|/|\\s*,?\\s*)" +
        '''(${ ORDINAL_NUMBER_PATTERN})(?!\\s*(?:am|pm))\\s*''' +
        "(?:" +
        "(?:to|\\-)\\s*" +
        '''(${ ORDINAL_NUMBER_PATTERN})\\s*''' +
        ")?" +
        "(?:" +
        "(?:-|/|\\s*,?\\s*)" +
        '''(${ YEAR_PATTERN})''' +
        ")?" +
        "(?=\\W|\$)(?!\\:\\d)",
    "i");
const MONTH_NAME_GROUP = 1;
const DATE_GROUP = 2;
const DATE_TO_GROUP = 3;
const YEAR_GROUP = 4;

/**
 * The parser for parsing US's date format that begin with month's name.
 *  - January 13
 *  - January 13, 2012
 *  - January 13 - 15, 2012
 * Note: Watch out for:
 *  - January 12:00
 *  - January 12.44
 *  - January 1222344
 */
class ENMonthNameMiddleEndianParser
    extends AbstractParserWithWordBoundaryChecking {
  RegExp innerPattern() {
    return PATTERN;
  }

  innerExtract(ParsingContext context, RegExpMatchArray match) {
    final month = MONTH_DICTIONARY[match[MONTH_NAME_GROUP].toLowerCase()];
    final day = parseOrdinalNumberPattern(match[DATE_GROUP]);
    if (day > 31) {
      return null;
    }
    final components = context.createParsingComponents(day: day, month: month);
    if (match[YEAR_GROUP]) {
      final year = parseYear(match[YEAR_GROUP]);
      components.assign("year", year);
    } else {
      final year = findYearClosestToRef(context.refDate, day, month);
      components.imply("year", year);
    }
    if (!match[DATE_TO_GROUP]) {
      return components;
    }
    // Text can be 'range' value. Such as 'January 12 - 13, 2012'
    final endDate = parseOrdinalNumberPattern(match[DATE_TO_GROUP]);
    final result = context.createParsingResult(match.index, match[0]);
    result.start = components;
    result.end = components.clone();
    result.end.assign("day", endDate);
    return result;
  }
}

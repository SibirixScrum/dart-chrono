import "../../../chrono.dart" show ParsingContext;
import "../../../results.dart" show ParsingResult;
import "../../../calculation/years.dart" show findYearClosestToRef;
import "../constants.dart" show MONTH_DICTIONARY;
import "../constants.dart" show YEAR_PATTERN, parseYear;
import "../constants.dart"
    show ORDINAL_NUMBER_PATTERN, parseOrdinalNumberPattern;
import "../../../utils/pattern.dart" show matchAnyPattern;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;

// prettier-ignore
final PATTERN = new RegExp(
    '''(?:on\\s{0,3})?''' +
        '''(${ ORDINAL_NUMBER_PATTERN})''' +
        '''(?:''' +
        '''\\s{0,3}(?:to|\\-|\\–|until|through|till)?\\s{0,3}''' +
        '''(${ ORDINAL_NUMBER_PATTERN})''' +
        ")?" +
        '''(?:-|/|\\s{0,3}(?:of)?\\s{0,3})''' +
        '''(${ matchAnyPattern ( MONTH_DICTIONARY )})''' +
        "(?:" +
        '''(?:-|/|,?\\s{0,3})''' +
        '''(${ YEAR_PATTERN}(?![^\\s]\\d))''' +
        ")?" +
        "(?=\\W|\$)",
    "i");
const DATE_GROUP = 1;
const DATE_TO_GROUP = 2;
const MONTH_NAME_GROUP = 3;
const YEAR_GROUP = 4;

class ENMonthNameLittleEndianParser
    extends AbstractParserWithWordBoundaryChecking {
  RegExp innerPattern() {
    return PATTERN;
  }

  ParsingResult innerExtract(ParsingContext context, RegExpMatchArray match) {
    final result = context.createParsingResult(match.index, match[0]);
    final month = MONTH_DICTIONARY[match[MONTH_NAME_GROUP].toLowerCase()];
    final day = parseOrdinalNumberPattern(match[DATE_GROUP]);
    if (day > 31) {
      // e.g. "[96 Aug]" => "9[6 Aug]", we need to shift away from the next number
      match.index = match.index + match[DATE_GROUP].length;
      return null;
    }
    result.start.assign("month", month);
    result.start.assign("day", day);
    if (match[YEAR_GROUP]) {
      final yearNumber = parseYear(match[YEAR_GROUP]);
      result.start.assign("year", yearNumber);
    } else {
      final year = findYearClosestToRef(context.refDate, day, month);
      result.start.imply("year", year);
    }
    if (match[DATE_TO_GROUP]) {
      final endDate = parseOrdinalNumberPattern(match[DATE_TO_GROUP]);
      result.end = result.start.clone();
      result.end.assign("day", endDate);
    }
    return result;
  }
}

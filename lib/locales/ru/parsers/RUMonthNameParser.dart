import "../constants.dart"
    show FULL_MONTH_NAME_DICTIONARY, MONTH_DICTIONARY, REGEX_PARTS;
import "../../../chrono.dart" show ParsingContext;
import "../../../calculation/years.dart" show findYearClosestToRef;
import "../../../utils/pattern.dart" show matchAnyPattern;
import "../constants.dart" show YEAR_PATTERN, parseYear;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;

final PATTERN = new RegExp(
    '''((?:в)\\s*)?''' +
        '''(${ matchAnyPattern ( MONTH_DICTIONARY )})''' +
        '''\\s*''' +
        '''(?:''' +
        '''[,-]?\\s*(${ YEAR_PATTERN})?''' +
        ''')?''' +
        '''(?=[^\\s\\w]|\\s+[^0-9]|\\s+\$|\$)''',
    REGEX_PARTS.flags);
const MONTH_NAME_GROUP = 2;
const YEAR_GROUP = 3;

/**
 * The parser for parsing month name and year.
 * - Январь, 2012
 * - Январь 2012
 * - Январь
 */
class RUMonthNameParser extends AbstractParserWithWordBoundaryChecking {
  String patternLeftBoundary() {
    return REGEX_PARTS.leftBoundary;
  }

  RegExp innerPattern() {
    return PATTERN;
  }

  innerExtract(ParsingContext context, RegExpMatchArray match) {
    final monthName = match[MONTH_NAME_GROUP].toLowerCase();
    // skip some unlikely words "янв", "фер", ..
    if (match[0].length <= 3 && !FULL_MONTH_NAME_DICTIONARY[monthName]) {
      return null;
    }
    final result =
        context.createParsingResult(match.index, match.index + match[0].length);
    result.start.imply("day", 1);
    final month = MONTH_DICTIONARY[monthName];
    result.start.assign("month", month);
    if (match[YEAR_GROUP]) {
      final year = parseYear(match[YEAR_GROUP]);
      result.start.assign("year", year);
    } else {
      final year = findYearClosestToRef(context.refDate, 1, month);
      result.start.imply("year", year);
    }
    return result;
  }
}

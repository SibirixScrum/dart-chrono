import "../../../chrono.dart" show ParsingContext;
import "../constants.dart" show MONTH_DICTIONARY;
import "../../../utils/pattern.dart" show matchAnyPattern;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;

/*
    Date format with slash "/" between numbers like ENSlashDateFormatParser,
    but this parser expect year before month and date.
    - YYYY/MM/DD
    - YYYY-MM-DD
    - YYYY.MM.DD
*/
final PATTERN = new RegExp(
    '''([0-9]{4})[\\.\\/\\s]''' +
        '''(?:(${ matchAnyPattern ( MONTH_DICTIONARY )})|([0-9]{1,2}))[\\.\\/\\s]''' +
        '''([0-9]{1,2})''' +
        "(?=\\W|\$)",
    "i");
const YEAR_NUMBER_GROUP = 1;
const MONTH_NAME_GROUP = 2;
const MONTH_NUMBER_GROUP = 3;
const DATE_NUMBER_GROUP = 4;

class ENCasualYearMonthDayParser
    extends AbstractParserWithWordBoundaryChecking {
  RegExp innerPattern() {
    return PATTERN;
  }

  innerExtract(ParsingContext context, RegExpMatchArray match) {
    final month = match[MONTH_NUMBER_GROUP]
        ? parseInt(match[MONTH_NUMBER_GROUP])
        : MONTH_DICTIONARY[match[MONTH_NAME_GROUP].toLowerCase()];
    if (month < 1 || month > 12) {
      return null;
    }
    final year = parseInt(match[YEAR_NUMBER_GROUP]);
    final day = parseInt(match[DATE_NUMBER_GROUP]);
    return {"day": day, "month": month, "year": year};
  }
}

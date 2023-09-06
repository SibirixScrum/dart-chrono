import "../../../chrono.dart" show ParsingContext;
import "../../../results.dart" show ParsingComponents;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;

final PATTERN = new RegExp("([0-9]|0[1-9]|1[012])/([0-9]{4})" + "", "i");
const MONTH_GROUP = 1;
const YEAR_GROUP = 2;

/**
 * Month/Year date format with slash "/" (also "-" and ".") between numbers
 * - 11/05
 * - 06/2005
 */
class ENSlashMonthFormatParser extends AbstractParserWithWordBoundaryChecking {
  RegExp innerPattern() {
    return PATTERN;
  }

  ParsingComponents innerExtract(
      ParsingContext context, RegExpMatchArray match) {
    final year = parseInt(match[YEAR_GROUP]);
    final month = parseInt(match[MONTH_GROUP]);
    return context
        .createParsingComponents()
        .imply("day", 1)
        .assign("month", month)
        .assign("year", year);
  }
}

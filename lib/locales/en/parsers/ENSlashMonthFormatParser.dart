import "package:chrono/ported/ParseInt.dart";
import "package:chrono/ported/RegExpMatchArray.dart";
import "package:chrono/types.dart";

import "../../../chrono.dart" show ParsingContext;
import "../../../results.dart" show ParsingComponents;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;

final PATTERN = new RegExp("([0-9]|0[1-9]|1[012])/([0-9]{4})" + "", caseSensitive: false);
const MONTH_GROUP = 1;
const YEAR_GROUP = 2;

/**
 * Month/Year date format with slash "/" (also "-" and ".") between numbers
 * - 11/05
 * - 06/2005
 */
class ENSlashMonthFormatParser extends AbstractParserWithWordBoundaryChecking {
  RegExp innerPattern(ParsingContext context) {
    return PATTERN;
  }

  ParsingComponents innerExtract(
      ParsingContext context, RegExpMatchArray match) {
    final year = parseIntTs(match[YEAR_GROUP]);
    final month = parseIntTs(match[MONTH_GROUP]);
    return context
        .createParsingComponents()
        .imply(Component.day, 1)
        .assign(Component.month, month)
        .assign(Component.year, year);
  }
}

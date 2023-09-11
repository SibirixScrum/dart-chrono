import "package:chrono/ported/RegExpMatchArray.dart";
import "package:chrono/types.dart";

import "../constants.dart" show FULL_MONTH_NAME_DICTIONARY, MONTH_DICTIONARY;
import "../../../chrono.dart" show ParsingContext;
import "../../../calculation/years.dart" show findYearClosestToRef;
import "../../../utils/pattern.dart" show matchAnyPattern;
import "../constants.dart" show YEAR_PATTERN, parseYear;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;

final PATTERN = RegExp (
    '''((?:in)\\s*)?''' + '''(${ matchAnyPattern(MONTH_DICTIONARY)})''' +
        '''\\s*''' + '''(?:''' + '''[,-]?\\s*(${ YEAR_PATTERN})?''' + ")?" +
        "(?=[^\\s\\w]|\\s+[^0-9]|\\s+\$|\$)", caseSensitive: false);

const PREFIX_GROUP = 1;

const MONTH_NAME_GROUP = 2;

const YEAR_GROUP = 3;
/**
 * The parser for parsing month name and year.
 * - January, 2012
 * - January 2012
 * - January
 * (in) Jan
 */
class ENMonthNameParser extends AbstractParserWithWordBoundaryChecking {
  @override
  RegExp innerPattern(ParsingContext context) {
    return PATTERN;
  }

  @override
  innerExtract(ParsingContext context, RegExpMatchArray match) {
    final monthName = match [ MONTH_NAME_GROUP ].toLowerCase();
    // skip some unlikely words "jan", "mar", ..
    if (match [ 0 ].length <= 3 &&
        FULL_MONTH_NAME_DICTIONARY [ monthName ] == null) {
      return null;
    }
    final result = context.createParsingResult(
        match.index + match [ PREFIX_GROUP ].length,
        match.index + match [ 0 ].length);
    result.start.imply(Component.day, 1);
    final month = MONTH_DICTIONARY [ monthName ]!;
    result.start.assign(Component.month, month);
    if (match [ YEAR_GROUP ].isNotEmpty) {
      final year = parseYear(match [ YEAR_GROUP ]);
      result.start.assign(Component.year, year);
    } else {
      final year = findYearClosestToRef(context.refDate, 1, month);
      result.start.imply(Component.year, year);
    }
    return result;
  }
}
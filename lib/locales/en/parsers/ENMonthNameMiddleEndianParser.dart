import "package:chrono/ported/RegExpMatchArray.dart";
import "package:chrono/types.dart";

import "../../../calculation/years.dart" show findYearClosestToRef;
import "../../../chrono.dart" show ParsingContext;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../../../utils/pattern.dart" show matchAnyPattern;
import "../constants.dart" show MONTH_DICTIONARY;
import "../constants.dart"
    show ORDINAL_NUMBER_PATTERN, parseOrdinalNumberPattern;
import "../constants.dart" show YEAR_PATTERN, parseYear;

final PATTERN = RegExp(
    '''(${matchAnyPattern(MONTH_DICTIONARY)})''' +
        "(?:-|/|\\s*,?\\s*)" +
        '''(${ORDINAL_NUMBER_PATTERN})(?!\\s*(?:am|pm))\\s*''' +
        "(?:" +
        "(?:to|\\-)\\s*" +
        '''(${ORDINAL_NUMBER_PATTERN})\\s*''' +
        ")?" +
        "(?:" +
        "(?:-|/|\\s*,?\\s*)" +
        '''(${YEAR_PATTERN})''' +
        ")?" +
        "(?=\\W|\$)(?!\\:\\d)",
    caseSensitive: false);
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
  @override
  RegExp innerPattern(ParsingContext context) {
    return PATTERN;
  }

  @override
  innerExtract(ParsingContext context, RegExpMatchArray match) {
    final month = MONTH_DICTIONARY[match[MONTH_NAME_GROUP].toLowerCase()]!;
    final day = parseOrdinalNumberPattern(match[DATE_GROUP]);
    if (day > 31) {
      return null;
    }
    final components = context.createParsingComponents({Component.day: day, Component.month: month});
    if (match[YEAR_GROUP].isNotEmpty) {
      final year = parseYear(match[YEAR_GROUP]);
      components.assign(Component.year, year);
    } else {
      final year = findYearClosestToRef(context.refDate, day, month);
      components.imply(Component.year, year);
    }
    if (!match[DATE_TO_GROUP].isNotEmpty) {
      return components;
    }
    // Text can be 'range' value. Such as 'January 12 - 13, 2012'
    final endDate = parseOrdinalNumberPattern(match[DATE_TO_GROUP]);
    final result = context.createParsingResult(match.index, match[0]);
    result.start = components;
    result.end = components.clone();
    result.end!.assign(Component.day, endDate);
    return result;
  }
}

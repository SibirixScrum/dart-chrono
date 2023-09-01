import "package:chrono/ported/RegExpMatchArray.dart";
import "package:chrono/types.dart";

import "../../../calculation/years.dart" show findYearClosestToRef;
import "../../../chrono.dart" show ParsingContext;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../../../utils/pattern.dart" show matchAnyPattern;
import "../constants.dart"
    show
        FULL_MONTH_NAME_DICTIONARY,
        MONTH_DICTIONARY,
        MONTH_NAME_DICTIONARY,
        REGEX_PARTS;
import "../constants.dart" show YEAR_PATTERN, parseYear;

final PATTERN = new RegExp(
    '''((?:в)\\s*)?''' +
        '''(${matchAnyPattern(MONTH_NAME_DICTIONARY)})''' +
        '''\\s*''' +
        '''(?:''' +
        '''[,-]?\\s*(${YEAR_PATTERN})?''' +
        ''')?''' +
        '''(?=[^\\s\\w]|\\s+[^0-9]|\\s+\$|\$)''',
    caseSensitive: REGEX_PARTS["flags"]!.contains("i"),
    dotAll: REGEX_PARTS["flags"]!.contains("d"),
    multiLine: REGEX_PARTS["flags"]!.contains("m"),
    unicode: REGEX_PARTS["flags"]!.contains("u"));
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
    return REGEX_PARTS["leftBoundary"]!;
  }

  RegExp innerPattern(ParsingContext context) {
    return PATTERN;
  }

  innerExtract(ParsingContext context, RegExpMatchArray match) {
    final monthName = match.matches[MONTH_NAME_GROUP]!.toLowerCase();
    // skip some unlikely words "янв", "фер", ..
    if (match[0].length <= 3 &&
        !FULL_MONTH_NAME_DICTIONARY.containsKey(monthName)) {
      return null;
    }
    final result =
        context.createParsingResult(match.index, match.index + match[0].length);
    result.start.imply(Component.day, 1);
    final month = MONTH_NAME_DICTIONARY[monthName]!;
    result.start.assign(Component.month, month);
    if (match.matches.length > YEAR_GROUP) {
      final year = parseYear(match[YEAR_GROUP]);
      result.start.assign(Component.year, year);
    } else {
      final year = findYearClosestToRef(context.refDate, 1, month);
      result.start.imply(Component.year, year);
    }
    return result;
  }
}

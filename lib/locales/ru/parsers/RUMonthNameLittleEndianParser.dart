import "package:chrono/ported/RegExpMatchArray.dart";

import "../../../calculation/years.dart" show findYearClosestToRef;
import "../../../chrono.dart" show ParsingContext;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../../../results.dart" show ParsingResult;
import "../../../utils/pattern.dart" show matchAnyPattern;
import "../constants.dart"
    show MONTH_DICTIONARY, MONTH_NAME_DICTIONARY, REGEX_PARTS;
import "../constants.dart" show YEAR_PATTERN, parseYear;
import "../constants.dart"
    show ORDINAL_NUMBER_PATTERN, parseOrdinalNumberPattern;

// prettier-ignore
final PATTERN = new RegExp(
    '''(?:с)?\\s*(${ORDINAL_NUMBER_PATTERN})''' +
        '''(?:''' +
        '''\\s{0,3}(?:по|-|–|до)?\\s{0,3}''' +
        '''(${ORDINAL_NUMBER_PATTERN})''' +
        ''')?''' +
        '''(?:-|\\/|\\s{0,3}(?:of)?\\s{0,3})''' +
        '''(${matchAnyPattern(MONTH_NAME_DICTIONARY)})''' +
        '''(?:''' +
        '''(?:-|\\/|,?\\s{0,3})''' +
        '''(${YEAR_PATTERN}(?![^\\s]\\d))''' +
        ''')?''' +
        '''${REGEX_PARTS["rightBoundary"]}''',
    caseSensitive: REGEX_PARTS["flags"]!.contains("i"),
    dotAll: REGEX_PARTS["flags"]!.contains("d"),
    multiLine: REGEX_PARTS["flags"]!.contains("m"),
    unicode: REGEX_PARTS["flags"]!.contains("u"));
const DATE_GROUP = 1;
const DATE_TO_GROUP = 2;
const MONTH_NAME_GROUP = 3;
const YEAR_GROUP = 4;

class RUMonthNameLittleEndianParser
    extends AbstractParserWithWordBoundaryChecking {
  String patternLeftBoundary() {
    return REGEX_PARTS["leftBoundary"]!;
  }

  RegExp innerPattern(ParsingContext context) {
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

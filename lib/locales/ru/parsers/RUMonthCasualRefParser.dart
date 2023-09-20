import "package:chrono/ported/ParseInt.dart";
import "package:chrono/ported/RegExpMatchArray.dart";
import "package:chrono/types.dart";
import "package:chrono/utils/dayjs.dart";

import "../../../chrono.dart" show ParsingContext;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../constants.dart"
    show
    MONTH_DICTIONARY,
    REGEX_PARTS;

final PATTERN = RegExp(
    '''(\\d{1,2})(\\s+)(число|числа)(\\s*|\$)''',
    caseSensitive: !REGEX_PARTS["flags"]!.contains("i"),
    dotAll: REGEX_PARTS["flags"]!.contains("d"),
    multiLine: REGEX_PARTS["flags"]!.contains("m"),
    unicode: REGEX_PARTS["flags"]!.contains("u"));
const NUMBER_GROUP = 1;

/**
 * The parser for parsing month name and year.
 * - Январь, 2012
 * - Январь 2012
 * - Январь
 */
class RUMonthCasualRefParser extends AbstractParserWithWordBoundaryChecking {
  @override
  String patternLeftBoundary() {
    return REGEX_PARTS["leftBoundary"]!;
  }

  @override
  RegExp innerPattern(ParsingContext context) {
    return PATTERN;
  }

  @override
  innerExtract(ParsingContext context, RegExpMatchArray match) {
    final number = parseIntTs(match[NUMBER_GROUP]);
    if(number>=31 || number<1){
      return null;
    }
    final result =
    context.createParsingResult(match.index, match.index + match[0].length);
    result.start.imply(Component.day, number);
    if(context.refDate.isAfter(result.start.date())){
      DateTime incrementedDate = result.start.date();
      incrementedDate = incrementedDate.copyWith(month: incrementedDate.month+1);
      implySimilarDate(result.start, incrementedDate);
    }
    return result;
  }
}

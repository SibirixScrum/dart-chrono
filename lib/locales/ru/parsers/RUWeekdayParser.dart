import "package:chrono/ported/RegExpMatchArray.dart";
import "package:chrono/ported/StringUtils.dart";
import "package:chrono/types.dart";

import "../../../chrono.dart" show ParsingContext;
import "../../../common/calculation/weekdays.dart"
    show createParsingComponentsAtWeekday;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../../../results.dart" show ParsingComponents;
import "../../../utils/pattern.dart" show matchAnyPattern;
import "../constants.dart" show REGEX_PARTS, WEEKDAY_DICTIONARY;

final PATTERN = new RegExp(
    '''(?:(?:,|\\(|（)\\s*)?''' +
        '''(?:в\\s*?)?''' +
        '''(?:(эту|этот|прошлый|прошлую|следующий|следующую|следующего)\\s*)?''' +
        '''(${matchAnyPattern(WEEKDAY_DICTIONARY)})''' +
        '''(?:\\s*(?:,|\\)|）))?''' +
        '''(?:\\s*на\\s*(этой|прошлой|следующей)\\s*неделе)?''' +
        '''${REGEX_PARTS["rightBoundary"]}''',
    caseSensitive: REGEX_PARTS["flags"]!.contains("i"),
    dotAll: REGEX_PARTS["flags"]!.contains("d"),
    multiLine: REGEX_PARTS["flags"]!.contains("m"),
    unicode: REGEX_PARTS["flags"]!.contains("u"));
const PREFIX_GROUP = 1;
const WEEKDAY_GROUP = 2;
const POSTFIX_GROUP = 3;

class RUWeekdayParser extends AbstractParserWithWordBoundaryChecking {
  String patternLeftBoundary() {
    return REGEX_PARTS["leftBoundary"]!;
  }

  ParsingComponents innerExtract(
      ParsingContext context, RegExpMatchArray match) {
    final dayOfWeek = match[WEEKDAY_GROUP].toLowerCase();
    final weekday = WEEKDAY_DICTIONARY[dayOfWeek];
    final prefix = match.matches[PREFIX_GROUP];
    final postfix = match.matches[POSTFIX_GROUP];
    var modifierWord = or(prefix, postfix);
    modifierWord = or(modifierWord, "");
    modifierWord = modifierWord!.toLowerCase();
    var modifier = null;
    if (modifierWord == "прошлый" ||
        modifierWord == "прошлую" ||
        modifierWord == "прошлой") {
      modifier = "last";
    } else if (modifierWord == "следующий" ||
        modifierWord == "следующую" ||
        modifierWord == "следующей" ||
        modifierWord == "следующего") {
      modifier = "next";
    } else if (modifierWord == "этот" ||
        modifierWord == "эту" ||
        modifierWord == "этой") {
      modifier = "this";
    }
    return createParsingComponentsAtWeekday(
        context.reference, Weekday.values[weekday!.toInt()], modifier);
  }

  @override
  RegExp innerPattern(ParsingContext context) {
    return PATTERN;
  }
}

import "../../../chrono.dart" show ParsingContext;
import "../../../results.dart" show ParsingComponents;
import "../constants.dart" show REGEX_PARTS, WEEKDAY_DICTIONARY;
import "../../../utils/pattern.dart" show matchAnyPattern;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../../../common/calculation/weekdays.dart"
    show createParsingComponentsAtWeekday;

final PATTERN = new RegExp(
    '''(?:(?:,|\\(|（)\\s*)?''' +
        '''(?:в\\s*?)?''' +
        '''(?:(эту|этот|прошлый|прошлую|следующий|следующую|следующего)\\s*)?''' +
        '''(${ matchAnyPattern ( WEEKDAY_DICTIONARY )})''' +
        '''(?:\\s*(?:,|\\)|）))?''' +
        '''(?:\\s*на\\s*(этой|прошлой|следующей)\\s*неделе)?''' +
        '''${ REGEX_PARTS . rightBoundary}''',
    REGEX_PARTS.flags);
const PREFIX_GROUP = 1;
const WEEKDAY_GROUP = 2;
const POSTFIX_GROUP = 3;

class RUWeekdayParser extends AbstractParserWithWordBoundaryChecking {
  RegExp innerPattern() {
    return PATTERN;
  }

  String patternLeftBoundary() {
    return REGEX_PARTS.leftBoundary;
  }

  ParsingComponents innerExtract(
      ParsingContext context, RegExpMatchArray match) {
    final dayOfWeek = match[WEEKDAY_GROUP].toLowerCase();
    final weekday = WEEKDAY_DICTIONARY[dayOfWeek];
    final prefix = match[PREFIX_GROUP];
    final postfix = match[POSTFIX_GROUP];
    var modifierWord = prefix || postfix;
    modifierWord = modifierWord || "";
    modifierWord = modifierWord.toLowerCase();
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
        context.reference, weekday, modifier);
  }
}

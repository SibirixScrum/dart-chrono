import "../../../chrono.dart" show ParsingContext;
import "../../../results.dart" show ParsingComponents;
import "../constants.dart" show WEEKDAY_DICTIONARY;
import "../../../utils/pattern.dart" show matchAnyPattern;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../../../common/calculation/weekdays.dart"
    show createParsingComponentsAtWeekday;

final PATTERN = new RegExp(
    "(?:(?:\\,|\\(|\\（)\\s*)?" +
        "(?:on\\s*?)?" +
        "(?:(this|last|past|next)\\s*)?" +
        '''(${ matchAnyPattern ( WEEKDAY_DICTIONARY )})''' +
        "(?:\\s*(?:\\,|\\)|\\）))?" +
        "(?:\\s*(this|last|past|next)\\s*week)?" +
        "(?=\\W|\$)",
    "i");
const PREFIX_GROUP = 1;
const WEEKDAY_GROUP = 2;
const POSTFIX_GROUP = 3;

class ENWeekdayParser extends AbstractParserWithWordBoundaryChecking {
  RegExp innerPattern() {
    return PATTERN;
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
    if (modifierWord == "last" || modifierWord == "past") {
      modifier = "last";
    } else if (modifierWord == "next") {
      modifier = "next";
    } else if (modifierWord == "this") {
      modifier = "this";
    }
    return createParsingComponentsAtWeekday(
        context.reference, weekday, modifier);
  }
}

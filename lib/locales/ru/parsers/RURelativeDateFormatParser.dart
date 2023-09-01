import "../constants.dart" show REGEX_PARTS, TIME_UNIT_DICTIONARY;
import "../../../chrono.dart" show ParsingContext;
import "../../../results.dart" show ParsingComponents;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../../../utils/pattern.dart" show matchAnyPattern;

final PATTERN = new RegExp(
    '''(в прошлом|на прошлой|на следующей|в следующем|на этой|в этом)\\s*(${ matchAnyPattern ( TIME_UNIT_DICTIONARY )})(?=\\s*)${ REGEX_PARTS . rightBoundary}''',
    REGEX_PARTS.flags);
const MODIFIER_WORD_GROUP = 1;
const RELATIVE_WORD_GROUP = 2;

class RURelativeDateFormatParser
    extends AbstractParserWithWordBoundaryChecking {
  String patternLeftBoundary() {
    return REGEX_PARTS.leftBoundary;
  }

  RegExp innerPattern() {
    return PATTERN;
  }

  ParsingComponents innerExtract(
      ParsingContext context, RegExpMatchArray match) {
    final modifier = match[MODIFIER_WORD_GROUP].toLowerCase();
    final unitWord = match[RELATIVE_WORD_GROUP].toLowerCase();
    final timeunit = TIME_UNIT_DICTIONARY[unitWord];
    if (modifier == "на следующей" || modifier == "в следующем") {
      final timeUnits = {};
      timeUnits[timeunit] = 1;
      return ParsingComponents.createRelativeFromReference(
          context.reference, timeUnits);
    }
    if (modifier == "в прошлом" || modifier == "на прошлой") {
      final timeUnits = {};
      timeUnits[timeunit] = -1;
      return ParsingComponents.createRelativeFromReference(
          context.reference, timeUnits);
    }
    final components = context.createParsingComponents();
    var date = dayjs(context.reference.instant);
    // This week
    if (timeunit.match(new RegExp(r'week', caseSensitive: false))) {
      date = date.add(-date.get("d"), "d");
      components.imply("day", date.date());
      components.imply("month", date.month() + 1);
      components.imply("year", date.year());
    } else if (timeunit.match(new RegExp(r'month', caseSensitive: false))) {
      date = date.add(-date.date() + 1, "d");
      components.imply("day", date.date());
      components.assign("year", date.year());
      components.assign("month", date.month() + 1);
    } else if (timeunit.match(new RegExp(r'year', caseSensitive: false))) {
      date = date.add(-date.date() + 1, "d");
      date = date.add(-date.month(), "month");
      components.imply("day", date.date());
      components.imply("month", date.month() + 1);
      components.assign("year", date.year());
    }
    return components;
  }
}

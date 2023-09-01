import "package:chrono/ported/RegExpMatchArray.dart";
import "package:chrono/types.dart";

import "../../../chrono.dart" show ParsingContext;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../../../results.dart" show ParsingComponents;
import "../../../utils/pattern.dart" show matchAnyPattern;
import "../constants.dart" show REGEX_PARTS, TIME_UNIT_DICTIONARY;

final PATTERN = new RegExp(
    '''(в прошлом|на прошлой|на следующей|в следующем|на этой|в этом)\\s*(${matchAnyPattern(TIME_UNIT_DICTIONARY)})(?=\\s*)${REGEX_PARTS["rightBoundary"]}''',
    caseSensitive: REGEX_PARTS["flags"]!.contains("i"),
    dotAll: REGEX_PARTS["flags"]!.contains("d"),
    multiLine: REGEX_PARTS["flags"]!.contains("m"),
    unicode: REGEX_PARTS["flags"]!.contains("u"));
const MODIFIER_WORD_GROUP = 1;
const RELATIVE_WORD_GROUP = 2;

class RURelativeDateFormatParser
    extends AbstractParserWithWordBoundaryChecking {
  String patternLeftBoundary() {
    return REGEX_PARTS["leftBoundary"]!;
  }

  RegExp innerPattern(ParsingContext context) {
    return PATTERN;
  }

  ParsingComponents innerExtract(
      ParsingContext context, RegExpMatchArray match) {
    final modifier = match.matches[MODIFIER_WORD_GROUP]!.toLowerCase();
    final unitWord = match.matches[RELATIVE_WORD_GROUP]!.toLowerCase();
    final timeunit = TIME_UNIT_DICTIONARY[unitWord];
    if (modifier == "на следующей" || modifier == "в следующем") {
      final Map<String,int> timeUnits = {};
      timeUnits[timeunit] = 1;
      return ParsingComponents.createRelativeFromReference(
          context.reference, timeUnits);
    }
    if (modifier == "в прошлом" || modifier == "на прошлой") {
      final Map<String,int> timeUnits = {};
      timeUnits[timeunit] = -1;
      return ParsingComponents.createRelativeFromReference(
          context.reference, timeUnits);
    }
    final components = context.createParsingComponents();
    var date = context.reference.instant;
    // This week
    if (timeunit.match(new RegExp(r'week', caseSensitive: false))) {
      date = date.subtract(Duration(days: date.day)); //  date = date.add(-date.get("d"), "d");
      components.imply(Component.day, date.day);
      components.imply(Component.month, date.month + 1);
      components.imply(Component.year, date.year);
    } else if (timeunit.match(new RegExp(r'month', caseSensitive: false))) {
      date = date.subtract(Duration(days: date.day - 1)); //  date = date.add(-date.date() + 1, "d");
      components.imply(Component.day, date.day);
      components.assign(Component.year, date.year);
      components.assign(Component.month, date.month + 1);
    } else if (timeunit.match(new RegExp(r'year', caseSensitive: false))) {
      date = date.subtract(Duration(days: date.day - 1)); //  date = date.add(-date.date() + 1, "d");
      date = date.copyWith(month: 0);
      components.imply(Component.day, date.day);
      components.imply(Component.month, date.month + 1);
      components.assign(Component.year, date.year);
    }
    return components;
  }
}

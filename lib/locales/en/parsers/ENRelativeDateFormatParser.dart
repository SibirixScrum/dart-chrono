import "package:chrono/ported/RegExpMatchArray.dart";
import "package:chrono/types.dart";
import "package:chrono/utils/timeunits.dart";

import "../../../chrono.dart" show ParsingContext;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../../../results.dart" show ParsingComponents;
import "../../../utils/pattern.dart" show matchAnyPattern;
import "../constants.dart" show TIME_UNIT_DICTIONARY;

final PATTERN = new RegExp(
    '''(this|last|past|next|after\\s*this)\\s*(${matchAnyPattern(TIME_UNIT_DICTIONARY)})(?=\\s*)''' +
        "(?=\\W|\$)",
    caseSensitive: false);
const MODIFIER_WORD_GROUP = 1;
const RELATIVE_WORD_GROUP = 2;

class ENRelativeDateFormatParser
    extends AbstractParserWithWordBoundaryChecking {
  RegExp innerPattern(ParsingContext context) {
    return PATTERN;
  }

  ParsingComponents innerExtract(
      ParsingContext context, RegExpMatchArray match) {
    final modifier = match[MODIFIER_WORD_GROUP].toLowerCase();
    final unitWord = match[RELATIVE_WORD_GROUP].toLowerCase();
    final timeunit = TIME_UNIT_DICTIONARY[unitWord]!;
    if (modifier == "next" || modifier.startsWith("after")) {
      final TimeUnits timeUnits = {};
      timeUnits[timeunit] = 1;
      return ParsingComponents.createRelativeFromReference(
          context.reference, timeUnits);
    }
    if (modifier == "last" || modifier == "past") {
      final TimeUnits timeUnits = {};
      timeUnits[timeunit] = -1;
      return ParsingComponents.createRelativeFromReference(
          context.reference, timeUnits);
    }
    final components = context.createParsingComponents();
    var date = context.reference.instant;
    // This week
    if (unitWord.match(new RegExp(r'week', caseSensitive: false))) {
      date = date.subtract(
          Duration(days: date.weekday%7));
      components.imply(Component.day, date.day);
      components.imply(Component.month, date.month );
      components.imply(Component.year, date.year);
    } else if (unitWord.match(new RegExp(r'month', caseSensitive: false))) {
      date = date.subtract(Duration(days: date.day-1));
      components.imply(Component.day, date.day);
      components.assign(Component.year, date.year);
      components.assign(Component.month, date.month );
    } else if (unitWord.match(new RegExp(r'year', caseSensitive: false))) {
      date = date.subtract(Duration(days: date.day-1));
      date = date.copyWith(month: 1);
      components.imply(Component.day, date.day);
      components.imply(Component.month, date.month);
      components.assign(Component.year, date.year);
    }
    return components;
  }
}

import "package:chrono/ported/RegExpMatchArray.dart";
import "package:chrono/types.dart";

import "../../../chrono.dart" show ParsingContext;
import "../../../common/casualReferences.dart" as references;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../../../utils/dayjs.dart" show assignSimilarDate;
import "../constants.dart" show REGEX_PARTS;

final PATTERN = new RegExp(
    '''(сейчас|прошлым\\s*вечером|прошлой\\s*ночью|следующей\\s*ночью|сегодня\\s*ночью|этой\\s*ночью|ночью|этим утром|утром|утра|в\\s*полдень|вечером|вечера|в\\s*полночь)''' +
        '''${REGEX_PARTS["rightBoundary"]}''',
    caseSensitive: REGEX_PARTS["flags"]!.contains("i"),
    dotAll: REGEX_PARTS["flags"]!.contains("d"),
    multiLine: REGEX_PARTS["flags"]!.contains("m"),
    unicode: REGEX_PARTS["flags"]!.contains("u"));

class RUCasualTimeParser extends AbstractParserWithWordBoundaryChecking {
  String patternLeftBoundary() {
    return REGEX_PARTS["leftBoundary"]!;
  }

  RegExp innerPattern(ParsingContext context) {
    return PATTERN;
  }

  innerExtract(ParsingContext context, RegExpMatchArray match) {
    var targetDate = context.refDate;
    final lowerText = match[0].toLowerCase();
    final component = context.createParsingComponents();
    if (identical(lowerText, "сейчас")) {
      return references.now(context.reference);
    }
    if (identical(lowerText, "вечером") || identical(lowerText, "вечера")) {
      return references.evening(context.reference);
    }
    if (lowerText.endsWith("утром") || lowerText.endsWith("утра")) {
      return references.morning(context.reference);
    }
    if (RegExp(r'в\s*полдень').firstMatch(lowerText) != null) {
      return references.noon(context.reference);
    }
    if (RegExp(r'прошлой\s*ночью').firstMatch(lowerText) != null) {
      return references.lastNight(context.reference);
    }
    if (RegExp(r'прошлым\s*вечером').firstMatch(lowerText) != null) {
      return references.yesterdayEvening(context.reference);
    }
    if (RegExp(r'следующей\s*ночью').firstMatch(lowerText) != null) {
      final daysToAdd = targetDate.hour < 22 ? 1 : 2;
      targetDate = targetDate.add(Duration(days: daysToAdd));
      assignSimilarDate(component, targetDate);
      component.imply(Component.hour, 0);
    }
    if (RegExp(r'в\s*полночь').firstMatch(lowerText) != null ||
        lowerText.endsWith("ночью")) {
      return references.midnight(context.reference);
    }
    return component;
  }
}

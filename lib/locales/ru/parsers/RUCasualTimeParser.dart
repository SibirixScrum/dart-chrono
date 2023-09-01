import "../../../chrono.dart" show ParsingContext;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../../../common/casualReferences.dart" as references;
import "../../../utils/dayjs.dart" show assignSimilarDate;
import "../constants.dart" show REGEX_PARTS;

final PATTERN = new RegExp(
    '''(сейчас|прошлым\\s*вечером|прошлой\\s*ночью|следующей\\s*ночью|сегодня\\s*ночью|этой\\s*ночью|ночью|этим утром|утром|утра|в\\s*полдень|вечером|вечера|в\\s*полночь)''' +
        '''${ REGEX_PARTS . rightBoundary}''',
    REGEX_PARTS.flags);

class RUCasualTimeParser extends AbstractParserWithWordBoundaryChecking {
  String patternLeftBoundary() {
    return REGEX_PARTS.leftBoundary;
  }

  innerPattern() {
    return PATTERN;
  }

  innerExtract(ParsingContext context, RegExpMatchArray match) {
    var targetDate = dayjs(context.refDate);
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
    if (lowerText.match(new RegExp(r'в\s*полдень'))) {
      return references.noon(context.reference);
    }
    if (lowerText.match(new RegExp(r'прошлой\s*ночью'))) {
      return references.lastNight(context.reference);
    }
    if (lowerText.match(new RegExp(r'прошлым\s*вечером'))) {
      return references.yesterdayEvening(context.reference);
    }
    if (lowerText.match(new RegExp(r'следующей\s*ночью'))) {
      final daysToAdd = targetDate.hour() < 22 ? 1 : 2;
      targetDate = targetDate.add(daysToAdd, "day");
      assignSimilarDate(component, targetDate);
      component.imply("hour", 0);
    }
    if (lowerText.match(new RegExp(r'в\s*полночь')) ||
        lowerText.endsWith("ночью")) {
      return references.midnight(context.reference);
    }
    return component;
  }
}

import "package:chrono/ported/RegExpMatchArray.dart";
import "package:chrono/types.dart";

import "../../../chrono.dart" show ParsingContext;
import "../../../common/casualReferences.dart" as references;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../../../utils/dayjs.dart" show assignSimilarDate;

final PATTERN = new RegExp(
    r'(now|today|tonight|tomorrow|tmr|tmrw|yesterday|last\s*night)(?=\W|$)',
    caseSensitive: false);

class ENCasualDateParser extends AbstractParserWithWordBoundaryChecking {
  RegExp innerPattern(ParsingContext context) {
    return PATTERN;
  }

  dynamic /* ParsingComponents | ParsingResult */ innerExtract(
      ParsingContext context, RegExpMatchArray match) {
    var targetDate = context.refDate;
    final lowerText = match[0].toLowerCase();
    final component = context.createParsingComponents();
    switch (lowerText) {
      case "now":
        return references.now(context.reference);
      case "today":
        return references.today(context.reference);
      case "yesterday":
        return references.yesterday(context.reference);
      case "tomorrow":
      case "tmr":
      case "tmrw":
        return references.tomorrow(context.reference);
      case "tonight":
        return references.tonight(context.reference);
      default:
        if (lowerText.match(new RegExp(r'last\s*night'))) {
          if (targetDate.hour > 6) {
            targetDate = targetDate.subtract(Duration(days: 1));
          }
          assignSimilarDate(component, targetDate);
          component.imply(Component.hour, 0);
        }
        break;
    }
    return component;
  }
}

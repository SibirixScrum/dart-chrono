import "package:chrono/ported/RegExpMatchArray.dart";

import "../../../chrono.dart" show ParsingContext;
import "../../../common/parsers/AbstractTimeExpressionParser.dart"
    show AbstractTimeExpressionParser;
import "../../../results.dart" show ParsingComponents;
import "../../../types.dart" show Meridiem;
import "../constants.dart" show REGEX_PARTS;

class RUTimeExpressionParser extends AbstractTimeExpressionParser {
  RUTimeExpressionParser(strictMode) : super(strictMode) {
    /* super call moved to initializer */;
  }

  String patternFlags() {
    return REGEX_PARTS["flags"]!;
  }

  String primaryPatternLeftBoundary() {
    return '''(^|\\s|T|(?:[^\\p{L}\\p{N}_]))''';
  }

  String followingPhase() {
    return '''\\s*(?:\\-|\\–|\\~|\\〜|до|и|по|\\?)\\s*''';
  }

  String primaryPrefix() {
    return '''(?:(?:в|с)\\s*)??''';
  }

  String primarySuffix() {
    return '''(?:\\s*(?:утра|вечера|после полудня))?(?!\\/)${REGEX_PARTS["rightBoundary"]}''';
  }

  ParsingComponents? extractPrimaryTimeComponents(
      ParsingContext context, RegExpMatchArray match) {
    final components = super.extractPrimaryTimeComponents(context, match);
    if (components) {
      if (match[0].endsWith("вечера")) {
        final hour = components.get("hour");
        if (hour >= 6 && hour < 12) {
          components.assign("hour", components.get("hour") + 12);
          components.assign("meridiem", Meridiem.PM);
        } else if (hour < 6) {
          components.assign("meridiem", Meridiem.AM);
        }
      }
      if (match[0].endsWith("после полудня")) {
        components.assign("meridiem", Meridiem.PM);
        final hour = components.get("hour");
        if (hour >= 0 && hour <= 6) {
          components.assign("hour", components.get("hour") + 12);
        }
      }
      if (match[0].endsWith("утра")) {
        components.assign("meridiem", Meridiem.AM);
        final hour = components.get("hour");
        if (hour < 12) {
          components.assign("hour", components.get("hour"));
        }
      }
    }
    return components;
  }
}

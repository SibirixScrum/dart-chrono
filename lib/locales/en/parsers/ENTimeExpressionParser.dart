import "package:chrono/ported/RegExpMatchArray.dart";

import "../../../chrono.dart" show ParsingContext;
import "../../../common/parsers/AbstractTimeExpressionParser.dart"
    show AbstractTimeExpressionParser;
import "../../../results.dart" show ParsingComponents;
import "../../../types.dart" show Component, Meridiem;

class ENTimeExpressionParser extends AbstractTimeExpressionParser {
  ENTimeExpressionParser(strictMode) : super(strictMode) {
    /* super call moved to initializer */;
  }

  String followingPhase() {
    return "\\s*(?:\\-|\\–|\\~|\\〜|to|until|through|till|\\?)\\s*";
  }

  String primaryPrefix() {
    return "(?:(?:at|from)\\s*)??";
  }

  String primarySuffix() {
    return "(?:\\s*(?:o\\W*clock|at\\s*night|in\\s*the\\s*(?:morning|afternoon)))?(?!/)(?=\\W|\$)";
  }

  ParsingComponents? extractPrimaryTimeComponents(
      ParsingContext context, RegExpMatchArray match,
      [strict = false]) {
    final components = super.extractPrimaryTimeComponents(context, match);
    if (components != null) {
      if (match[0].endsWith("night")) {
        final hour = components.get(Component.hour)!.toInt();
        if (hour >= 6 && hour < 12) {
          components.assign(
              Component.hour, components.get(Component.hour)!.toInt() + 12);
          components.assign(Component.meridiem, Meridiem.PM.index);
        } else if (hour < 6) {
          components.assign(Component.meridiem, Meridiem.AM.index);
        }
      }
      if (match[0].endsWith("afternoon")) {
        components.assign(Component.meridiem, Meridiem.PM.index);
        final hour = components.get(Component.hour)!.toInt();
        if (hour >= 0 && hour <= 6) {
          components.assign(
              Component.hour, components.get(Component.hour)!.toInt() + 12);
        }
      }
      if (match[0].endsWith("morning")) {
        components.assign(Component.meridiem, Meridiem.AM.index);
        final hour = components.get(Component.hour)!.toInt();
        if (hour < 12) {
          components.assign(
              Component.hour, components.get(Component.hour)!.toInt());
        }
      }
    }
    return components;
  }
}

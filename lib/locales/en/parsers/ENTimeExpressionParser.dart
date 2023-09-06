import "../../../chrono.dart" show ParsingContext;
import "../../../results.dart" show ParsingComponents;
import "../../../types.dart" show Meridiem;
import "../../../common/parsers/AbstractTimeExpressionParser.dart"
    show AbstractTimeExpressionParser;

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

  dynamic /* null | ParsingComponents */ extractPrimaryTimeComponents(
      ParsingContext context, RegExpMatchArray match) {
    final components = super.extractPrimaryTimeComponents(context, match);
    if (components) {
      if (match[0].endsWith("night")) {
        final hour = components.get("hour");
        if (hour >= 6 && hour < 12) {
          components.assign("hour", components.get("hour") + 12);
          components.assign("meridiem", Meridiem.PM);
        } else if (hour < 6) {
          components.assign("meridiem", Meridiem.AM);
        }
      }
      if (match[0].endsWith("afternoon")) {
        components.assign("meridiem", Meridiem.PM);
        final hour = components.get("hour");
        if (hour >= 0 && hour <= 6) {
          components.assign("hour", components.get("hour") + 12);
        }
      }
      if (match[0].endsWith("morning")) {
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

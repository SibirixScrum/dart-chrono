import "package:chrono/ported/RegExpMatchArray.dart";

import "../../../chrono.dart" show ParsingContext;
import "../../../common/parsers/AbstractTimeExpressionParser.dart"
    show AbstractTimeExpressionParser;
import "../../../results.dart" show ParsingComponents;
import "../../../types.dart" show Component, Meridiem;
import "../constants.dart" show REGEX_PARTS;

class RUTimeExpressionParser extends AbstractTimeExpressionParser {
  RUTimeExpressionParser(strictMode) : super(strictMode) {
    /* super call moved to initializer */;
  }

  @override
  String patternFlags() {
    return REGEX_PARTS["flags"]!;
  }

  @override
  String primaryPatternLeftBoundary() {
    return '''(^|\\s|T|(?:[^\\p{L}\\p{N}_]))''';
  }

  @override
  String followingPhase() {
    return '''\\s*(?:\\-|\\–|\\~|\\〜|до|и|по|\\?)\\s*''';
  }

  @override
  String primaryPrefix() {
    return '''(?:(?:в|с)\\s*)??''';
  }

  @override
  String primarySuffix() {
    return '''(?:\\s*(?:утра|вечера|после полудня))?(?!\\/)${REGEX_PARTS["rightBoundary"]}''';
  }

  @override
  ParsingComponents? extractPrimaryTimeComponents(
      ParsingContext context, RegExpMatchArray match,
      [strict = false]) {
    final components = super.extractPrimaryTimeComponents(context, match);
    if (components != null) {
      if (match[0].endsWith("вечера")) {
        final hour = components.get(Component.hour)!.toInt();
        if (hour >= 6 && hour < 12) {
          components.assign(
              Component.hour, components.get(Component.hour)!.toInt() + 12);
          components.assign(Component.meridiem, Meridiem.PM.index);
        } else if (hour < 6) {
          components.assign(Component.meridiem, Meridiem.AM.index);
        }
      }
      if (match[0].endsWith("после полудня")) {
        components.assign(Component.meridiem, Meridiem.PM.index);
        final hour = components.get(Component.hour)!.toInt();
        if (hour >= 0 && hour <= 6) {
          components.assign(
              Component.hour, components.get(Component.hour)!.toInt() + 12);
        }
      }
      if (match[0].endsWith("утра")) {
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

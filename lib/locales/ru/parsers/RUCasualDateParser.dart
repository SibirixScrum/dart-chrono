import "package:chrono/ported/RegExpMatchArray.dart";

import "../../../chrono.dart" show ParsingContext;
import "../../../common/casualReferences.dart" as references;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../constants.dart" show REGEX_PARTS;

final PATTERN = new RegExp(
    '''(?:с|со)?\\s*(сегодня|вчера|завтра|послезавтра|послепослезавтра|позапозавчера|позавчера)${REGEX_PARTS["rightBoundary"]}''',
    caseSensitive: REGEX_PARTS["flags"]!.contains("i"),
    dotAll: REGEX_PARTS["flags"]!.contains("d"),
    multiLine: REGEX_PARTS["flags"]!.contains("m"),
    unicode: REGEX_PARTS["flags"]!.contains("u"));

class RUCasualDateParser extends AbstractParserWithWordBoundaryChecking {
  String patternLeftBoundary() {
    return REGEX_PARTS["leftBoundary"]!;
  }

  RegExp innerPattern(ParsingContext context) {
    return PATTERN;
  }

  dynamic /* ParsingComponents | ParsingResult */ innerExtract(
      ParsingContext context, RegExpMatchArray match) {
    final lowerText = match[1].toLowerCase();
    final component = context.createParsingComponents();
    switch (lowerText) {
      case "сегодня":
        return references.today(context.reference);
      case "вчера":
        return references.yesterday(context.reference);
      case "завтра":
        return references.tomorrow(context.reference);
      case "послезавтра":
        return references.theDayAfter(context.reference, 2);
      case "послепослезавтра":
        return references.theDayAfter(context.reference, 3);
      case "позавчера":
        return references.theDayBefore(context.reference, 2);
      case "позапозавчера":
        return references.theDayBefore(context.reference, 3);
    }
    return component;
  }
}

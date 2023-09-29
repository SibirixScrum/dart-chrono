import "package:chrono/ported/RegExpMatchArray.dart";
import "package:chrono/ported/StringUtils.dart";

import "../../chrono.dart" show Parser, ParsingContext;

/**
 *
 */
abstract class AbstractParserWithWordBoundaryChecking implements Parser {
  RegExp innerPattern(ParsingContext context);

  dynamic /* ParsingComponents | ParsingResult | dynamic | null */ innerExtract(
      ParsingContext context, RegExpMatchArray match);

  RegExp? cachedInnerPattern;

  RegExp? cachedPattern;

  String patternLeftBoundary() {
    return '''(\\W|^)''';
  }

  @override
  RegExp pattern(ParsingContext context) {
    final innerPattern = this.innerPattern(context);
    if (innerPattern == cachedInnerPattern) {
      return cachedPattern!; //todo поставил просто так !, разобраться после теста
    }
    cachedPattern = RegExp(
        '''${patternLeftBoundary()}${innerPattern.pattern}''',
        multiLine: innerPattern.isMultiLine,
        caseSensitive: innerPattern.isCaseSensitive,
        dotAll: innerPattern.isDotAll,
        unicode: innerPattern.isUnicode);
    cachedInnerPattern = innerPattern;
    return cachedPattern!;
  }

  @override
  extract(ParsingContext context, RegExpMatchArray match) {
    final header = match[1];
    match.index = match.index + header.length;
    match.matches[0] = match.matches[0]!.substringTs(header.length);
    for (var i = 2; i < match.matches.length; i++) {
      match.matches[i - 1] = match.matches[i];
    }
    return innerExtract(context, match);
  }
}

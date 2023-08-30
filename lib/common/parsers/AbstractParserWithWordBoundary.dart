import "../../chrono.dart" show Parser, ParsingContext;
import "../../results.dart" show ParsingComponents, ParsingResult;
import "../../types.dart" show Component;

/**
 *
 */
abstract class AbstractParserWithWordBoundaryChecking implements Parser {
  RegExp innerPattern(ParsingContext context);

  dynamic /* ParsingComponents | ParsingResult | dynamic | null */ innerExtract(
      ParsingContext context, RegExpMatchArray match);

  RegExp? cachedInnerPattern = null;

  RegExp? cachedPattern = null;

  String patternLeftBoundary() {
    return '''(\\W|^)''';
  }

  RegExp pattern(ParsingContext context) {
    final innerPattern = this.innerPattern(context);
    if (innerPattern == this.cachedInnerPattern) {
      return this
          .cachedPattern!; //todo поставил просто так !, разобраться после теста
    }
    this.cachedPattern = new RegExp(
        '''${this.patternLeftBoundary()}${innerPattern.pattern}''',
        multiLine: innerPattern.isMultiLine,
        caseSensitive: innerPattern.isCaseSensitive,
        dotAll: innerPattern.isDotAll,
        unicode: innerPattern
            .isUnicode); //todo флаги встроенного в дарт RegExp не совпадают с флагами в ts
    this.cachedInnerPattern = innerPattern;
    return this.cachedPattern!;
  }

  extract(ParsingContext context, RegExpMatchArray match) {
    final header = match[1] ?? "";
    match.index = match.index + header.length;
    match[0] = match[0].substring(header.length);
    for (var i = 2; i < match.length; i++) {
      match[i - 1] = match[i];
    }
    return this.innerExtract(context, match);
  }
}

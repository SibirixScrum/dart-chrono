import "../../../chrono.dart" show ParsingContext;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../../../common/casualReferences.dart" as casualReferences;

final PATTERN = new RegExp(
    r'(?:this)?\s{0,3}(morning|afternoon|evening|night|midnight|midday|noon)(?=\W|$)',
    caseSensitive: false);

class ENCasualTimeParser extends AbstractParserWithWordBoundaryChecking {
  innerPattern() {
    return PATTERN;
  }

  innerExtract(ParsingContext context, RegExpMatchArray match) {
    switch (match[1].toLowerCase()) {
      case "afternoon":
        return casualReferences.afternoon(context.reference);
      case "evening":
      case "night":
        return casualReferences.evening(context.reference);
      case "midnight":
        return casualReferences.midnight(context.reference);
      case "morning":
        return casualReferences.morning(context.reference);
      case "noon":
      case "midday":
        return casualReferences.noon(context.reference);
    }
    return null;
  }
}

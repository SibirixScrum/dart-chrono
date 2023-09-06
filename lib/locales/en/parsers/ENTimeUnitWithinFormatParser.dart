import "package:chrono/ported/RegExpMatchArray.dart";

import "../../../chrono.dart" show ParsingContext;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../../../results.dart" show ParsingComponents;
import "../constants.dart"
    show TIME_UNITS_PATTERN, parseTimeUnits, TIME_UNITS_NO_ABBR_PATTERN;

final PATTERN_WITHOUT_PREFIX = new RegExp(
    '''(?:(?:about|around|roughly|approximately|just)\\s*(?:~\\s*)?)?(${TIME_UNITS_PATTERN})(?=\\W|\$)''',
    caseSensitive: false);
final PATTERN_WITH_PREFIX = new RegExp(
    '''(?:within|in|for)\\s*''' +
        '''(?:(?:about|around|roughly|approximately|just)\\s*(?:~\\s*)?)?(${TIME_UNITS_PATTERN})(?=\\W|\$)''',
    caseSensitive: false);
final PATTERN_WITH_PREFIX_STRICT = new RegExp(
    '''(?:within|in|for)\\s*''' +
        '''(?:(?:about|around|roughly|approximately|just)\\s*(?:~\\s*)?)?(${TIME_UNITS_NO_ABBR_PATTERN})(?=\\W|\$)''',
    caseSensitive: false);

class ENTimeUnitWithinFormatParser
    extends AbstractParserWithWordBoundaryChecking {
  bool strictMode;

  ENTimeUnitWithinFormatParser(this.strictMode) : super() {
    /* super call moved to initializer */;
  }

  RegExp innerPattern(ParsingContext context) {
    if (this.strictMode) {
      return PATTERN_WITH_PREFIX_STRICT;
    }
    return context.option?.forwardDate == true
        ? PATTERN_WITHOUT_PREFIX
        : PATTERN_WITH_PREFIX;
  }

  ParsingComponents innerExtract(
      ParsingContext context, RegExpMatchArray match) {
    final timeUnits = parseTimeUnits(match[1]);
    return ParsingComponents.createRelativeFromReference(
        context.reference, timeUnits);
  }
}

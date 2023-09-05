import "package:chrono/ported/RegExpMatchArray.dart";

import "../../../chrono.dart" show ParsingContext;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../../../results.dart" show ParsingComponents;
import "../../../utils/timeunits.dart" show reverseTimeUnits;
import "../constants.dart" show parseTimeUnits, REGEX_PARTS, TIME_UNITS_PATTERN;

final PATTERN = new RegExp(
    '''(${TIME_UNITS_PATTERN})\\s{0,5}назад(?=(?:\\W|\$))''',
    caseSensitive: !REGEX_PARTS["flags"]!.contains("i"),
    dotAll: REGEX_PARTS["flags"]!.contains("d"),
    multiLine: REGEX_PARTS["flags"]!.contains("m"),
    unicode: REGEX_PARTS["flags"]!.contains("u"));

class RUTimeUnitAgoFormatParser extends AbstractParserWithWordBoundaryChecking {
  String patternLeftBoundary() {
    return REGEX_PARTS["leftBoundary"]!;
  }

  RegExp innerPattern(ParsingContext context) {
    return PATTERN;
  }

  innerExtract(ParsingContext context, RegExpMatchArray match) {
    final timeUnits = parseTimeUnits(match[1]);
    final outputTimeUnits = reverseTimeUnits(timeUnits);
    return ParsingComponents.createRelativeFromReference(
        context.reference, outputTimeUnits);
  }
}

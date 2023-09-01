import "package:chrono/ported/RegExpMatchArray.dart";

import "../../../chrono.dart" show ParsingContext;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../../../results.dart" show ParsingComponents;
import "../../../utils/timeunits.dart" show reverseTimeUnits;
import "../constants.dart" show TIME_UNITS_PATTERN, parseTimeUnits, REGEX_PARTS;

final PATTERN = new RegExp(
    '''(эти|последние|прошлые|следующие|после|спустя|через|\\+|-)\\s*(${TIME_UNITS_PATTERN})${REGEX_PARTS["rightBoundary"]}''',
    caseSensitive: REGEX_PARTS["flags"]!.contains("i"),
    dotAll: REGEX_PARTS["flags"]!.contains("d"),
    multiLine: REGEX_PARTS["flags"]!.contains("m"),
    unicode: REGEX_PARTS["flags"]!.contains("u"));

class RUTimeUnitCasualRelativeFormatParser
    extends AbstractParserWithWordBoundaryChecking {
  String patternLeftBoundary() {
    return REGEX_PARTS["leftBoundary"]!;
  }

  RegExp innerPattern(ParsingContext context) {
    return PATTERN;
  }

  ParsingComponents innerExtract(
      ParsingContext context, RegExpMatchArray match) {
    final prefix = match[1].toLowerCase();
    var timeUnits = parseTimeUnits(match[2]);
    switch (prefix) {
      case "последние":
      case "прошлые":
      case "-":
        timeUnits = reverseTimeUnits(timeUnits);
        break;
    }
    return ParsingComponents.createRelativeFromReference(
        context.reference, timeUnits);
  }
}

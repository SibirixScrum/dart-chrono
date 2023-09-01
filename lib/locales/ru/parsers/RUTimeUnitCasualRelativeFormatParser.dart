import "../constants.dart" show TIME_UNITS_PATTERN, parseTimeUnits, REGEX_PARTS;
import "../../../chrono.dart" show ParsingContext;
import "../../../results.dart" show ParsingComponents;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../../../utils/timeunits.dart" show reverseTimeUnits;

final PATTERN = new RegExp(
    '''(эти|последние|прошлые|следующие|после|спустя|через|\\+|-)\\s*(${ TIME_UNITS_PATTERN})${ REGEX_PARTS . rightBoundary}''',
    REGEX_PARTS.flags);

class RUTimeUnitCasualRelativeFormatParser
    extends AbstractParserWithWordBoundaryChecking {
  String patternLeftBoundary() {
    return REGEX_PARTS.leftBoundary;
  }

  RegExp innerPattern() {
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

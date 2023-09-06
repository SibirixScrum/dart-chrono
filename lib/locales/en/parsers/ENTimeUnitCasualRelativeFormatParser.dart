import "package:chrono/ported/RegExpMatchArray.dart";

import "../constants.dart"
    show TIME_UNITS_PATTERN, parseTimeUnits, TIME_UNITS_NO_ABBR_PATTERN;
import "../../../chrono.dart" show ParsingContext;
import "../../../results.dart" show ParsingComponents;
import "../../../common/parsers/AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "../../../utils/timeunits.dart" show reverseTimeUnits;

final PATTERN = new RegExp(
    '''(this|last|past|next|after|\\+|-)\\s*(${ TIME_UNITS_PATTERN})(?=\\W|\$)''',
    caseSensitive: false);
final PATTERN_NO_ABBR = new RegExp(
    '''(this|last|past|next|after|\\+|-)\\s*(${ TIME_UNITS_NO_ABBR_PATTERN})(?=\\W|\$)''',
    caseSensitive: false);

class ENTimeUnitCasualRelativeFormatParser
    extends AbstractParserWithWordBoundaryChecking {
  bool allowAbbreviations;
  ENTimeUnitCasualRelativeFormatParser([this.allowAbbreviations = true])
      : super() {
    /* super call moved to initializer */;
  }
  RegExp innerPattern(ParsingContext context) {
    return this.allowAbbreviations ? PATTERN : PATTERN_NO_ABBR;
  }

  ParsingComponents innerExtract(
      ParsingContext context, RegExpMatchArray match) {
    final prefix = match[1].toLowerCase();
    var timeUnits = parseTimeUnits(match[2]);
    switch (prefix) {
      case "last":
      case "past":
      case "-":
        timeUnits = reverseTimeUnits(timeUnits);
        break;
    }
    return ParsingComponents.createRelativeFromReference(
        context.reference, timeUnits);
  }
}

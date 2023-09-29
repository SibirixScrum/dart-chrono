import "package:chrono/ported/ParseInt.dart";
import "package:chrono/ported/RegExpMatchArray.dart";
import "package:chrono/types.dart";

import "../../chrono.dart" show ParsingContext;
import "AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
// ISO 8601

// http://www.w3.org/TR/NOTE-datetime

// - YYYY-MM-DD

// - YYYY-MM-DDThh:mmTZD

// - YYYY-MM-DDThh:mm:ssTZD

// - YYYY-MM-DDThh:mm:ss.sTZD

// - TZD = (Z or +hh:mm or -hh:mm)

// prettier-ignore
final PATTERN = RegExp(
    "([0-9]{2,4})\\-([0-9]{1,2})\\-([0-9]{1,2})(?:T([0-9]{1,2}):([0-9]{1,2})(?::([0-9]{1,2})(?:\\.(\\d{1,4}))?)?(?:Z|([+-]\\d{2}):?(\\d{2})?)?)?(?=\\W|\$)",
    caseSensitive: false);
const YEAR_NUMBER_GROUP = 1;
const MONTH_NUMBER_GROUP = 2;
const DATE_NUMBER_GROUP = 3;
const HOUR_NUMBER_GROUP = 4;
const MINUTE_NUMBER_GROUP = 5;
const SECOND_NUMBER_GROUP = 6;
const MILLISECOND_NUMBER_GROUP = 7;
const TZD_HOUR_OFFSET_GROUP = 8;
const TZD_MINUTE_OFFSET_GROUP = 9;

class ISOFormatParser extends AbstractParserWithWordBoundaryChecking {
  @override
  RegExp innerPattern(ParsingContext context) {
    return PATTERN;
  }

  // RegExp innerPattern() {
  //   return PATTERN;
  // }

  @override
  innerExtract(ParsingContext context, RegExpMatchArray match) {
    final Map<Component, num> components = {};
    int year = parseIntTs(match[YEAR_NUMBER_GROUP]);
    if (year < 50 || year >= 100 && year <= 999) {
      //most likely not year
      return null;
    }
    if (year >= 50 && year <= 99) {
      year += 1900;
    }
    components[Component.year] = year;
    int month = parseIntTs(match[MONTH_NUMBER_GROUP]);
    int day = parseIntTs(match[DATE_NUMBER_GROUP]);
    if (month < 1 || month > 12) {
      if (month > 12) {
        if (day >= 1 && day <= 12 && month <= 31) {
          final temp = month;
          month = day;
          day = temp;
        } else {
          return null;
        }
      }
    }
    components[Component.month] = month;
    components[Component.day] = day;
    if (match[HOUR_NUMBER_GROUP].isNotEmpty) {
      components[Component.hour] = parseIntTs(match[HOUR_NUMBER_GROUP]);
      components[Component.minute] = parseIntTs(match[MINUTE_NUMBER_GROUP]);
      if (match[SECOND_NUMBER_GROUP].isNotEmpty) {
        components[Component.second] = parseIntTs(match[SECOND_NUMBER_GROUP]);
      }
      if (match[MILLISECOND_NUMBER_GROUP].isNotEmpty) {
        components[Component.millisecond] =
            parseIntTs(match[MILLISECOND_NUMBER_GROUP]);
      }
      if (match[TZD_HOUR_OFFSET_GROUP].isEmpty) {
        components[Component.timezoneOffset] = 0;
      } else {
        final hourOffset = parseIntTs(match[TZD_HOUR_OFFSET_GROUP]);
        var minuteOffset = 0;
        if (match[TZD_MINUTE_OFFSET_GROUP].isNotEmpty) {
          minuteOffset = parseIntTs(match[TZD_MINUTE_OFFSET_GROUP]);
        }
        var offset = hourOffset * 60;
        if (offset < 0) {
          offset -= minuteOffset;
        } else {
          offset += minuteOffset;
        }
        components[Component.timezoneOffset] = offset;
      }
    }
    return components;
  }
}

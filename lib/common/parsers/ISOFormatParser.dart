import "../../chrono.dart" show ParsingContext;
import "../../types.dart" show Component;
import "AbstractParserWithWordBoundary.dart"
    show AbstractParserWithWordBoundaryChecking;
import "package:chrono/ported/RegExpMatchArray.dart";
// ISO 8601

// http://www.w3.org/TR/NOTE-datetime

// - YYYY-MM-DD

// - YYYY-MM-DDThh:mmTZD

// - YYYY-MM-DDThh:mm:ssTZD

// - YYYY-MM-DDThh:mm:ss.sTZD

// - TZD = (Z or +hh:mm or -hh:mm)

// prettier-ignore
final PATTERN = new RegExp(
    "([0-9]{4})\\-([0-9]{1,2})\\-([0-9]{1,2})" +
        "(?:T" +
        "([0-9]{1,2}):([0-9]{1,2})" +
        "(?:" +
        ":([0-9]{1,2})(?:\\.(\\d{1,4}))?" +
        ")?" +
        "(?:" +
        "Z|([+-]\\d{2}):?(\\d{2})?" +
        ")?" +
        ")?" +
        "(?=\\W|\$)",
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

  innerExtract(ParsingContext context, RegExpMatchArray match) {
    final dynamic components = {};
    components["year"] = int.parse(match[YEAR_NUMBER_GROUP]);
    components["month"] = int.parse(match[MONTH_NUMBER_GROUP]);
    components["day"] = int.parse(match[DATE_NUMBER_GROUP]);
    if (match[HOUR_NUMBER_GROUP] != null) {
      components["hour"] = int.parse(match[HOUR_NUMBER_GROUP]);
      components["minute"] = int.parse(match[MINUTE_NUMBER_GROUP]);
      if (match[SECOND_NUMBER_GROUP] != null) {
        components["second"] = int.parse(match[SECOND_NUMBER_GROUP]);
      }
      if (match[MILLISECOND_NUMBER_GROUP] != null) {
        components["millisecond"] = int.parse(match[MILLISECOND_NUMBER_GROUP]);
      }
      if (match[TZD_HOUR_OFFSET_GROUP] == null) {
        components["timezoneOffset"] = 0;
      } else {
        final hourOffset = int.parse(match[TZD_HOUR_OFFSET_GROUP]);
        var minuteOffset = 0;
        if (match[TZD_MINUTE_OFFSET_GROUP] != null) {
          minuteOffset = int.parse(match[TZD_MINUTE_OFFSET_GROUP]);
        }
        var offset = hourOffset * 60;
        if (offset < 0) {
          offset -= minuteOffset;
        } else {
          offset += minuteOffset;
        }
        components["timezoneOffset"] = offset;
      }
    }
    return components;
  }


}

import "../../chrono.dart" show ParsingContext, Refiner;
import "../../results.dart" show ParsingResult;

final TIMEZONE_OFFSET_PATTERN = new RegExp(
    "^\\s*(?:\\(?(?:GMT|UTC)\\s?)?([+-])(\\d{1,2})(?::?(\\d{2}))?\\)?", "i");
const TIMEZONE_OFFSET_SIGN_GROUP = 1;
const TIMEZONE_OFFSET_HOUR_OFFSET_GROUP = 2;
const TIMEZONE_OFFSET_MINUTE_OFFSET_GROUP = 3;

class ExtractTimezoneOffsetRefiner implements Refiner {
  List<ParsingResult> refine(
      ParsingContext context, List<ParsingResult> results) {
    results.forEach((result) {
      if (result.start.isCertain("timezoneOffset")) {
        return;
      }
      final suffix = context.text.substring(result.index + result.text.length);
      final match = TIMEZONE_OFFSET_PATTERN.exec(suffix);
      if (!match) {
        return;
      }
      context.debug(() {
        console.log(
            '''Extracting timezone: \'${ match [ 0 ]}\' into : ${ result}''');
      });
      final hourOffset = parseInt(match[TIMEZONE_OFFSET_HOUR_OFFSET_GROUP]);
      final minuteOffset =
          parseInt(match[TIMEZONE_OFFSET_MINUTE_OFFSET_GROUP] || "0");
      var timezoneOffset = hourOffset * 60 + minuteOffset;
      // No timezones have offsets greater than 14 hours, so disregard this match
      if (timezoneOffset > 14 * 60) {
        return;
      }
      if (identical(match[TIMEZONE_OFFSET_SIGN_GROUP], "-")) {
        timezoneOffset = -timezoneOffset;
      }
      if (result.end != null) {
        result.end.assign("timezoneOffset", timezoneOffset);
      }
      result.start.assign("timezoneOffset", timezoneOffset);
      result.text += match[0];
    });
    return results;
  }
}

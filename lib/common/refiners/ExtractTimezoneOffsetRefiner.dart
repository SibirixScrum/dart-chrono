import "package:chrono/ported/ParseInt.dart";
import "package:chrono/ported/RegExpMatchArray.dart";
import "package:chrono/ported/StringUtils.dart";
import "package:chrono/types.dart";

import "../../chrono.dart" show ParsingContext, Refiner;
import "../../results.dart" show ParsingResult;

final TIMEZONE_OFFSET_PATTERN = RegExp(
    "^\\s*(?:\\(?(?:GMT|UTC)\\s?)?([+-])(\\d{1,2})(?::?(\\d{2}))?\\)?",
    caseSensitive: false);
const TIMEZONE_OFFSET_SIGN_GROUP = 1;
const TIMEZONE_OFFSET_HOUR_OFFSET_GROUP = 2;
const TIMEZONE_OFFSET_MINUTE_OFFSET_GROUP = 3;

class ExtractTimezoneOffsetRefiner implements Refiner {
  List<ParsingResult> refine(
      ParsingContext context, List<ParsingResult> results) {
    for (var result in results) {
      if (result.start.isCertain(Component.timezoneOffset)) {
        continue;
      }
      final suffix = context.text.substringTs(result.index + result.text.length);
      final match = TIMEZONE_OFFSET_PATTERN.exec(suffix);
      if (match == null || match.matches.isEmpty) {
        continue;
      }
      context.debug(() {
        print('''Extracting timezone: \'${match[0]}\' into : ${result}''');
      });
      final hourOffset = parseIntTs(
          match[TIMEZONE_OFFSET_HOUR_OFFSET_GROUP]); //todo check size?
      final minuteOffset = match[TIMEZONE_OFFSET_MINUTE_OFFSET_GROUP].isNotEmpty
          ? parseIntTs(match[TIMEZONE_OFFSET_MINUTE_OFFSET_GROUP])
          : 0;
      var timezoneOffset = hourOffset * 60 + minuteOffset;
      // No timezones have offsets greater than 14 hours, so disregard this match
      if (timezoneOffset > 14 * 60) {
        continue;
      }
      if (match[TIMEZONE_OFFSET_SIGN_GROUP] == "-") {
        timezoneOffset = -timezoneOffset;
      }
      if (result.end != null) {
        result.end!.assign(Component.timezoneOffset, timezoneOffset);
      }
      result.start.assign(Component.timezoneOffset, timezoneOffset);
      result.text += match[0];
    }
    return results;
  }
}

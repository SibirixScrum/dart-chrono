import 'package:chrono/locales/en/index.dart' as en;
import 'package:chrono/timezone.dart';
import 'package:chrono/types.dart';
import "package:flutter_test/flutter_test.dart";

import '../test_util.dart';

 void main() {
  test("Test - Parsing date/time with UTC offset", () {
   testSingleCase(
        en.casual, "wednesday, september 16, 2020 at 11 am utc+02:45 ",
        (ParsedResult result, String text) {
      expect(result.text, "wednesday, september 16, 2020 at 11 am utc+02:45");
      expect(result.start.get(Component.hour), 11);
      expect(result.start.get(Component.minute), 0);
      expect(result.start.get(Component.timezoneOffset), 2 * 60 + 45);
    });
   testSingleCase(
        en.casual, "wednesday, september 16, 2020 at 11 am utc+0245 ",
        (ParsedResult result, String text) {
      expect(result.text, "wednesday, september 16, 2020 at 11 am utc+0245");
      expect(result.start.get(Component.hour), 11);
      expect(result.start.get(Component.minute), 0);
      expect(result.start.get(Component.timezoneOffset), 2 * 60 + 45);
    });
   testSingleCase(en.casual, "wednesday, september 16, 2020 at 11 am utc+02 ",
        (ParsedResult result, String text) {
      expect(result.text, "wednesday, september 16, 2020 at 11 am utc+02");
      expect(result.start.get(Component.hour), 11);
      expect(result.start.get(Component.minute), 0);
      expect(result.start.get(Component.timezoneOffset), 2 * 60);
    });
  });
  test("Test - Parsing date/time with numeric offset", () {
   testSingleCase(en.casual, "wednesday, september 16, 2020 at 23.00+14",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.isCertain(Component.timezoneOffset), true);
      expect(result.start.get(Component.timezoneOffset), 14 * 60);
    });
   testSingleCase(en.casual, "wednesday, september 16, 2020 at 23.00+1400",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.isCertain(Component.timezoneOffset), true);
      expect(result.start.get(Component.timezoneOffset), 14 * 60);
    });
   testSingleCase(en.casual, "wednesday, september 16, 2020 at 23.00+15",
        (ParsedResult result, String text) {
      expect(result.text, "wednesday, september 16, 2020 at 23.00");
      expect(result.start.isCertain(Component.timezoneOffset), false);
    });
  });
  test("Test - Parsing date/time with GMT offset", () {
   testSingleCase(
        en.casual, "wednesday, september 16, 2020 at 11 am GMT -08:45 ",
        (ParsedResult result, String text) {
      expect(result.text, "wednesday, september 16, 2020 at 11 am GMT -08:45");
      expect(result.start.get(Component.hour), 11);
      expect(result.start.get(Component.minute), 0);
      expect(result.start.get(Component.timezoneOffset), -(8 * 60 + 45));
    });
    testSingleCase(en.casual, "wednesday, september 16, 2020 at 11 am gmt+02 ",
        (ParsedResult result, String text) {
      expect(result.text, "wednesday, september 16, 2020 at 11 am gmt+02");
      expect(result.start.get(Component.hour), 11);
      expect(result.start.get(Component.minute), 0);
      expect(result.start.get(Component.timezoneOffset), 2 * 60);
    });
    testSingleCase(en.casual, "published: 10:30 (gmt-2:30).",
        (ParsedResult result, String text) {
      expect(result.text, "10:30 (gmt-2:30)");
      expect(result.start.get(Component.hour), 10);
      expect(result.start.get(Component.minute), 30);
      expect(result.start.get(Component.timezoneOffset), -(2 * 60 + 30));
    });
  });
  test("Test - Parsing date/time with timezone abbreviation", () {
   testSingleCase(en.casual, "wednesday, september 16, 2020 at 11 am",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2020);
      expect(result.start.get(Component.month), 9);
      expect(result.start.get(Component.day), 16);
      expect(result.start.get(Component.hour), 11);
      expect(result.start.get(Component.minute), 0);
      expect(result.start.get(Component.timezoneOffset), null);
    });
   testSingleCase(en.casual, "wednesday, september 16, 2020 at 11 am JST",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2020);
      expect(result.start.get(Component.month), 9);
      expect(result.start.get(Component.day), 16);
      expect(result.start.get(Component.hour), 11);
      expect(result.start.get(Component.minute), 0);
      // JST: GMT+9:00
      expect(result.start.get(Component.timezoneOffset), 9 * 60);
    });
   testSingleCase(
        en.casual, "wednesday, september 16, 2020 at 11 am GMT+0900 (JST)",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2020);
      expect(result.start.get(Component.month), 9);
      expect(result.start.get(Component.day), 16);
      expect(result.start.get(Component.hour), 11);
      expect(result.start.get(Component.minute), 0);
      // JST: GMT+9:00
      expect(result.start.get(Component.timezoneOffset), 9 * 60);
    });
   testSingleCase(en.casual, "10:30 pst today", DateTime(2016, 10 , 1, 8),
        (ParsedResult result, String text) {
      expect(result.text, "10:30 pst today");
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.day), 1);
      expect(result.start.get(Component.hour), 10);
      expect(result.start.get(Component.minute), 30);
      // PST: UTC−08:00
      expect(result.start.get(Component.timezoneOffset), -8 * 60);
    });
  });
  test("Test - Parsing date range with timezone abbreviation", () {
   testSingleCase(en.casual, "10:30 JST today to 10:30 pst tomorrow ",
        DateTime(2016, 10 , 1, 8), (ParsedResult result, String text) {
      expect(result.text, "10:30 JST today to 10:30 pst tomorrow");
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.day), 1);
      expect(result.start.get(Component.hour), 10);
      expect(result.start.get(Component.minute), 30);
      expect(result.start.get(Component.timezoneOffset), 9 * 60);
      expect(result.end!.get(Component.year), 2016);
      expect(result.end!.get(Component.month), 10);
      expect(result.end!.get(Component.day), 2);
      expect(result.end!.get(Component.hour), 10);
      expect(result.end!.get(Component.minute), 30);
      expect(result.end!.get(Component.timezoneOffset), -8 * 60);
    });
  });
  test("Test - Parsing date/time with ambiguous timezone abbreviations", () {
    // Test dates around transition to DST for ET
    testSingleCase(en.casual, "2022-03-12 23:00 ET",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.hour), 23);
      expect(result.start.get(Component.timezoneOffset), -5 * 60);
    });
    testSingleCase(en.casual, "2022-03-13 23:00 ET",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.hour), 23);
      expect(result.start.get(Component.timezoneOffset), -4 * 60);
    });
    testSingleCase(en.casual, "2021-03-13 23:00 ET",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.hour), 23);
      expect(result.start.get(Component.timezoneOffset), -5 * 60);
    });
    testSingleCase(en.casual, "2021-03-14 23:00 ET",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.hour), 23);
      expect(result.start.get(Component.timezoneOffset), -4 * 60);
    });
    // Also test around transition *from* DST
    testSingleCase(en.casual, "2021-11-06 23:00 ET",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.hour), 23);
      expect(result.start.get(Component.timezoneOffset), -4 * 60);
    });
    testSingleCase(en.casual, "2021-11-07 23:00 ET",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.hour), 23);
      expect(result.start.get(Component.timezoneOffset), -5 * 60);
    });
    testSingleCase(en.casual, "2020-10-31 23:00 ET",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.hour), 23);
      expect(result.start.get(Component.timezoneOffset), -4 * 60);
    });
    testSingleCase(en.casual, "2020-11-01 23:00 ET",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.hour), 23);
      expect(result.start.get(Component.timezoneOffset), -5 * 60);
    });
    // Same checks, but for CET (which transitions at different dates with different rules)

    // Test dates around transition to DST for CET
    testSingleCase(en.casual, "2022-03-26 23:00 CET",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.hour), 23);
      expect(result.start.get(Component.timezoneOffset), 60);
    });
    testSingleCase(en.casual, "2022-03-27 23:00 CET",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.hour), 23);
      expect(result.start.get(Component.timezoneOffset), 2 * 60);
    });
    testSingleCase(en.casual, "2021-03-27 23:00 CET",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.hour), 23);
      expect(result.start.get(Component.timezoneOffset), 60);
    });
    testSingleCase(en.casual, "2021-03-28 23:00 CET",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.hour), 23);
      expect(result.start.get(Component.timezoneOffset), 2 * 60);
    });
    // Also test around transition *from* DST for CET
    testSingleCase(en.casual, "2022-10-29 23:00 CET",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.hour), 23);
      expect(result.start.get(Component.timezoneOffset), 2 * 60);
    });
    testSingleCase(en.casual, "2022-10-30 23:00 CET",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.hour), 23);
      expect(result.start.get(Component.timezoneOffset), 60);
    });
    testSingleCase(en.casual, "2021-10-30 23:00 CET",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.hour), 23);
      expect(result.start.get(Component.timezoneOffset), 2 * 60);
    });
    testSingleCase(en.casual, "2021-10-31 23:00 CET",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.hour), 23);
      expect(result.start.get(Component.timezoneOffset), 60);
    });
  });
  test("Test - Timezone parsing overrides", () {
    // en.casual.parse('at 10:00 XYZ', DateTime(2023, 3, 20), {timezones: {XYZ: -180}})

    // XYZ shouldn't be recognized or parsed as a timezone
    testSingleCase(en.casual, "Jan 1st 2023 at 10:00 XYZ",
        (ParsedResult result, String text) {
      expect(result.text, "Jan 1st 2023 at 10:00");
      expectToBeDate(result.start, DateTime(2023, 1, 1, 10));
    });
    // Parse the correct tzoffset when XYZ is provided as a custom tz in parsingOptions
    testSingleCase(en.casual, "Jan 1st 2023 at 10:00 XYZ", DateTime(2023, 1, 1),
        ParsingOption(timezones: {"XYZ": -180}),
        (ParsedResult result, String text) {
      expect(result.text, "Jan 1st 2023 at 10:00 XYZ");
      expect(result.start.get(Component.timezoneOffset), -180);
    });
    // Parse the correct tzoffset when XYZ is provided as a custom ambiguous tz in parsingOptions
    final parseXYZAsAmbiguousTz = AmbiguousTimezoneMap(
      timezoneOffsetDuringDst: -2 * 60,
      timezoneOffsetNonDst: -3 * 60,
      dstStart: (num year) =>
          getLastWeekdayOfMonth(year, Month.MARCH, Weekday.SUNDAY, 2),
      dstEnd: (num year) =>
          getLastWeekdayOfMonth(year, Month.NOVEMBER, Weekday.SUNDAY, 3),
    );
    // {
    //   "timezoneOffsetDuringDst": -120,
    //   "timezoneOffsetNonDst": -180,
    //   "dstStart": (num year) =>
    //       getLastWeekdayOfMonth(year, Month.MARCH, Weekday.SUNDAY, 2),
    //   "dstEnd": (num year) =>
    //       getLastWeekdayOfMonth(year, Month.OCTOBER, Weekday.SUNDAY, 3)
    // };
    // Parsing a non-DST date
    testSingleCase(en.casual, "Jan 1st 2023 at 10:00 XYZ", DateTime(2023, 1, 1),
        ParsingOption(timezones: {"XYZ": parseXYZAsAmbiguousTz}),
        (ParsedResult result, String text) {
      expect(result.text, "Jan 1st 2023 at 10:00 XYZ");
      expect(result.start.get(Component.timezoneOffset), -180);
    });
    // Parsing a DST date
    testSingleCase(en.casual, "Jun 1st 2023 at 10:00 XYZ", DateTime(2023, 1, 1),
        ParsingOption(timezones: {"XYZ": parseXYZAsAmbiguousTz}),
        (ParsedResult result, String text) {
      expect(result.text, "Jun 1st 2023 at 10:00 XYZ");
      expect(result.start.get(Component.timezoneOffset), -120);
    });
  });
  test("Test - Parsing date with timezone abbreviation", () {
    testSingleCase(en.casual, "Wednesday, September 16, 2020, EST",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.timezoneOffset), -300);
    });
  });
  test("Test - Not parsing timezone from relative time", () {
   {
    final refInstant =
          DateTime.parse("2020-11-29T13:24:13+0900");
    final expectedInstant =
          DateTime.parse("2020-11-29T14:24:13+0900");
    testSingleCase(en.casual, "in 1 hour get eggs and milk", refInstant,
          (ParsedResult result, String text) {
        expect(result.text, "in 1 hour");
        expect(result.start.get(Component.timezoneOffset),
            -refInstant.timeZoneOffset.inMinutes);
        expectToBeDate(result.start , expectedInstant);
      });
   }
   {
    final refInstant =
          DateTime.parse("2020-11-29T13:24:13+0900");
      final expectedInstant =
          DateTime.parse("2020-11-29T14:24:13+0900");
      testSingleCase(en.casual, "in 1 hour GMT", refInstant,
          (ParsedResult result, String text) {
        // expect(result.text , "in 1 hour"); known issue when running test in the GMT time
        expectToBeDate(result.start , expectedInstant);
      });
    }
   {
    final refInstant =
          DateTime.parse("2020-11-29T13:24:13+0900");
    final expectedInstant =
          DateTime.parse("2020-11-29T14:24:13+0900");
    testSingleCase(
          en.casual, "in 1 hour GMT", ParsingReference(refInstant, "JST"),
          (result, text) {
        // expect(result.text , "in 1 hour");
        expectToBeDate(result.start, expectedInstant);
      });
   }
   {
    final refInstant =
          DateTime.parse("2020-11-29T13:24:13+0900");
    final expectedInstant =
          DateTime.parse("2020-11-29T14:24:13+0900");
    testSingleCase(
        en.casual, "in 1 hour GMT", ParsingReference(refInstant, "BST"),
          (result, text) {
        // expect(result.text , "in 1 hour");
        expectToBeDate(result.start, expectedInstant);
      });
   }
  });
  test("Test - Relative time (Now) is not effected by timezone setting", () {
    final refInstant = DateTime.fromMillisecondsSinceEpoch(1637674343000);
    testSingleCase(en.casual, "now", ParsingReference(refInstant),
        (ParsedResult result, String text) {
      expect(result.text, "now");
      expectToBeDate(result.start , refInstant);
    });
    testSingleCase(en.casual, "now", ParsingReference(refInstant,null),
        (ParsedResult result, String text) {
      expect(result.text, "now");
      expectToBeDate(result.start , refInstant);
    });
    testSingleCase(en.casual, "now", ParsingReference(refInstant,"BST"),
        (ParsedResult result, String text) {
      expect(result.text, "now");
      expectToBeDate(result.start , refInstant);
    });
   testSingleCase(en.casual, "now", ParsingReference(refInstant,"JST"),
        (ParsedResult result, String text) {
      expect(result.text, "now");
      expectToBeDate(result.start , refInstant);
    });
  });
  test(
      "Test - Relative time (2 hour later) is not effected by timezone setting", () {
    final refInstant = DateTime.fromMillisecondsSinceEpoch(1637674343000);
    final expectedInstant = DateTime.fromMillisecondsSinceEpoch(1637674343000 + 2 * 60 * 60 * 1000);
    testSingleCase(en.casual, "2 hour later", ParsingReference(refInstant),
        (ParsedResult result, String text) {
      expect(result.text, "2 hour later");
      expectToBeDate(result.start , expectedInstant);
    });
    testSingleCase(
        en.casual, "2 hour later", ParsingReference(refInstant,null),
        (ParsedResult result, String text) {
      expect(result.text, "2 hour later");
      expectToBeDate(result.start , expectedInstant);
    });
    testSingleCase(
        en.casual, "2 hour later", ParsingReference(refInstant,"BST"),
        (ParsedResult result, String text) {
      expect(result.text, "2 hour later");
      expectToBeDate(result.start , expectedInstant);
    });
   testSingleCase(
        en.casual, "2 hour later",ParsingReference(refInstant,"JST"),
        (ParsedResult result, String text) {
      expect(result.text, "2 hour later");
      expectToBeDate(result.start , expectedInstant);
    });
  });
  test("Test - Parsing timezone from relative date when valid", () {
   final refDate = DateTime(2020, 11 , 14, 13, 48, 22);
    testSingleCase(en.casual, "in 1 day get eggs and milk", refDate,
        (ParsedResult result, String text) {
      expect(result.text, "in 1 day");
      expect(result.start.get(Component.timezoneOffset), refDate.timeZoneOffset.inMinutes);
    });
    testSingleCase(en.casual, "in 1 day GET", refDate,
        (ParsedResult result, String text) {
      expect(result.text, "in 1 day GET");
      expect(result.start.get(Component.timezoneOffset), 240);
    });
    testSingleCase(en.casual, "today EST", (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.timezoneOffset), -300);
    });
    testSingleCase(en.casual, "next week EST",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.timezoneOffset), -300);
    });
  });
 }
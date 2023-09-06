import 'package:chrono/locales/en/index.dart' as en;
import "package:flutter_test/flutter_test.dart";
import '../test_util.dart';

 void main() {
  test("Test - Parsing date/time with UTC offset", () {
   testSingleCase(
       en.casual, "wednesday, september 16, 2020 at 11 am utc+02:45 ", (result,
       text) {
    expect(result.text).toBe(
        "wednesday, september 16, 2020 at 11 am utc+02:45");
    expect(result.start.get("hour")).toBe(11);
    expect(result.start.get("minute")).toBe(0);
    expect(result.start.get("timezoneOffset")).toBe(2 * 60 + 45);
   });
   testSingleCase(
       en.casual, "wednesday, september 16, 2020 at 11 am utc+0245 ", (result,
       text) {
    expect(result.text).toBe("wednesday, september 16, 2020 at 11 am utc+0245");
    expect(result.start.get("hour")).toBe(11);
    expect(result.start.get("minute")).toBe(0);
    expect(result.start.get("timezoneOffset")).toBe(2 * 60 + 45);
   });
   testSingleCase(
       en.casual, "wednesday, september 16, 2020 at 11 am utc+02 ", (result,
       text) {
    expect(result.text).toBe("wednesday, september 16, 2020 at 11 am utc+02");
    expect(result.start.get("hour")).toBe(11);
    expect(result.start.get("minute")).toBe(0);
    expect(result.start.get("timezoneOffset")).toBe(2 * 60);
   });
  });
  test("Test - Parsing date/time with numeric offset", () {
   testSingleCase(
       en.casual, "wednesday, september 16, 2020 at 23.00+14", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.isCertain("timezoneOffset")).toBe(true);
    expect(result.start.get("timezoneOffset")).toBe(14 * 60);
   });
   testSingleCase(
       en.casual, "wednesday, september 16, 2020 at 23.00+1400", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.isCertain("timezoneOffset")).toBe(true);
    expect(result.start.get("timezoneOffset")).toBe(14 * 60);
   });
   testSingleCase(
       en.casual, "wednesday, september 16, 2020 at 23.00+15", (result, text) {
    expect(result.text).toBe("wednesday, september 16, 2020 at 23.00");
    expect(result.start.isCertain("timezoneOffset")).toBe(false);
   });
  });
  test("Test - Parsing date/time with GMT offset", () {
   testSingleCase(
       en.casual, "wednesday, september 16, 2020 at 11 am GMT -08:45 ", (result,
       text) {
    expect(result.text).toBe(
        "wednesday, september 16, 2020 at 11 am GMT -08:45");
    expect(result.start.get("hour")).toBe(11);
    expect(result.start.get("minute")).toBe(0);
    expect(result.start.get("timezoneOffset")).toBe(-(8 * 60 + 45));
   });
   testSingleCase(
       en.casual, "wednesday, september 16, 2020 at 11 am gmt+02 ", (result,
       text) {
    expect(result.text).toBe("wednesday, september 16, 2020 at 11 am gmt+02");
    expect(result.start.get("hour")).toBe(11);
    expect(result.start.get("minute")).toBe(0);
    expect(result.start.get("timezoneOffset")).toBe(2 * 60);
   });
   testSingleCase(en.casual, "published: 10:30 (gmt-2:30).", (result, text) {
    expect(result.text).toBe("10:30 (gmt-2:30)");
    expect(result.start.get("hour")).toBe(10);
    expect(result.start.get("minute")).toBe(30);
    expect(result.start.get("timezoneOffset")).toBe(-(2 * 60 + 30));
   });
  });
  test("Test - Parsing date/time with timezone abbreviation", () {
   testSingleCase(
       en.casual, "wednesday, september 16, 2020 at 11 am", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2020);
    expect(result.start.get("month")).toBe(9);
    expect(result.start.get("day")).toBe(16);
    expect(result.start.get("hour")).toBe(11);
    expect(result.start.get("minute")).toBe(0);
    expect(result.start.get("timezoneOffset")).toBe(null);
   });
   testSingleCase(
       en.casual, "wednesday, september 16, 2020 at 11 am JST", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2020);
    expect(result.start.get("month")).toBe(9);
    expect(result.start.get("day")).toBe(16);
    expect(result.start.get("hour")).toBe(11);
    expect(result.start.get("minute")).toBe(0);
    // JST: GMT+9:00
    expect(result.start.get("timezoneOffset")).toBe(9 * 60);
   });
   testSingleCase(
       en.casual, "wednesday, september 16, 2020 at 11 am GMT+0900 (JST)", (result,
       text) {
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2020);
    expect(result.start.get("month")).toBe(9);
    expect(result.start.get("day")).toBe(16);
    expect(result.start.get("hour")).toBe(11);
    expect(result.start.get("minute")).toBe(0);
    // JST: GMT+9:00
    expect(result.start.get("timezoneOffset")).toBe(9 * 60);
   });
   testSingleCase(
       en.casual, "10:30 pst today", new Date (2016, 10 - 1, 1, 8), (result,
       text) {
    expect(result.text).toBe("10:30 pst today");
    expect(result.start.get("year")).toBe(2016);
    expect(result.start.get("month")).toBe(10);
    expect(result.start.get("day")).toBe(1);
    expect(result.start.get("hour")).toBe(10);
    expect(result.start.get("minute")).toBe(30);
    // PST: UTC−08:00
    expect(result.start.get("timezoneOffset")).toBe(-8 * 60);
   });
  });
  test("Test - Parsing date range with timezone abbreviation", () {
   testSingleCase(en.casual, "10:30 JST today to 10:30 pst tomorrow ",
       new Date (2016, 10 - 1, 1, 8), (result, text) {
        expect(result.text).toBe("10:30 JST today to 10:30 pst tomorrow");
        expect(result.start.get("year")).toBe(2016);
        expect(result.start.get("month")).toBe(10);
        expect(result.start.get("day")).toBe(1);
        expect(result.start.get("hour")).toBe(10);
        expect(result.start.get("minute")).toBe(30);
        expect(result.start.get("timezoneOffset")).toBe(9 * 60);
        expect(result.end.get("year")).toBe(2016);
        expect(result.end.get("month")).toBe(10);
        expect(result.end.get("day")).toBe(2);
        expect(result.end.get("hour")).toBe(10);
        expect(result.end.get("minute")).toBe(30);
        expect(result.end.get("timezoneOffset")).toBe(-8 * 60);
       });
  });
  test("Test - Parsing date/time with ambiguous timezone abbreviations", () {
   // Test dates around transition to DST for ET
   testSingleCase(en.casual, "2022-03-12 23:00 ET", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("hour")).toBe(23);
    expect(result.start.get("timezoneOffset")).toBe(-5 * 60);
   });
   testSingleCase(en.casual, "2022-03-13 23:00 ET", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("hour")).toBe(23);
    expect(result.start.get("timezoneOffset")).toBe(-4 * 60);
   });
   testSingleCase(en.casual, "2021-03-13 23:00 ET", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("hour")).toBe(23);
    expect(result.start.get("timezoneOffset")).toBe(-5 * 60);
   });
   testSingleCase(en.casual, "2021-03-14 23:00 ET", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("hour")).toBe(23);
    expect(result.start.get("timezoneOffset")).toBe(-4 * 60);
   });
   // Also test around transition *from* DST
   testSingleCase(en.casual, "2021-11-06 23:00 ET", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("hour")).toBe(23);
    expect(result.start.get("timezoneOffset")).toBe(-4 * 60);
   });
   testSingleCase(en.casual, "2021-11-07 23:00 ET", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("hour")).toBe(23);
    expect(result.start.get("timezoneOffset")).toBe(-5 * 60);
   });
   testSingleCase(en.casual, "2020-10-31 23:00 ET", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("hour")).toBe(23);
    expect(result.start.get("timezoneOffset")).toBe(-4 * 60);
   });
   testSingleCase(en.casual, "2020-11-01 23:00 ET", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("hour")).toBe(23);
    expect(result.start.get("timezoneOffset")).toBe(-5 * 60);
   });
   // Same checks, but for CET (which transitions at different dates with different rules)

   // Test dates around transition to DST for CET
   testSingleCase(en.casual, "2022-03-26 23:00 CET", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("hour")).toBe(23);
    expect(result.start.get("timezoneOffset")).toBe(60);
   });
   testSingleCase(en.casual, "2022-03-27 23:00 CET", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("hour")).toBe(23);
    expect(result.start.get("timezoneOffset")).toBe(2 * 60);
   });
   testSingleCase(en.casual, "2021-03-27 23:00 CET", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("hour")).toBe(23);
    expect(result.start.get("timezoneOffset")).toBe(60);
   });
   testSingleCase(en.casual, "2021-03-28 23:00 CET", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("hour")).toBe(23);
    expect(result.start.get("timezoneOffset")).toBe(2 * 60);
   });
   // Also test around transition *from* DST for CET
   testSingleCase(en.casual, "2022-10-29 23:00 CET", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("hour")).toBe(23);
    expect(result.start.get("timezoneOffset")).toBe(2 * 60);
   });
   testSingleCase(en.casual, "2022-10-30 23:00 CET", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("hour")).toBe(23);
    expect(result.start.get("timezoneOffset")).toBe(60);
   });
   testSingleCase(en.casual, "2021-10-30 23:00 CET", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("hour")).toBe(23);
    expect(result.start.get("timezoneOffset")).toBe(2 * 60);
   });
   testSingleCase(en.casual, "2021-10-31 23:00 CET", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("hour")).toBe(23);
    expect(result.start.get("timezoneOffset")).toBe(60);
   });
  });
  test("Test - Timezone parsing overrides", () {
   // en.casual.parse('at 10:00 XYZ', new Date(2023, 3, 20), {timezones: {XYZ: -180}})

   // XYZ shouldn't be recognized or parsed as a timezone
   testSingleCase(en.casual, "Jan 1st 2023 at 10:00 XYZ", (result) {
    expect(result.text).toBe("Jan 1st 2023 at 10:00");
    expect(result.start).toBeDate(new Date (2023, 1 - 1, 1, 10));
   });
   // Parse the correct tzoffset when XYZ is provided as a custom tz in parsingOptions
   testSingleCase(en.casual, "Jan 1st 2023 at 10:00 XYZ", new Date (2023, 1, 1),
       { "timezones": { "XYZ": -180}}, (result) {
        expect(result.text).toBe("Jan 1st 2023 at 10:00 XYZ");
        expect(result.start.get("timezoneOffset")).toBe(-180);
       });
   // Parse the correct tzoffset when XYZ is provided as a custom ambiguous tz in parsingOptions
   final parseXYZAsAmbiguousTz = {
    "timezoneOffsetDuringDst": -120,
    "timezoneOffsetNonDst": -180,
    "dstStart": (num year) =>
        getLastWeekdayOfMonth(year, Month.MARCH, Weekday.SUNDAY, 2),
    "dstEnd": (num year) =>
        getLastWeekdayOfMonth(year, Month.OCTOBER, Weekday.SUNDAY, 3)
   };
   // Parsing a non-DST date
   testSingleCase(en.casual, "Jan 1st 2023 at 10:00 XYZ", new Date (2023, 1, 1),
       { "timezones": { "XYZ": parseXYZAsAmbiguousTz}}, (result) {
        expect(result.text).toBe("Jan 1st 2023 at 10:00 XYZ");
        expect(result.start.get("timezoneOffset")).toBe(-180);
       });
   // Parsing a DST date
   testSingleCase(en.casual, "Jun 1st 2023 at 10:00 XYZ", new Date (2023, 1, 1),
       { "timezones": { "XYZ": parseXYZAsAmbiguousTz}}, (result) {
        expect(result.text).toBe("Jun 1st 2023 at 10:00 XYZ");
        expect(result.start.get("timezoneOffset")).toBe(-120);
       });
  });
  test("Test - Parsing date with timezone abbreviation", () {
   testSingleCase(en.casual, "Wednesday, September 16, 2020, EST", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("timezoneOffset")).toBe(-300);
   });
  });
  test("Test - Not parsing timezone from relative time", () {
   {
    final refInstant = new Date (
        "Sun Nov 29 2020 13:24:13 GMT+0900 (Japan Standard Time)");
    final expectedInstant = new Date (
        "Sun Nov 29 2020 14:24:13 GMT+0900 (Japan Standard Time)");
    testSingleCase(
        en.casual, "in 1 hour get eggs and milk", refInstant, (result, text) {
     expect(result.text).toBe("in 1 hour");
     expect(result.start.get("timezoneOffset")).toBe(
         -refInstant.getTimezoneOffset());
     expect(result.start).toBeDate(expectedInstant);
    });
   }
   {
    final refInstant = new Date (
        "Sun Nov 29 2020 13:24:13 GMT+0900 (Japan Standard Time)");
    final expectedInstant = new Date (
        "Sun Nov 29 2020 14:24:13 GMT+0900 (Japan Standard Time)");
    testSingleCase(en.casual, "in 1 hour GMT", refInstant, (result, text) {
     // expect(result.text).toBe("in 1 hour"); known issue when running test in the GMT time
     expect(result.start).toBeDate(expectedInstant);
    });
   }
   {
    final refInstant = new Date (
        "Sun Nov 29 2020 13:24:13 GMT+0900 (Japan Standard Time)");
    final expectedInstant = new Date (
        "Sun Nov 29 2020 14:24:13 GMT+0900 (Japan Standard Time)");
    testSingleCase(
        en.casual, "in 1 hour GMT", { "instant": refInstant, "timezone": "JST"}, (
        result, text) {
     // expect(result.text).toBe("in 1 hour");
     expect(result.start).toBeDate(expectedInstant);
    });
   }
   {
    final refInstant = new Date (
        "Sun Nov 29 2020 13:24:13 GMT+0900 (Japan Standard Time)");
    final expectedInstant = new Date (
        "Sun Nov 29 2020 14:24:13 GMT+0900 (Japan Standard Time)");
    testSingleCase(
        en.casual, "in 1 hour GMT", { "instant": refInstant, "timezone": "BST"}, (
        result, text) {
     // expect(result.text).toBe("in 1 hour");
     expect(result.start).toBeDate(expectedInstant);
    });
   }
  });
  test("Test - Relative time (Now) is not effected by timezone setting", () {
   final refInstant = new Date (1637674343000);
   testSingleCase(en.casual, "now", { "instant": refInstant}, (result) {
    expect(result.text).toBe("now");
    expect(result.start).toBeDate(refInstant);
   });
   testSingleCase(
       en.casual, "now", { "instant": refInstant, "timezone": null}, (result) {
    expect(result.text).toBe("now");
    expect(result.start).toBeDate(refInstant);
   });
   testSingleCase(
       en.casual, "now", { "instant": refInstant, "timezone": "BST"}, (result) {
    expect(result.text).toBe("now");
    expect(result.start).toBeDate(refInstant);
   });
   testSingleCase(
       en.casual, "now", { "instant": refInstant, "timezone": "JST"}, (result) {
    expect(result.text).toBe("now");
    expect(result.start).toBeDate(refInstant);
   });
  });
  test(
      "Test - Relative time (2 hour later) is not effected by timezone setting", () {
   final refInstant = new Date (1637674343000);
   final expectedInstant = new Date (1637674343000 + 2 * 60 * 60 * 1000);
   testSingleCase(en.casual, "2 hour later", { "instant": refInstant}, (result) {
    expect(result.text).toBe("2 hour later");
    expect(result.start).toBeDate(expectedInstant);
   });
   testSingleCase(
       en.casual, "2 hour later", { "instant": refInstant, "timezone": null}, (
       result) {
    expect(result.text).toBe("2 hour later");
    expect(result.start).toBeDate(expectedInstant);
   });
   testSingleCase(
       en.casual, "2 hour later", { "instant": refInstant, "timezone": "BST"}, (
       result) {
    expect(result.text).toBe("2 hour later");
    expect(result.start).toBeDate(expectedInstant);
   });
   testSingleCase(
       en.casual, "2 hour later", { "instant": refInstant, "timezone": "JST"}, (
       result) {
    expect(result.text).toBe("2 hour later");
    expect(result.start).toBeDate(expectedInstant);
   });
  });
  test("Test - Parsing timezone from relative date when valid", () {
   final refDate = new Date (2020, 11 - 1, 14, 13, 48, 22);
   testSingleCase(
       en.casual, "in 1 day get eggs and milk", refDate, (result, text) {
    expect(result.text).toBe("in 1 day");
    expect(result.start.get("timezoneOffset")).toBe(
        -refDate.getTimezoneOffset());
   });
   testSingleCase(en.casual, "in 1 day GET", refDate, (result, text) {
    expect(result.text).toBe("in 1 day GET");
    expect(result.start.get("timezoneOffset")).toBe(240);
   });
   testSingleCase(en.casual, "today EST", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("timezoneOffset")).toBe(-300);
   });
   testSingleCase(en.casual, "next week EST", (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("timezoneOffset")).toBe(-300);
   });
  });
 }
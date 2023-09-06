import 'package:chrono/locales/en/index.dart' as en;
import 'package:chrono/types.dart';
import "package:flutter_test/flutter_test.dart";

import '../test_util.dart';

 void main() {
  test("Test - Single Expression", () {
    testSingleCase(
        en.casual, "The Deadline is now", DateTime(2012, 7, 10, 8, 9, 10, 11),
        (ParsedResult result, String text) {
      expect(result.index, 16);
      expect(result.text, "now");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 10);
      expect(result.start.get("hour"), 8);
      expect(result.start.get("minute"), 9);
      expect(result.start.get("second"), 10);
      expect(result.start.get("millisecond"), 11);
      expect(result.start.get("timezoneOffset"),
          result.refDate.getTimezoneOffset() * -1);
      expect(result.start).toBeDate(result.refDate);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 8, 9, 10, 11));
    });
    testSingleCase(
        en.casual.casual,
        "The Deadline is now, without implicit local timezone",
        {"instant": DateTime(1637674343000), "timezone": null},
        (ParsedResult result, String text) {
      expect(result.text, "now");
      expect(result.start).toBeDate(DateTime(1637674343000));
      expect(result.start.isCertain("timezoneOffset"), false);
    });
    testSingleCase(en.casual.casual, "The Deadline is today",
        DateTime(2012, 7, 10, 14, 12), (ParsedResult result, String text) {
      expect(result.index, 16);
      expect(result.text, "today");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 10);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 14, 12));
    });
    testSingleCase(en.casual.casual, "The Deadline is Tomorrow",
        DateTime(2012, 7, 10, 17, 10), (ParsedResult result, String text) {
      expect(result.index, 16);
      expect(result.text, "Tomorrow");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 11);
      expect(result.start).toBeDate(DateTime(2012, 7, 11, 17, 10));
    });
    testSingleCase(
        en.casual.casual, "The Deadline is Tomorrow", DateTime(2012, 7, 10, 1),
        (ParsedResult result, String text) {
      expect(result.start).toBeDate(DateTime(2012, 7, 11, 1));
    });
    testSingleCase(en.casual.casual, "The Deadline was yesterday",
        DateTime(2012, 7, 10, 12), (ParsedResult result, String text) {
      expect(result.index, 17);
      expect(result.text, "yesterday");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 9);
      expect(result.start).toBeDate(DateTime(2012, 7, 9, 12));
    });
    testSingleCase(en.casual.casual, "The Deadline was last night ",
        DateTime(2012, 7, 10, 12), (ParsedResult result, String text) {
      expect(result.index, 17);
      expect(result.text, "last night");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 9);
      expect(result.start.get("hour"), 0);
      expect(result.start).toBeDate(DateTime(2012, 7, 9, 0));
    });
    testSingleCase(en.casual.casual, "The Deadline was this morning ",
        DateTime(2012, 7, 10, 12), (ParsedResult result, String text) {
      expect(result.index, 17);
      expect(result.text, "this morning");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 10);
      expect(result.start.get("hour"), 6);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 6));
    });
    testSingleCase(en.casual.casual, "The Deadline was this afternoon ",
        DateTime(2012, 7, 10, 12), (ParsedResult result, String text) {
      expect(result.index, 17);
      expect(result.text, "this afternoon");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 10);
      expect(result.start.get("hour"), 15);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 15));
    });
    testSingleCase(en.casual.casual, "The Deadline was this evening ",
        DateTime(2012, 7, 10, 12), (ParsedResult result, String text) {
      expect(result.index, 17);
      expect(result.text, "this evening");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 10);
      expect(result.start.get("hour"), 20);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 20));
    });
    testSingleCase(en.casual.casual, "The Deadline is midnight ",
        DateTime(2012, 7, 10, 12), (ParsedResult result, String text) {
      expect(result.text, "midnight");
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 11);
      expect(result.start.get("hour"), 0);
    });
    // "Midnight" at 0~2AM, assume it's the passed midnight
    testSingleCase(en.casual.casual, "The Deadline was midnight ",
        DateTime(2012, 8 - 1, 10, 1), (ParsedResult result, String text) {
      expect(result.text, "midnight");
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 10);
      expect(result.start.get("hour"), 0);
      expect(result.start.get("minute"), 0);
      expect(result.start.get("second"), 0);
      expect(result.start.get("millisecond"), 0);
    });
    // "Midnight" at 0~2AM with forwardDate option, should be the next night
    testSingleCase(
        en.casual.casual,
        "The Deadline was midnight ",
        DateTime(2012, 8 - 1, 10, 1),
        {"forwardDate": true}, (ParsedResult result, String text) {
      expect(result.text, "midnight");
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 11);
      expect(result.start.get("hour"), 0);
      expect(result.start.get("minute"), 0);
      expect(result.start.get("second"), 0);
      expect(result.start.get("millisecond"), 0);
    });
  });
  test("Test - Combined Expression", () {
    testSingleCase(en.casual.casual, "The Deadline is today 5PM",
        DateTime(2012, 7, 10, 12), (ParsedResult result, String text) {
      expect(result.index, 16);
      expect(result.text, "today 5PM");
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 10);
      expect(result.start.get("hour"), 17);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 17));
    });
    testSingleCase(
        en.casual.casual, "Tomorrow at noon", DateTime(2012, 8 - 1, 10, 14),
        (ParsedResult result, String text) {
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 11);
      expect(result.start.get("hour"), 12);
      expect(result.start).toBeDate(DateTime(2012, 8 - 1, 11, 12));
    });
  });
  test("Test - Casual date range", () {
    testSingleCase(en.casual.casual, "The event is today - next friday",
        DateTime(2012, 7, 4, 12), (ParsedResult result, String text) {
      expect(result.index, 13);
      expect(result.text, "today - next friday");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 4);
      expect(result.start.get("hour"), 12);
      expect(result.start).toBeDate(DateTime(2012, 7, 4, 12));
      expect(result.end == null, isFalse);
      expect(result.end.get("year"), 2012);
      expect(result.end.get("month"), 8);
      expect(result.end.get("day"), 10);
      expect(result.end.get("hour"), 12);
      expect(result.end).toBeDate(DateTime(2012, 7, 10, 12));
    });
    testSingleCase(en.casual.casual, "The event is today - next friday",
        DateTime(2012, 7, 10, 12), (ParsedResult result, String text) {
      expect(result.index, 13);
      expect(result.text, "today - next friday");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 10);
      expect(result.start.get("hour"), 12);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 12));
      expect(result.end == null, isFalse);
      expect(result.end.get("year"), 2012);
      expect(result.end.get("month"), 8);
      expect(result.end.get("day"), 17);
      expect(result.end.get("hour"), 12);
      expect(result.end).toBeDate(DateTime(2012, 7, 17, 12));
    });
  });
  test("Test - Casual time implication", () {
    testSingleCase(
        en.casual.casual,
        "annual leave from today morning to tomorrow",
        DateTime(2012, 8 - 1, 4, 12), (ParsedResult result, String text) {
      expect(result.text, "today morning to tomorrow");
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 4);
      expect(result.start.get("hour"), 6);
      expect(result.start.isCertain("hour"), false);
      expect(result.end.get("month"), 8);
      expect(result.end.get("day"), 5);
      expect(result.end.get("hour"), 12);
      expect(result.end.isCertain("hour"), false);
    });
    testSingleCase(
        en.casual.casual,
        "annual leave from today to tomorrow afternoon",
        DateTime(2012, 8 - 1, 4, 12), (ParsedResult result, String text) {
      expect(result.text, "today to tomorrow afternoon");
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 4);
      expect(result.start.get("hour"), 12);
      expect(result.start.isCertain("hour"), false);
      expect(result.end.get("month"), 8);
      expect(result.end.get("day"), 5);
      expect(result.end.get("hour"), 15);
      expect(result.end.isCertain("hour"), false);
    });
  });
  test("Test - Random text", () {
    testSingleCase(en.casual, "tonight", DateTime(2012, 1 - 1, 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 1);
      expect(result.start.get("day"), 1);
      expect(result.start.get("hour"), 22);
      expect(result.start.get("meridiem"), Meridiem.PM);
    });
    testSingleCase(en.casual, "tonight 8pm", DateTime(2012, 1 - 1, 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("hour"), 20);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 1);
      expect(result.start.get("day"), 1);
      expect(result.start.get("meridiem"), Meridiem.PM);
    });
    testSingleCase(en.casual, "tonight at 8", DateTime(2012, 1 - 1, 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("hour"), 20);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 1);
      expect(result.start.get("day"), 1);
      expect(result.start.get("meridiem"), Meridiem.PM);
    });
    testSingleCase(
        en.casual, "tomorrow before 4pm", DateTime(2012, 1 - 1, 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("hour"), 16);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 1);
      expect(result.start.get("day"), 2);
      expect(result.start.get("meridiem"), Meridiem.PM);
    });
    testSingleCase(
        en.casual, "tomorrow after 4pm", DateTime(2012, 1 - 1, 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("hour"), 16);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 1);
      expect(result.start.get("day"), 2);
      expect(result.start.get("meridiem"), Meridiem.PM);
    });
    testSingleCase(en.casual, "thurs", (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("weekday"), 4);
    });
    testSingleCase(en.casual, "thurs", (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("weekday"), 4);
    });
    testSingleCase(en.casual, "this evening", DateTime(2016, 10 - 1, 1),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 1);
      expect(result.start.get("hour"), 20);
    });
    testSingleCase(en.casual, "yesterday afternoon", DateTime(2016, 10 - 1, 1),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 9);
      expect(result.start.get("day"), 30);
      expect(result.start.get("hour"), 15);
    });
    testSingleCase(en.casual, "tomorrow morning", DateTime(2016, 10 - 1, 1, 8),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 2);
      expect(result.start.get("hour"), 6);
    });
    testSingleCase(
        en.casual, "this afternoon at 3", DateTime(2016, 10 - 1, 1, 8),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 1);
      expect(result.start.get("hour"), 15);
    });
    testSingleCase(en.casual.casual, "at midnight on 12th August",
        DateTime(2012, 8 - 1, 10, 15), (ParsedResult result, String text) {
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 12);
      expect(result.start.get("hour"), 0);
      expect(result.start.get("minute"), 0);
      expect(result.start.get("second"), 0);
      expect(result.start.get("millisecond"), 0);
    });
  });
  test("Test - Casual time with timezone", () {
    testSingleCase(en.casual, "Jan 1, 2020 Morning UTC",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2020);
      expect(result.start.get("month"), 1);
      expect(result.start.get("day"), 1);
      expect(result.start.get("hour"), 6);
      expect(result.start.get("timezoneOffset")).toStrictEqual(0);
      expect(result).toBeDate(DateTime("2020-01-01T06:00:00.000Z"));
    });
    testSingleCase(en.casual, "Jan 1, 2020 Evening JST",
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2020);
      expect(result.start.get("month"), 1);
      expect(result.start.get("day"), 1);
      expect(result.start.get("hour"), 20);
      expect(result.start.get("timezoneOffset")).toStrictEqual(540);
      expect(result).toBeDate(
          DateTime("Wed Jan 01 2020 20:00:00 GMT+0900 (Japan Standard Time)"));
    });
  });
  test("Test - Random negative text", () {
   testUnexpectedResult(en.casual, "notoday");
   testUnexpectedResult(en.casual, "tdtmr");
   testUnexpectedResult(en.casual, "xyesterday");
   testUnexpectedResult(en.casual, "nowhere");
   testUnexpectedResult(en.casual, "noway");
   testUnexpectedResult(en.casual, "knowledge");
   testUnexpectedResult(en.casual, "mar");
   testUnexpectedResult(en.casual, "jan");
  });
 }
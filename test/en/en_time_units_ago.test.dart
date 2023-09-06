import 'package:chrono/locales/en/index.dart' as en;
import 'package:chrono/types.dart';
import "package:flutter_test/flutter_test.dart";

import '../test_util.dart';

 void main() {
   test("Test - Single Expression", () {
     testSingleCase(
        en.casual, "5 days ago, we did something", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 5);
      expect(result.index, 0);
      expect(result.text, "5 days ago");
      expect(result.start).toBeDate(DateTime(2012, 8 - 1, 5));
    });
     testSingleCase(
        en.casual, "10 days ago, we did something", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 7);
      expect(result.start.get("day"), 31);
      expect(result.index, 0);
      expect(result.text, "10 days ago");
      expect(result.start).toBeDate(DateTime(2012, 7 - 1, 31));
    });
     testSingleCase(en.casual, "15 minute ago", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "15 minute ago");
      expect(result.start.get("hour"), 11);
      expect(result.start.get("minute"), 59);
      expect(result.start.get("meridiem"), Meridiem.AM);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 11, 59));
    });
     testSingleCase(
        en.casual, "15 minute earlier", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "15 minute earlier");
      expect(result.start.get("hour"), 11);
      expect(result.start.get("minute"), 59);
      expect(result.start.get("meridiem"), Meridiem.AM);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 11, 59));
    });
     testSingleCase(en.casual, "15 minute before", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "15 minute before");
      expect(result.start.get("hour"), 11);
      expect(result.start.get("minute"), 59);
      expect(result.start.get("meridiem"), Meridiem.AM);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 11, 59));
    });
    testSingleCase(en.casual, "   12 hours ago", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 3);
      expect(result.text, "12 hours ago");
      expect(result.start.get("hour"), 0);
      expect(result.start.get("minute"), 14);
      expect(result.start.get("meridiem"), Meridiem.AM);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 0, 14));
    });
    testSingleCase(en.casual, "1h ago", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "1h ago");
      expect(result.start.get("hour"), 11);
      expect(result.start.get("minute"), 14);
      expect(result.start.get("meridiem"), Meridiem.AM);
    });
    testSingleCase(en.casual, "1hr ago", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "1hr ago");
      expect(result.start.get("hour"), 11);
      expect(result.start.get("minute"), 14);
      expect(result.start.get("meridiem"), Meridiem.AM);
    });
    testSingleCase(
        en.casual, "   half an hour ago", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 3);
      expect(result.text, "half an hour ago");
      expect(result.start.get("hour"), 11);
      expect(result.start.get("minute"), 44);
      expect(result.start.get("meridiem"), Meridiem.AM);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 11, 44));
    });
     testSingleCase(en.casual, "12 hours ago I did something",
        DateTime(2012, 7, 10, 12, 14), (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "12 hours ago");
      expect(result.start.get("hour"), 0);
      expect(result.start.get("minute"), 14);
      expect(result.start.get("meridiem"), Meridiem.AM);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 0, 14));
    });
     testSingleCase(en.casual, "12 seconds ago I did something",
        DateTime(2012, 7, 10, 12, 14), (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "12 seconds ago");
      expect(result.start.get("hour"), 12);
      expect(result.start.get("minute"), 13);
      expect(result.start.get("second"), 48);
      expect(result.start.get("meridiem"), Meridiem.PM);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 12, 13, 48));
    });
     testSingleCase(en.casual, "three seconds ago I did something",
        DateTime(2012, 7, 10, 12, 14), (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "three seconds ago");
      expect(result.start.get("hour"), 12);
      expect(result.start.get("minute"), 13);
      expect(result.start.get("second"), 57);
      expect(result.start.get("meridiem"), Meridiem.PM);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 12, 13, 57));
    });
     testSingleCase(
        en.casual, "5 Days ago, we did something", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 5);
      expect(result.index, 0);
      expect(result.text, "5 Days ago");
      expect(result.start).toBeDate(DateTime(2012, 8 - 1, 5));
    });
     testSingleCase(
        en.casual, "   half An hour ago", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 3);
      expect(result.text, "half An hour ago");
      expect(result.start.get("hour"), 11);
      expect(result.start.get("minute"), 44);
      expect(result.start.get("meridiem"), Meridiem.AM);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 11, 44));
    });
     testSingleCase(
        en.casual, "A days ago, we did something", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 9);
      expect(result.index, 0);
      expect(result.text, "A days ago");
      expect(result.start).toBeDate(DateTime(2012, 8 - 1, 9));
    });
     testSingleCase(en.casual, "a min before", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "a min before");
      expect(result.start.get("hour"), 12);
      expect(result.start.get("minute"), 13);
      expect(result.start.get("meridiem"), Meridiem.PM);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 12, 13));
    });
     testSingleCase(en.casual, "the min before", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "the min before");
      expect(result.start.get("hour"), 12);
      expect(result.start.get("minute"), 13);
      expect(result.start.get("meridiem"), Meridiem.PM);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 12, 13));
    });
   });
   test("Test - Single Expression (Casual)", () {
     testSingleCase(
        en.casual, "5 months ago, we did something", DateTime(2012, 10 - 1, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 5);
      expect(result.start.get("day"), 10);
      expect(result.index, 0);
      expect(result.text, "5 months ago");
      expect(result.start).toBeDate(DateTime(2012, 5 - 1, 10));
    });
     testSingleCase(
        en.casual, "5 years ago, we did something", DateTime(2012, 8 - 1, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2007);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 10);
      expect(result.index, 0);
      expect(result.text, "5 years ago");
      expect(result.start).toBeDate(DateTime(2007, 8 - 1, 10));
    });
     testSingleCase(
        en.casual, "a week ago, we did something", DateTime(2012, 8 - 1, 3),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 7);
      expect(result.start.get("day"), 27);
      expect(result.index, 0);
      expect(result.text, "a week ago");
      expect(result.start).toBeDate(DateTime(2012, 7 - 1, 27));
    });
     testSingleCase(
        en.casual, "a few days ago, we did something", DateTime(2012, 8 - 1, 3),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 7);
      expect(result.start.get("day"), 31);
      expect(result.index, 0);
      expect(result.text, "a few days ago");
      expect(result.start).toBeDate(DateTime(2012, 7 - 1, 31));
    });
   });
   test("Test - Nested time ago", () {
     testSingleCase(
        en.casual, "15 hours 29 min ago", DateTime(2012, 7, 10, 22, 30),
        (ParsedResult result, String text) {
      expect(result.text, "15 hours 29 min ago");
      expect(result.start.get("day"), 10);
      expect(result.start.get("hour"), 7);
      expect(result.start.get("minute"), 1);
      expect(result.start.get("meridiem"), Meridiem.AM);
    });
     testSingleCase(
        en.casual, "1 day 21 hours ago ", DateTime(2012, 7, 10, 22, 30),
        (ParsedResult result, String text) {
      expect(result.text, "1 day 21 hours ago");
      expect(result.start.get("day"), 9);
      expect(result.start.get("hour"), 1);
      expect(result.start.get("minute"), 30);
      expect(result.start.get("meridiem"), Meridiem.AM);
    });
     testSingleCase(en.casual, "1d 21 h 25m ago ", DateTime(2012, 7, 10, 22, 30),
        (ParsedResult result, String text) {
      expect(result.text, "1d 21 h 25m ago");
      expect(result.start.get("day"), 9);
      expect(result.start.get("hour"), 1);
      expect(result.start.get("minute"), 5);
      expect(result.start.get("meridiem"), Meridiem.AM);
    });
     testSingleCase(
        en.casual, "3 min 49 sec ago ", DateTime(2012, 7, 10, 22, 30),
        (ParsedResult result, String text) {
      expect(result.text, "3 min 49 sec ago");
      expect(result.start.get("day"), 10);
      expect(result.start.get("hour"), 22);
      expect(result.start.get("minute"), 26);
      expect(result.start.get("second"), 11);
      expect(result.start.get("meridiem"), Meridiem.PM);
    });
     testSingleCase(en.casual, "3m 49s ago ", DateTime(2012, 7, 10, 22, 30),
        (ParsedResult result, String text) {
      expect(result.text, "3m 49s ago");
      expect(result.start.get("day"), 10);
      expect(result.start.get("hour"), 22);
      expect(result.start.get("minute"), 26);
      expect(result.start.get("second"), 11);
      expect(result.start.get("meridiem"), Meridiem.PM);
    });
   });
   test("Test - Before with reference", () {
     testSingleCase(en.casual, "2 day before today", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 8);
    });
     testSingleCase(en.casual, "the day before yesterday", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 8);
    });
     testSingleCase(en.casual, "2 day before yesterday", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 7);
    });
     testSingleCase(en.casual, "a week before yesterday", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 2);
    });
   });
   test("Test - Strict mode", () {
     testSingleCase(
        en.casual.strict, "5 minutes ago", DateTime(2012, 7, 10, 12, 14),
        (result, text) {
      expect(result.start.get("hour"), 12);
      expect(result.start.get("minute"), 9);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 12, 9));
    });
    testUnexpectedResult(
        en.casual.strict, "5m ago", DateTime(2012, 7, 10, 12, 14));
    testUnexpectedResult(
        en.casual.strict, "5hr before", DateTime(2012, 7, 10, 12, 14));
    testUnexpectedResult(
        en.casual.strict, "5 h ago", DateTime(2012, 7, 10, 12, 14));
  });
   test("Test - Negative cases", () {
     testUnexpectedResult(en.casual, "15 hours 29 min");
     testUnexpectedResult(en.casual, "a few hour");
     testUnexpectedResult(en.casual, "5 days");
   });
 }
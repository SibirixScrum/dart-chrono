import 'package:chrono/locales/en/index.dart' as en;
import 'package:chrono/types.dart';
import "package:flutter_test/flutter_test.dart";

import '../test_util.dart';

 void main() {
   test("Test - Later Expression", () {
     testSingleCase(en.casual, "2 days later", DateTime(2012, 7, 10, 12),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 12);
      expect(result.index, 0);
      expect(result.text, "2 days later");
      expect(result.start.isCertain("day"), true);
      expect(result.start.isCertain("month"), true);
      expect(result.start).toBeDate(DateTime(2012, 8 - 1, 12, 12));
    });
     testSingleCase(en.casual, "5 minutes later", DateTime(2012, 7, 10, 10, 0),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 10);
      expect(result.start.get("hour"), 10);
      expect(result.start.get("minute"), 5);
      expect(result.index, 0);
      expect(result.text, "5 minutes later");
      expect(result.start.isCertain("hour"), true);
      expect(result.start.isCertain("minute"), true);
      expect(result.start).toBeDate(DateTime(2012, 8 - 1, 10, 10, 5));
    });
     testSingleCase(en.casual, "3 week later", DateTime(2012, 7 - 1, 10, 10, 0),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 7);
      expect(result.start.get("day"), 31);
      expect(result.index, 0);
      expect(result.text, "3 week later");
      expect(result.start).toBeDate(DateTime(2012, 7 - 1, 31, 10, 0));
    });
     testSingleCase(en.casual, "3w later", DateTime(2012, 7 - 1, 10, 10, 0),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 7);
      expect(result.start.get("day"), 31);
      expect(result.index, 0);
      expect(result.text, "3w later");
    });
     testSingleCase(en.casual, "3mo later", DateTime(2012, 7 - 1, 10, 10, 0),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 10);
      expect(result.index, 0);
      expect(result.text, "3mo later");
    });
   });
   test("Test - From now Expression", () {
     testSingleCase(
        en.casual, "5 days from now, we did something", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 15);
      expect(result.index, 0);
      expect(result.text, "5 days from now");
      expect(result.start).toBeDate(DateTime(2012, 8 - 1, 15));
    });
     testSingleCase(
        en.casual, "10 days from now, we did something", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 20);
      expect(result.index, 0);
      expect(result.text, "10 days from now");
      expect(result.start).toBeDate(DateTime(2012, 8 - 1, 20));
    });
     testSingleCase(
        en.casual, "15 minute from now", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "15 minute from now");
      expect(result.start.get("hour"), 12);
      expect(result.start.get("minute"), 29);
      expect(result.start.get("meridiem"), Meridiem.PM);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 12, 29));
    });
     testSingleCase(
        en.casual, "15 minutes earlier", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "15 minutes earlier");
      expect(result.start.get("hour"), 11);
      expect(result.start.get("minute"), 59);
      expect(result.start.get("meridiem"), Meridiem.AM);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 11, 59));
    });
     testSingleCase(en.casual, "15 minute out", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "15 minute out");
      expect(result.start.get("hour"), 12);
      expect(result.start.get("minute"), 29);
      expect(result.start.get("meridiem"), Meridiem.PM);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 12, 29));
    });
     testSingleCase(
        en.casual, "   12 hours from now", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 3);
      expect(result.text, "12 hours from now");
      expect(result.start.get("day"), 11);
      expect(result.start.get("hour"), 0);
      expect(result.start.get("minute"), 14);
      expect(result.start).toBeDate(DateTime(2012, 7, 11, 0, 14));
    });
     testSingleCase(
        en.casual, "   12 hrs from now", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 3);
      expect(result.text, "12 hrs from now");
      expect(result.start.get("day"), 11);
      expect(result.start.get("hour"), 0);
      expect(result.start.get("minute"), 14);
      expect(result.start.get("meridiem"), Meridiem.AM);
    });
     testSingleCase(
        en.casual, "   half an hour from now", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 3);
      expect(result.text, "half an hour from now");
      expect(result.start.get("hour"), 12);
      expect(result.start.get("minute"), 44);
      expect(result.start.get("meridiem"), Meridiem.PM);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 12, 44));
    });
     testSingleCase(en.casual, "12 hours from now I did something",
        DateTime(2012, 7, 10, 12, 14), (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "12 hours from now");
      expect(result.start.get("day"), 11);
      expect(result.start.get("hour"), 0);
      expect(result.start.get("minute"), 14);
      expect(result.start).toBeDate(DateTime(2012, 7, 11, 0, 14));
    });
     testSingleCase(en.casual, "12 seconds from now I did something",
        DateTime(2012, 7, 10, 12, 14), (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "12 seconds from now");
      expect(result.start.get("hour"), 12);
      expect(result.start.get("minute"), 14);
      expect(result.start.get("second"), 12);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 12, 14, 12));
    });
     testSingleCase(en.casual, "three seconds from now I did something",
        DateTime(2012, 7, 10, 12, 14), (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "three seconds from now");
      expect(result.start.get("hour"), 12);
      expect(result.start.get("minute"), 14);
      expect(result.start.get("second"), 3);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 12, 14, 3));
    });
     testSingleCase(
        en.casual, "5 Days from now, we did something", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 15);
      expect(result.index, 0);
      expect(result.text, "5 Days from now");
      expect(result.start).toBeDate(DateTime(2012, 8 - 1, 15));
    });
     testSingleCase(
        en.casual, "   half An hour from now", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 3);
      expect(result.text, "half An hour from now");
      expect(result.start.get("hour"), 12);
      expect(result.start.get("minute"), 44);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 12, 44));
    });
     testSingleCase(
        en.casual, "A days from now, we did something", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 11);
      expect(result.index, 0);
      expect(result.text, "A days from now");
      expect(result.start).toBeDate(DateTime(2012, 8 - 1, 11));
    });
     testSingleCase(en.casual, "a min out", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "a min out");
      expect(result.start.get("hour"), 12);
      expect(result.start.get("minute"), 15);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 12, 15));
    });
     testSingleCase(en.casual, "in 1 hour", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "in 1 hour");
      expect(result.start.get("hour"), 13);
      expect(result.start.get("minute"), 14);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 13, 14));
    });
     testSingleCase(en.casual, "in 1 mon", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "in 1 mon");
      expect(result.start.get("month"), 8 + 1);
      expect(result.start).toBeDate(DateTime(2012, 8, 10, 12, 14));
    });
     testSingleCase(en.casual, "in 1.5 hours", DateTime(2012, 7, 10, 12, 40),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "in 1.5 hours");
      expect(result.start.get("hour"), 14);
      expect(result.start.get("minute"), 10);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 14, 10));
    });
     testSingleCase(en.casual, "in 1d 2hr 5min", DateTime(2012, 7, 10, 12, 40),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "in 1d 2hr 5min");
      expect(result.start.get("day"), 11);
      expect(result.start.get("hour"), 14);
      expect(result.start.get("minute"), 45);
      expect(result.start).toBeDate(DateTime(2012, 7, 11, 14, 45));
    });
   });
   test("Test - Strict mode", () {
     testSingleCase(en.casual, "the min after", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "the min after");
      expect(result.start.get("hour"), 12);
      expect(result.start.get("minute"), 15);
      expect(result.start.get("meridiem"), Meridiem.PM);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 12, 15));
    });
     testSingleCase(
         en.casual.strict, "15 minutes from now", DateTime(2012, 7, 10, 12, 14),
        (result, text) {
      expect(result.text, text);
      expect(result.start.get("hour"), 12);
      expect(result.start.get("minute"), 29);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 12, 29));
    });
     testSingleCase(
        en.casual.strict, "25 minutes later", DateTime(2012, 7, 10, 12, 40),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "25 minutes later");
      expect(result.start.get("hour"), 13);
      expect(result.start.get("minute"), 5);
      expect(result.start).toBeDate(DateTime(2012, 7, 10, 13, 5));
    });
     testUnexpectedResult(en.casual.strict, "15m from now");
     testUnexpectedResult(en.casual.strict, "15s later");
   });
   test("Test - After with reference", () {
     testSingleCase(en.casual, "2 day after today", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 12);
    });
     testSingleCase(en.casual, "the day after tomorrow", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 12);
    });
     testSingleCase(en.casual, "2 day after tomorrow", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.text, "2 day after tomorrow");
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 13);
    });
     testSingleCase(en.casual, "a week after tomorrow", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.text, "a week after tomorrow");
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 18);
    });
   });
 }
import 'package:chrono/locales/en/index.dart' as en;
import 'package:chrono/types.dart';
import "package:flutter_test/flutter_test.dart";

import '../test_util.dart';


 void main() {
   test("Test - Positive time units", () {
     testSingleCase(en.casual, "next 2 weeks", DateTime(2016, 10 - 1, 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 15);
    });
     testSingleCase(en.casual, "next 2 days", DateTime(2016, 10 - 1, 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 3);
      expect(result.start.get("hour"), 12);
    });
     testSingleCase(en.casual, "next two years", DateTime(2016, 10 - 1, 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2018);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 1);
      expect(result.start.get("hour"), 12);
    });
     testSingleCase(
        en.casual, "next 2 weeks 3 days", DateTime(2016, 10 - 1, 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 18);
      expect(result.start.get("hour"), 12);
    });
     testSingleCase(en.casual, "after a year", DateTime(2016, 10 - 1, 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2017);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 1);
      expect(result.start.get("hour"), 12);
    });
     testSingleCase(en.casual, "after an hour", DateTime(2016, 10 - 1, 1, 15),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 1);
      expect(result.start.get("hour"), 16);
    });
   });
   test("Test - Negative time units", () {
     testSingleCase(en.casual, "last 2 weeks", DateTime(2016, 10 - 1, 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 9);
      expect(result.start.get("day"), 17);
      expect(result.start.get("hour"), 12);
    });
     testSingleCase(en.casual, "last two weeks", DateTime(2016, 10 - 1, 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 9);
      expect(result.start.get("day"), 17);
      expect(result.start.get("hour"), 12);
    });
     testSingleCase(en.casual, "past 2 days", DateTime(2016, 10 - 1, 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 9);
      expect(result.start.get("day"), 29);
      expect(result.start.get("hour"), 12);
    });
     testSingleCase(
        en.casual, "+2 months, 5 days", DateTime(2016, 10 - 1, 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 12);
      expect(result.start.get("day"), 6);
      expect(result.start.get("hour"), 12);
    });
   });
   test("Test - Plus '+' sign", () {
     testSingleCase(
         en.casual.casual, "+15 minutes", DateTime(2012, 7 - 1, 10, 12, 14),
        (result, text) {
      expect(result.text, text);
      expect(result.start.get("hour"), 12);
      expect(result.start.get("minute"), 29);
      expect(result.start).toBeDate(DateTime(2012, 7 - 1, 10, 12, 29));
    });
     testSingleCase(
        en.casual.casual, "+15min", DateTime(2012, 7 - 1, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("hour"), 12);
      expect(result.start.get("minute"), 29);
      expect(result.start).toBeDate(DateTime(2012, 7 - 1, 10, 12, 29));
    });
     testSingleCase(
         en.casual.casual, "+1 day 2 hour", DateTime(2012, 7 - 1, 10, 12, 14),
        (result, text) {
      expect(result.text, text);
      expect(result.start.get("day"), 11);
      expect(result.start.get("hour"), 14);
      expect(result.start.get("minute"), 14);
      expect(result.start).toBeDate(DateTime(2012, 7 - 1, 11, 14, 14));
    });
     testSingleCase(en.casual.casual, "+1m", DateTime(2012, 7 - 1, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("hour"), 12);
      expect(result.start.get("minute"), 15);
      expect(result.start).toBeDate(DateTime(2012, 7 - 1, 10, 12, 15));
    });
   });
   test("Test - Minus '-' sign", () {
     testSingleCase(en.casual.casual, "-3y", DateTime(2015, 7 - 1, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 7);
      expect(result.start.get("day"), 10);
      expect(result.start.get("hour"), 12);
      expect(result.start.get("minute"), 14);
      expect(result.start).toBeDate(DateTime(2012, 7 - 1, 10, 12, 14));
    });
     testSingleCase(en.casual, "-2hr5min", DateTime(2016, 10 - 1, 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 1);
      expect(result.start.get("hour"), 9);
      expect(result.start.get("minute"), 55);
    });
   });
   test("Test - Without custom parser without abbreviations", () {
     final custom = en.casual.en.strict.clone();
     custom.parsers.push(new ENTimeUnitCasualRelativeFormatParser (false));
     testUnexpectedResult(custom, "-3y");
     testUnexpectedResult(custom, "last 2m");
     testSingleCase(custom, "-2 hours 5 minutes", DateTime(2016, 10 - 1, 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 1);
      expect(result.start.get("hour"), 9);
      expect(result.start.get("minute"), 55);
    });
   });
   test("Test - Negative cases", () {
     testUnexpectedResult(
        en.casual.casual, "3y", DateTime(2015, 7 - 1, 10, 12, 14));
    testUnexpectedResult(
        en.casual.casual, "1 m", DateTime(2015, 7 - 1, 10, 12, 14));
    testUnexpectedResult(
        en.casual.casual, "the day", DateTime(2015, 7 - 1, 10, 12, 14));
    testUnexpectedResult(
        en.casual.casual, "a day", DateTime(2015, 7 - 1, 10, 12, 14));
  });
 }
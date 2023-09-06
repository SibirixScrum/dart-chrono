import 'package:chrono/locales/en/index.dart' as en;
import 'package:chrono/types.dart';
import "package:flutter_test/flutter_test.dart";

import '../test_util.dart';

 void main() {
   test("Test - Parsing text offset", () {
     testSingleCase(en.casual, "  11 AM ", DateTime(2016, 10 - 1, 1, 8),
        (ParsedResult result, String text) {
      expect(result.index, 2);
      expect(result.text, "11 AM");
    });
     testSingleCase(en.casual, "2020 at  11 AM ", DateTime(2016, 10 - 1, 1, 8),
        (ParsedResult result, String text) {
      expect(result.index, 5);
      expect(result.text, "at  11 AM");
    });
   });
   test("Test - Time expression", () {
     testSingleCase(en.casual, "20:32:13", DateTime(2016, 10 - 1, 1, 8),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("hour"), 20);
      expect(result.start.get("minute"), 32);
      expect(result.start.get("second"), 13);
      expect(result.start.get("meridiem"), Meridiem.PM);
    });
   });
   test("Test - Time range expression", () {
     testSingleCase(
        en.casual, "10:00:00 - 21:45:00", DateTime(2016, 10 - 1, 1, 8),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("hour"), 10);
      expect(result.start.get("minute"), 0);
      expect(result.start.get("second"), 0);
      expect(result.start.get("meridiem"), Meridiem.AM);
      expect(result.end.get("hour"), 21);
      expect(result.end.get("minute"), 45);
      expect(result.end.get("second"), 0);
      expect(result.end.get("meridiem"), Meridiem.PM);
    });
     testSingleCase(
         en.casual, "10:00:00 until 21:45:00", DateTime(2016, 10 - 1, 1, 11),
        (result, text) {
      expect(result.text, text);
      expect(result.start.get("hour"), 10);
      expect(result.start.get("minute"), 0);
      expect(result.start.get("second"), 0);
      expect(result.start.get("meridiem"), Meridiem.AM);
      expect(result.end.get("hour"), 21);
      expect(result.end.get("minute"), 45);
      expect(result.end.get("second"), 0);
      expect(result.end.get("meridiem"), Meridiem.PM);
    });
     testSingleCase(
         en.casual, "10:00:00 till 21:45:00", DateTime(2016, 10 - 1, 1, 11),
        (result, text) {
      expect(result.text, text);
      expect(result.start.get("hour"), 10);
      expect(result.start.get("minute"), 0);
      expect(result.start.get("second"), 0);
      expect(result.start.get("meridiem"), Meridiem.AM);
      expect(result.end.get("hour"), 21);
      expect(result.end.get("minute"), 45);
      expect(result.end.get("second"), 0);
      expect(result.end.get("meridiem"), Meridiem.PM);
    });
     testSingleCase(
         en.casual, "10:00:00 through 21:45:00", DateTime(2016, 10 - 1, 1, 11),
        (result, text) {
      expect(result.text, text);
      expect(result.start.get("hour"), 10);
      expect(result.start.get("minute"), 0);
      expect(result.start.get("second"), 0);
      expect(result.start.get("meridiem"), Meridiem.AM);
      expect(result.end.get("hour"), 21);
      expect(result.end.get("minute"), 45);
      expect(result.end.get("second"), 0);
      expect(result.end.get("meridiem"), Meridiem.PM);
    });
   });
   test("Test - Casual time number expression", () {
     testSingleCase(en.casual, "11 at night", DateTime(2016, 10 - 1, 1, 8),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 1);
      expect(result.start.get("hour"), 23);
    });
     testSingleCase(en.casual, "11 tonight", DateTime(2016, 10 - 1, 1, 8),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 1);
      expect(result.start.get("hour"), 23);
    });
     testSingleCase(en.casual, "6 in the morning", DateTime(2016, 10 - 1, 1, 8),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 1);
      expect(result.start.get("hour"), 6);
      expect(result.start.get("minute"), 0);
      expect(result.start.get("meridiem"), Meridiem.AM);
    });
     testSingleCase(
        en.casual, "6 in the afternoon", DateTime(2016, 10 - 1, 1, 8),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 1);
      expect(result.start.get("hour"), 18);
      expect(result.start.get("minute"), 0);
      expect(result.start.get("meridiem"), Meridiem.PM);
    });
   });
   test("Test - Time range's meridiem handling", () {
     testSingleCase(en.casual, "10 - 11 at night", DateTime(2016, 10 - 1, 1, 8),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 1);
      expect(result.start.get("hour"), 22);
      expect(result.end.get("year"), 2016);
      expect(result.end.get("month"), 10);
      expect(result.end.get("day"), 1);
      expect(result.end.get("hour"), 23);
    });
     testSingleCase(en.casual, "8pm - 11", DateTime(2016, 10 - 1, 1, 8),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 1);
      expect(result.start.get("hour"), 20);
      expect(result.start.get("meridiem"), Meridiem.PM);
      expect(result.end.get("year"), 2016);
      expect(result.end.get("month"), 10);
      expect(result.end.get("day"), 1);
      expect(result.end.get("hour"), 23);
      expect(result.end.get("meridiem"), Meridiem.PM);
    });
     testSingleCase(en.casual, "8 - 11pm", DateTime(2016, 10 - 1, 1, 8),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 1);
      expect(result.start.get("hour"), 20);
      expect(result.start.get("meridiem"), Meridiem.PM);
      expect(result.end.get("year"), 2016);
      expect(result.end.get("month"), 10);
      expect(result.end.get("day"), 1);
      expect(result.end.get("hour"), 23);
      expect(result.end.get("meridiem"), Meridiem.PM);
    });
     testSingleCase(en.casual, "7 - 8", DateTime(2016, 10 - 1, 1, 8),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 1);
      expect(result.start.get("hour"), 7);
      expect(result.start.get("meridiem"), Meridiem.AM);
      expect(result.end.get("year"), 2016);
      expect(result.end.get("month"), 10);
      expect(result.end.get("day"), 1);
      expect(result.end.get("hour"), 8);
      expect(result.end.get("meridiem"), Meridiem.AM);
    });
    testSingleCase(en.casual.fr, "1pm-3", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 10);
      expect(result.start.get("hour"), 13);
      expect(result.start.get("minute"), 0);
      expect(result.start.get("meridiem"), Meridiem.PM);
      expect(result.start.isCertain("meridiem"), true);
      expect(result.end.get("year"), 2012);
      expect(result.end.get("month"), 8);
      expect(result.end.get("day"), 10);
      expect(result.end.get("hour"), 15);
      expect(result.end.get("minute"), 0);
      expect(result.end.get("meridiem"), Meridiem.PM);
      expect(result.end.isCertain("meridiem"), true);
    });
    testSingleCase(en.casual.fr, "1am-3", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 10);
      expect(result.start.get("hour"), 1);
      expect(result.start.get("minute"), 0);
      expect(result.start.get("meridiem"), Meridiem.AM);
      expect(result.start.isCertain("meridiem"), true);
      expect(result.end.get("year"), 2012);
      expect(result.end.get("month"), 8);
      expect(result.end.get("day"), 10);
      expect(result.end.get("hour"), 3);
      expect(result.end.get("minute"), 0);
      expect(result.end.get("meridiem"), Meridiem.AM);
      expect(result.end.isCertain("meridiem"), false);
    });
    testSingleCase(en.casual.fr, "11pm-3", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 10);
      expect(result.start.get("hour"), 23);
      expect(result.start.get("minute"), 0);
      expect(result.start.get("meridiem"), Meridiem.PM);
      expect(result.start.isCertain("meridiem"), true);
      expect(result.end.get("year"), 2012);
      expect(result.end.get("month"), 8);
      expect(result.end.get("day"), 11);
      expect(result.end.get("hour"), 3);
      expect(result.end.get("minute"), 0);
      expect(result.end.get("meridiem"), Meridiem.AM);
      expect(result.end.isCertain("meridiem"), false);
    });
    testSingleCase(en.casual.fr, "12-3am", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 10);
      expect(result.start.get("hour"), 0);
      expect(result.start.get("minute"), 0);
      expect(result.start.get("meridiem"), Meridiem.AM);
      expect(result.end.get("year"), 2012);
      expect(result.end.get("month"), 8);
      expect(result.end.get("day"), 10);
      expect(result.end.get("hour"), 3);
      expect(result.end.get("minute"), 0);
      expect(result.end.get("meridiem"), Meridiem.AM);
      expect(result.end.isCertain("meridiem"), true);
    });
    testSingleCase(en.casual.fr, "12-3pm", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 10);
      expect(result.start.get("hour"), 12);
      expect(result.start.get("minute"), 0);
      expect(result.start.get("meridiem"), Meridiem.PM);
      expect(result.end.get("year"), 2012);
      expect(result.end.get("month"), 8);
      expect(result.end.get("day"), 10);
      expect(result.end.get("hour"), 15);
      expect(result.end.get("minute"), 0);
      expect(result.end.get("meridiem"), Meridiem.PM);
      expect(result.end.isCertain("meridiem"), true);
    });
  });
   test("Test - Time range to the next day", () {
     testSingleCase(en.casual, "December 31, 2022 10:00 pm - 1:00 am",
        DateTime(2017, 7 - 1, 7), (ParsedResult result, String text) {
      expect(result.start.get("day"), 31);
      expect(result.start.get("month"), 12);
      expect(result.start.get("year"), 2022);
      expect(result.start.get("hour"), 22);
      expect(result.start.get("meridiem"), Meridiem.PM);
    });
     testSingleCase(en.casual, "December 31, 2022 10:00 pm - 12:00 am",
        DateTime(2017, 7 - 1, 7), (ParsedResult result, String text) {
      expect(result.start.get("day"), 31);
      expect(result.start.get("month"), 12);
      expect(result.start.get("year"), 2022);
      expect(result.start.get("hour"), 22);
      expect(result.start.get("meridiem"), Meridiem.PM);
    });
   });
   test("Test - Parsing causal positive cases", () {
    testSingleCase(en.casual.casual, "at 1",
        (ParsedResult result, String text) {
      expect(result.text, "at 1");
      expect(result.start.get("hour"), 1);
    });
    testSingleCase(en.casual.casual, "at 12",
        (ParsedResult result, String text) {
      expect(result.text, "at 12");
      expect(result.start.get("hour"), 12);
    });
    testSingleCase(en.casual.casual, "at 12.30",
        (ParsedResult result, String text) {
      expect(result.text, "at 12.30");
      expect(result.start.get("hour"), 12);
      expect(result.start.get("minute"), 30);
    });
  });
   test("Test - Parsing negative cases : [year-like] pattern", () {
     testUnexpectedResult(en.casual, "2020");
     testUnexpectedResult(en.casual, "2020  ");
   });
   test("Test - Parsing negative cases : 'at [some numbers]'", () {
     testUnexpectedResult(en.casual, "I'm at 101,194 points!");
     testUnexpectedResult(en.casual, "I'm at 101 points!");
     testUnexpectedResult(en.casual, "I'm at 10.1");
   });
   test(
       "Test - Parsing negative cases : 'at [some numbers] - [some numbers]'", () {
     testUnexpectedResult(en.casual, "I'm at 10.1 - 10.12");
     testUnexpectedResult(en.casual, "I'm at 10 - 10.1");
   });
   test("Test - Parsing negative cases (Strict)", () {
     testUnexpectedResult(en.casual.strict, "I'm at 101,194 points!");
     testUnexpectedResult(en.casual.strict, "I'm at 101 points!");
     testUnexpectedResult(en.casual.strict, "I'm at 10.1");
     testUnexpectedResult(en.casual.strict, "I'm at 10");
     testUnexpectedResult(en.casual.strict, "2020");
   });
   test(
       "Test - Parsing negative cases : 'at [some numbers] - [some numbers]' (Strict)", () {
     testUnexpectedResult(en.casual.strict, "I'm at 10.1 - 10.12");
     testUnexpectedResult(en.casual.strict, "I'm at 10 - 10.1");
     testUnexpectedResult(en.casual.strict, "I'm at 10 - 20");
     testUnexpectedResult(en.casual.strict, "7-730");
   });
   test("Test - forward dates only option", () {
     testSingleCase(en.casual, "1am", {
      "instant": DateTime("Wed May 26 2022 01:57:00 GMT-0500 (CDT)"),
      "timezone": "CDT"
    }, {
      "forwardDate": true
    }, (ParsedResult result, String text) {
      expect(result.start.get("year"), 2022);
      expect(result.start.get("month"), 5);
      expect(result.start.get("day"), 27);
      expect(result.start.get("hour"), 1);
    });
    testSingleCase(
        en.casual, "11am", DateTime(2016, 10 - 1, 1, 12), {"forwardDate": true},
        (ParsedResult result, String text) {
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 2);
      expect(result.start.get("hour"), 11);
    });
    testSingleCase(en.casual, "  11am to 1am  ", DateTime(2016, 10 - 1, 1, 12),
        {"forwardDate": true}, (ParsedResult result, String text) {
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 2);
      expect(result.start.get("hour"), 11);
      expect(result.end == null, isFalse);
      expect(result.end.get("year"), 2016);
      expect(result.end.get("month"), 10);
      expect(result.end.get("day"), 3);
      expect(result.end.get("hour"), 1);
    });
    testSingleCase(en.casual, "  10am to 12pm  ", DateTime(2016, 10 - 1, 1, 11),
        {"forwardDate": true}, (ParsedResult result, String text) {
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 2);
      expect(result.start.get("hour"), 10);
      expect(result.end == null, isFalse);
      expect(result.end.get("year"), 2016);
      expect(result.end.get("month"), 10);
      expect(result.end.get("day"), 2);
      expect(result.end.get("hour"), 12);
    });
  });
 }
import 'package:chrono/locales/en/index.dart' as en;
import "package:flutter_test/flutter_test.dart";

import '../test_util.dart';

 void main() {
   test("Test - Single Expression", () {
    testSingleCase(en.casual.casual, "Monday", DateTime(2012, 7, 9),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "Monday");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 6);
      expect(result.start.get("weekday"), 1);
      expect(result.start.isCertain("day"), false);
      expect(result.start.isCertain("month"), false);
      expect(result.start.isCertain("year"), false);
      expect(result.start.isCertain("weekday"), true);
      expect(result.start).toBeDate(DateTime(2012, 7, 6, 12));
    });
    testSingleCase(en.casual.casual, "Thursday", DateTime(2012, 7, 9),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "Thursday");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 9);
      expect(result.start.get("weekday"), 4);
      expect(result.start).toBeDate(DateTime(2012, 7, 9, 12));
    });
    testSingleCase(en.casual.casual, "Sunday", DateTime(2012, 7, 9),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "Sunday");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 12);
      expect(result.start.get("weekday"), 0);
      expect(result.start).toBeDate(DateTime(2012, 7, 12, 12));
    });
    testSingleCase(en.casual.casual, "The Deadline is last Friday...",
        DateTime(2012, 7, 9), (ParsedResult result, String text) {
      expect(result.index, 16);
      expect(result.text, "last Friday");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 3);
      expect(result.start.get("weekday"), 5);
      expect(result.start).toBeDate(DateTime(2012, 7, 3, 12));
    });
     testSingleCase(en.casual.casual, "The Deadline is past Friday...",
        DateTime(2012, 7, 9), (ParsedResult result, String text) {
      expect(result.index, 16);
      expect(result.text, "past Friday");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 3);
      expect(result.start.get("weekday"), 5);
      expect(result.start).toBeDate(DateTime(2012, 7, 3, 12));
    });
     testSingleCase(
         en.casual.casual, "Let's have a meeting on Friday next week",
        DateTime("Sat Apr 18 2015"), (ParsedResult result, String text) {
      expect(result.index, 21);
      expect(result.text, "on Friday next week");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2015);
      expect(result.start.get("month"), 4);
      expect(result.start.get("day"), 24);
      expect(result.start.get("weekday"), 5);
      expect(result.start).toBeDate(DateTime(2015, 3, 24, 12));
    });
     testSingleCase(
         en.casual.casual,
        "I plan on taking the day off on Tuesday, next week",
        DateTime(2015, 3, 18), (ParsedResult result, String text) {
      expect(result.index, 29);
      expect(result.text, "on Tuesday, next week");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2015);
      expect(result.start.get("month"), 4);
      expect(result.start.get("day"), 21);
      expect(result.start.get("weekday"), 2);
      expect(result.start).toBeDate(DateTime(2015, 3, 21, 12));
    });
   });
   test("Test - Weekday casual `This` guessing", () {
     testSingleCase(
        en.casual.casual, "This Saturday", DateTime("Tue Aug 2 2022"),
        (ParsedResult result, String text) {
      expect(result.start.get("day"), 6);
      expect(result.start.get("month"), 8);
      expect(result.start.get("year"), 2022);
    });
     testSingleCase(en.casual.casual, "This Sunday", DateTime("Tue Aug 2 2022"),
        (ParsedResult result, String text) {
      expect(result.start.get("day"), 7);
      expect(result.start.get("month"), 8);
      expect(result.start.get("year"), 2022);
    });
     testSingleCase(
        en.casual.casual, "This Wednesday", DateTime("Tue Aug 2 2022"),
        (ParsedResult result, String text) {
      expect(result.start.get("day"), 3);
      expect(result.start.get("month"), 8);
      expect(result.start.get("year"), 2022);
    });
     testSingleCase(
        en.casual.casual, "This Saturday", DateTime("Sun Aug 7 2022"),
        (ParsedResult result, String text) {
      expect(result.start.get("day"), 13);
      expect(result.start.get("month"), 8);
      expect(result.start.get("year"), 2022);
    });
     testSingleCase(en.casual.casual, "This Sunday", DateTime("Sun Aug 7 2022"),
        (ParsedResult result, String text) {
      expect(result.start.get("day"), 7);
      expect(result.start.get("month"), 8);
      expect(result.start.get("year"), 2022);
    });
     testSingleCase(
        en.casual.casual, "This Wednesday", DateTime("Sun Aug 7 2022"),
        (ParsedResult result, String text) {
      expect(result.start.get("day"), 10);
      expect(result.start.get("month"), 8);
      expect(result.start.get("year"), 2022);
    });
   });
   test("Test - Weekday casual `Last` guessing", () {
     testSingleCase(
        en.casual.casual, "Last Saturday", DateTime("Tue Aug 2 2022"),
        (ParsedResult result, String text) {
      expect(result.start.get("day"), 30);
      expect(result.start.get("month"), 7);
      expect(result.start.get("year"), 2022);
    });
     testSingleCase(en.casual.casual, "Last Sunday", DateTime("Tue Aug 2 2022"),
        (ParsedResult result, String text) {
      expect(result.start.get("day"), 31);
      expect(result.start.get("month"), 7);
      expect(result.start.get("year"), 2022);
    });
     testSingleCase(
        en.casual.casual, "Last Wednesday", DateTime("Tue Aug 2 2022"),
        (ParsedResult result, String text) {
      expect(result.start.get("day"), 27);
      expect(result.start.get("month"), 7);
      expect(result.start.get("year"), 2022);
    });
   });
   test("Test - Weekday casual `Next` guessing", () {
     {
      final refDate = DateTime("Tue Aug 2 2022");
      testSingleCase(en.casual.casual, "Next Saturday", refDate,
          (ParsedResult result, String text) {
        expect(result.start.get("day"), 13);
        expect(result.start.get("month"), 8);
        expect(result.start.get("year"), 2022);
      });
      testSingleCase(en.casual.casual, "Next Sunday", refDate,
          (ParsedResult result, String text) {
        expect(result.start.get("day"), 14);
        expect(result.start.get("month"), 8);
        expect(result.start.get("year"), 2022);
      });
      testSingleCase(en.casual.casual, "Next Wednesday", refDate,
          (ParsedResult result, String text) {
        expect(result.start.get("day"), 10);
        expect(result.start.get("month"), 8);
        expect(result.start.get("year"), 2022);
      });
    }
    {
      final refDate = DateTime("Saturday Aug 6 2022");
      testSingleCase(en.casual.casual, "Next Saturday", refDate,
          (ParsedResult result, String text) {
        expect(result.start.get("day"), 13);
        expect(result.start.get("month"), 8);
        expect(result.start.get("year"), 2022);
      });
      testSingleCase(en.casual.casual, "Next Sunday", refDate,
          (ParsedResult result, String text) {
        expect(result.start.get("day"), 14);
        expect(result.start.get("month"), 8);
        expect(result.start.get("year"), 2022);
      });
      testSingleCase(en.casual.casual, "Next Wednesday", refDate,
          (ParsedResult result, String text) {
        expect(result.start.get("day"), 10);
        expect(result.start.get("month"), 8);
        expect(result.start.get("year"), 2022);
      });
    }
    {
      final refDate = DateTime("Sun Aug 7 2022");
      testSingleCase(en.casual.casual, "Next Saturday", refDate,
          (ParsedResult result, String text) {
        expect(result.start.get("day"), 13);
        expect(result.start.get("month"), 8);
        expect(result.start.get("year"), 2022);
      });
      testSingleCase(en.casual.casual, "Next Sunday", refDate,
          (ParsedResult result, String text) {
        expect(result.start.get("day"), 14);
        expect(result.start.get("month"), 8);
        expect(result.start.get("year"), 2022);
      });
      testSingleCase(en.casual.casual, "Next Wednesday", refDate,
          (ParsedResult result, String text) {
        expect(result.start.get("day"), 10);
        expect(result.start.get("month"), 8);
        expect(result.start.get("year"), 2022);
      });
    }
   });
   test("Test - Weekday With Casual Time", () {
     testSingleCase(
        en.casual.casual, "Lets meet on Tuesday morning", DateTime(2015, 3, 18),
        (ParsedResult result, String text) {
      expect(result.index, 10);
      expect(result.text, "on Tuesday morning");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2015);
      expect(result.start.get("month"), 4);
      expect(result.start.get("day"), 21);
      expect(result.start.get("weekday"), 2);
      expect(result.start.get("hour"), 6);
      expect(result.start).toBeDate(DateTime(2015, 3, 21, 6));
    });
   });
   test("Test - Weekday Overlap", () {
     testSingleCase(
        en.casual.casual, "Sunday, December 7, 2014", DateTime(2012, 7, 9),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "Sunday, December 7, 2014");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2014);
      expect(result.start.get("month"), 12);
      expect(result.start.get("day"), 7);
      expect(result.start.get("weekday"), 0);
      expect(result.start.isCertain("day"), true);
      expect(result.start.isCertain("month"), true);
      expect(result.start.isCertain("year"), true);
      expect(result.start.isCertain("weekday"), true);
      expect(result.start).toBeDate(DateTime(2014, 12 - 1, 7, 12));
    });
     testSingleCase(en.casual.casual, "Sunday 12/7/2014", DateTime(2012, 7, 9),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "Sunday 12/7/2014");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2014);
      expect(result.start.get("month"), 12);
      expect(result.start.get("day"), 7);
      expect(result.start.get("weekday"), 0);
      expect(result.start.isCertain("day"), true);
      expect(result.start.isCertain("month"), true);
      expect(result.start.isCertain("year"), true);
      expect(result.start.isCertain("weekday"), true);
      expect(result.start).toBeDate(DateTime(2014, 12 - 1, 7, 12));
    });
   });
   test("Test - Weekday range", () {
     testSingleCase(
        en.casual.casual, "Friday to Monday", DateTime(2023, 4 - 1, 9),
        (ParsedResult result, String text) {
      expect(result.start.get("year"), 2023);
      expect(result.start.get("month"), 4);
      expect(result.start.get("day"), 7);
      expect(result.start.get("weekday"), 5);
      expect(result.end.get("year"), 2023);
      expect(result.end.get("month"), 4);
      expect(result.end.get("day"), 10);
      expect(result.end.get("weekday"), 1);
    });
     testSingleCase(
        en.casual.casual, "Monday to Friday", DateTime(2023, 4 - 1, 9),
        (ParsedResult result, String text) {
      expect(result.start.get("year"), 2023);
      expect(result.start.get("month"), 4);
      expect(result.start.get("day"), 10);
      expect(result.start.get("weekday"), 1);
      expect(result.end.get("year"), 2023);
      expect(result.end.get("month"), 4);
      expect(result.end.get("day"), 14);
      expect(result.end.get("weekday"), 5);
    });
   });
   test("Test - forward dates only option", () {
     testSingleCase(
        en.casual.casual,
        "Monday (forward dates only)",
        DateTime(2012, 7, 9),
        {"forwardDate": true}, (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "Monday");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2012);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 13);
      expect(result.start.get("weekday"), 1);
      expect(result.start.isCertain("day"), false);
      expect(result.start.isCertain("month"), false);
      expect(result.start.isCertain("year"), false);
      expect(result.start.isCertain("weekday"), true);
      expect(result.start).toBeDate(DateTime(2012, 7, 13, 12));
    });
     testSingleCase(
        en.casual.casual,
        "this Friday to this Monday",
        DateTime(2016, 8 - 1, 4),
        {"forwardDate": true}, (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "this Friday to this Monday");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 5);
      expect(result.start.get("weekday"), 5);
      expect(result.start.isCertain("day"), false);
      expect(result.start.isCertain("month"), false);
      expect(result.start.isCertain("year"), false);
      expect(result.start.isCertain("weekday"), true);
      expect(result.start).toBeDate(DateTime(2016, 8 - 1, 5, 12));
      expect(result.end == null, isFalse);
      expect(result.end.get("year"), 2016);
      expect(result.end.get("month"), 8);
      expect(result.end.get("day"), 8);
      expect(result.end.get("weekday"), 1);
      expect(result.end.isCertain("day"), false);
      expect(result.end.isCertain("month"), false);
      expect(result.end.isCertain("year"), false);
      expect(result.end.isCertain("weekday"), true);
      expect(result.end).toBeDate(DateTime(2016, 8 - 1, 8, 12));
    });
     testSingleCase(
        en.casual.casual,
        "sunday morning",
        DateTime("August 15, 2021, 20:00"),
        {"forwardDate": true}, (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "sunday morning");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2021);
      expect(result.start.get("month"), 8);
      expect(result.start.get("day"), 22);
      expect(result.start.get("weekday"), 0);
      expect(result.start.isCertain("day"), false);
      expect(result.start.isCertain("month"), false);
      expect(result.start.isCertain("year"), false);
      expect(result.start.isCertain("weekday"), true);
      expect(result.start).toBeDate(DateTime(2021, 8 - 1, 22, 6));
    });
     testSingleCase(
        en.casual.casual,
        "vacation monday - friday",
        DateTime("thursday 13 June 2019"),
        {"forwardDate": true}, (ParsedResult result, String text) {
      expect(result.text, "monday - friday");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2019);
      expect(result.start.get("month"), 6);
      expect(result.start.get("day"), 17);
      expect(result.end == null, isFalse);
      expect(result.end.get("year"), 2019);
      expect(result.end.get("month"), 6);
      expect(result.end.get("day"), 21);
    });
   });
 }
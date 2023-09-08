import 'package:chrono/locales/en/index.dart' as en;
import 'package:chrono/types.dart';
import "package:flutter_test/flutter_test.dart";

import '../test_util.dart';

 void main() {
   test("Test - Single Expression", () {
    testSingleCase(en.casual, "Monday", DateTime(2012, 8, 9),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "Monday");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 6);
      expect(result.start.get(Component.weekday), 1);
      expect(result.start.isCertain(Component.day), false);
      expect(result.start.isCertain(Component.month), false);
      expect(result.start.isCertain(Component.year), false);
      expect(result.start.isCertain(Component.weekday), true);
      expectToBeDate(result.start , DateTime(2012, 8, 6, 12));
    });
    testSingleCase(en.casual, "Thursday", DateTime(2012, 8, 9),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "Thursday");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 9);
      expect(result.start.get(Component.weekday), 4);
      expectToBeDate(result.start , DateTime(2012, 8, 9, 12));
    });
    testSingleCase(en.casual, "Sunday", DateTime(2012, 8, 9),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "Sunday");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 12);
      expect(result.start.get(Component.weekday), 0);
      expectToBeDate(result.start , DateTime(2012, 8, 12, 12));
    });
    testSingleCase(en.casual, "The Deadline is last Friday...",
        DateTime(2012, 8, 9), (ParsedResult result, String text) {
      expect(result.index, 16);
      expect(result.text, "last Friday");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 3);
      expect(result.start.get(Component.weekday), 5);
      expectToBeDate(result.start , DateTime(2012, 8, 3, 12));
    });
     testSingleCase(en.casual, "The Deadline is past Friday...",
        DateTime(2012, 8, 9), (ParsedResult result, String text) {
      expect(result.index, 16);
      expect(result.text, "past Friday");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 3);
      expect(result.start.get(Component.weekday), 5);
      expectToBeDate(result.start , DateTime(2012, 8, 3, 12));
    });
     testSingleCase(
         en.casual, "Let's have a meeting on Friday next week",
        DateTime.parse("2015-04-18"), (ParsedResult result, String text) {
      expect(result.index, 21);
      expect(result.text, "on Friday next week");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2015);
      expect(result.start.get(Component.month), 4);
      expect(result.start.get(Component.day), 24);
      expect(result.start.get(Component.weekday), 5);
      expectToBeDate(result.start , DateTime(2015, 4, 24, 12));
    });
     testSingleCase(
         en.casual,
        "I plan on taking the day off on Tuesday, next week",
        DateTime(2015, 4, 18), (ParsedResult result, String text) {
      expect(result.index, 29);
      expect(result.text, "on Tuesday, next week");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2015);
      expect(result.start.get(Component.month), 4);
      expect(result.start.get(Component.day), 21);
      expect(result.start.get(Component.weekday), 2);
      expectToBeDate(result.start , DateTime(2015, 4, 21, 12));
    });
   });
   test("Test - Weekday casual `This` guessing", () {
     testSingleCase(
        en.casual, "This Saturday", DateTime.parse("2022-08-02"),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.day), 6);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.year), 2022);
    });
     testSingleCase(en.casual, "This Sunday", DateTime.parse("2022-08-02"),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.day), 7);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.year), 2022);
    });
     testSingleCase(
        en.casual, "This Wednesday", DateTime.parse("2022-08-02"),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.day), 3);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.year), 2022);
    });
     testSingleCase(
        en.casual, "This Saturday", DateTime.parse("2022-08-07"),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.day), 13);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.year), 2022);
    });
     testSingleCase(en.casual, "This Sunday", DateTime.parse("2022-08-07"),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.day), 7);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.year), 2022);
    });
     testSingleCase(
        en.casual, "This Wednesday", DateTime.parse("2022-08-07"),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.day), 10);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.year), 2022);
    });
   });
   test("Test - Weekday casual `Last` guessing", () {
     testSingleCase(
        en.casual, "Last Saturday", DateTime.parse("2022-08-02"),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.day), 30);
      expect(result.start.get(Component.month), 7);
      expect(result.start.get(Component.year), 2022);
    });
     testSingleCase(en.casual, "Last Sunday", DateTime.parse("2022-08-02"),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.day), 31);
      expect(result.start.get(Component.month), 7);
      expect(result.start.get(Component.year), 2022);
    });
     testSingleCase(
        en.casual, "Last Wednesday", DateTime.parse("2022-08-02"),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.day), 27);
      expect(result.start.get(Component.month), 7);
      expect(result.start.get(Component.year), 2022);
    });
   });
   test("Test - Weekday casual `Next` guessing", () {
     {
      final refDate = DateTime.parse("2022-08-02");
      testSingleCase(en.casual, "Next Saturday", refDate,
          (ParsedResult result, String text) {
        expect(result.start.get(Component.day), 13);
        expect(result.start.get(Component.month), 8);
        expect(result.start.get(Component.year), 2022);
      });
      testSingleCase(en.casual, "Next Sunday", refDate,
          (ParsedResult result, String text) {
        expect(result.start.get(Component.day), 14);
        expect(result.start.get(Component.month), 8);
        expect(result.start.get(Component.year), 2022);
      });
      testSingleCase(en.casual, "Next Wednesday", refDate,
          (ParsedResult result, String text) {
        expect(result.start.get(Component.day), 10);
        expect(result.start.get(Component.month), 8);
        expect(result.start.get(Component.year), 2022);
      });
    }
    {
      final refDate = DateTime.parse("2022-08-06");
      testSingleCase(en.casual, "Next Saturday", refDate,
          (ParsedResult result, String text) {
        expect(result.start.get(Component.day), 13);
        expect(result.start.get(Component.month), 8);
        expect(result.start.get(Component.year), 2022);
      });
      testSingleCase(en.casual, "Next Sunday", refDate,
          (ParsedResult result, String text) {
        expect(result.start.get(Component.day), 14);
        expect(result.start.get(Component.month), 8);
        expect(result.start.get(Component.year), 2022);
      });
      testSingleCase(en.casual, "Next Wednesday", refDate,
          (ParsedResult result, String text) {
        expect(result.start.get(Component.day), 10);
        expect(result.start.get(Component.month), 8);
        expect(result.start.get(Component.year), 2022);
      });
    }
    {
      final refDate = DateTime.parse("2022-08-07");
      testSingleCase(en.casual, "Next Saturday", refDate,
          (ParsedResult result, String text) {
        expect(result.start.get(Component.day), 13);
        expect(result.start.get(Component.month), 8);
        expect(result.start.get(Component.year), 2022);
      });
      testSingleCase(en.casual, "Next Sunday", refDate,
          (ParsedResult result, String text) {
        expect(result.start.get(Component.day), 14);
        expect(result.start.get(Component.month), 8);
        expect(result.start.get(Component.year), 2022);
      });
      testSingleCase(en.casual, "Next Wednesday", refDate,
          (ParsedResult result, String text) {
        expect(result.start.get(Component.day), 10);
        expect(result.start.get(Component.month), 8);
        expect(result.start.get(Component.year), 2022);
      });
    }
   });
   test("Test - Weekday With Casual Time", () {
     testSingleCase(
        en.casual, "Lets meet on Tuesday morning", DateTime(2015, 4, 18),
        (ParsedResult result, String text) {
      expect(result.index, 10);
      expect(result.text, "on Tuesday morning");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2015);
      expect(result.start.get(Component.month), 4);
      expect(result.start.get(Component.day), 21);
      expect(result.start.get(Component.weekday), 2);
      expect(result.start.get(Component.hour), 6);
      expectToBeDate(result.start , DateTime(2015, 4, 21, 6));
    });
   });
   test("Test - Weekday Overlap", () {
     testSingleCase(
        en.casual, "Sunday, December 7, 2014", DateTime(2012, 7, 9),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "Sunday, December 7, 2014");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2014);
      expect(result.start.get(Component.month), 12);
      expect(result.start.get(Component.day), 7);
      expect(result.start.get(Component.weekday), 0);
      expect(result.start.isCertain(Component.day), true);
      expect(result.start.isCertain(Component.month), true);
      expect(result.start.isCertain(Component.year), true);
      expect(result.start.isCertain(Component.weekday), true);
      expectToBeDate(result.start , DateTime(2014, 12 , 7, 12));
    });
     testSingleCase(en.casual, "Sunday 12/7/2014", DateTime(2012, 7, 9),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "Sunday 12/7/2014");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2014);
      expect(result.start.get(Component.month), 12);
      expect(result.start.get(Component.day), 7);
      expect(result.start.get(Component.weekday), 0);
      expect(result.start.isCertain(Component.day), true);
      expect(result.start.isCertain(Component.month), true);
      expect(result.start.isCertain(Component.year), true);
      expect(result.start.isCertain(Component.weekday), true);
      expectToBeDate(result.start , DateTime(2014, 12 , 7, 12));
    });
   });
   test("Test - Weekday range", () {
     testSingleCase(
        en.casual, "Friday to Monday", DateTime(2023, 4 , 9),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2023);
      expect(result.start.get(Component.month), 4);
      expect(result.start.get(Component.day), 7);
      expect(result.start.get(Component.weekday), 5);
      expect(result.end!.get(Component.year), 2023);
      expect(result.end!.get(Component.month), 4);
      expect(result.end!.get(Component.day), 10);
      expect(result.end!.get(Component.weekday), 1);
    });
     testSingleCase(
        en.casual, "Monday to Friday", DateTime(2023, 4 , 9),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2023);
      expect(result.start.get(Component.month), 4);
      expect(result.start.get(Component.day), 10);
      expect(result.start.get(Component.weekday), 1);
      expect(result.end!.get(Component.year), 2023);
      expect(result.end!.get(Component.month), 4);
      expect(result.end!.get(Component.day), 14);
      expect(result.end!.get(Component.weekday), 5);
    });
   });
   test("Test - forward dates only option", () {
     testSingleCase(
        en.casual,
        "Monday (forward dates only)",
        DateTime(2012, 8, 9),
         ParsingOption(forwardDate:true), (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "Monday");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 13);
      expect(result.start.get(Component.weekday), 1);
      expect(result.start.isCertain(Component.day), false);
      expect(result.start.isCertain(Component.month), false);
      expect(result.start.isCertain(Component.year), false);
      expect(result.start.isCertain(Component.weekday), true);
      expectToBeDate(result.start , DateTime(2012, 8, 13, 12));
    });
     testSingleCase(
        en.casual,
        "this Friday to this Monday",
        DateTime(2016, 8 , 4),
         ParsingOption(forwardDate:true), (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "this Friday to this Monday");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 5);
      expect(result.start.get(Component.weekday), 5);
      expect(result.start.isCertain(Component.day), false);
      expect(result.start.isCertain(Component.month), false);
      expect(result.start.isCertain(Component.year), false);
      expect(result.start.isCertain(Component.weekday), true);
      expectToBeDate(result.start , DateTime(2016, 8 , 5, 12));
      expect(result.end == null, isFalse);
      expect(result.end!.get(Component.year), 2016);
      expect(result.end!.get(Component.month), 8);
      expect(result.end!.get(Component.day), 8);
      expect(result.end!.get(Component.weekday), 1);
      expect(result.end!.isCertain(Component.day), false);
      expect(result.end!.isCertain(Component.month), false);
      expect(result.end!.isCertain(Component.year), false);
      expect(result.end!.isCertain(Component.weekday), true);
      expectToBeDate(result.end! , DateTime(2016, 8 , 8, 12));
    });
     testSingleCase(
        en.casual,
        "sunday morning",
        DateTime.parse("2021-08-15T20:00"),
         ParsingOption(forwardDate:true), (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "sunday morning");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2021);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 22);
      expect(result.start.get(Component.weekday), 0);
      expect(result.start.isCertain(Component.day), false);
      expect(result.start.isCertain(Component.month), false);
      expect(result.start.isCertain(Component.year), false);
      expect(result.start.isCertain(Component.weekday), true);
      expectToBeDate(result.start , DateTime(2021, 8 , 22, 6));
    });
     testSingleCase(
        en.casual,
        "vacation monday - friday",
        DateTime.parse("2019-06-14"),
         ParsingOption(forwardDate:true), (ParsedResult result, String text) {
      expect(result.text, "monday - friday");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2019);
      expect(result.start.get(Component.month), 6);
      expect(result.start.get(Component.day), 17);
      expect(result.end == null, isFalse);
      expect(result.end!.get(Component.year), 2019);
      expect(result.end!.get(Component.month), 6);
      expect(result.end!.get(Component.day), 21);
    });
   });
 }
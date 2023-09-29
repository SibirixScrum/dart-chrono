
import 'package:chrono/locales/en/index.dart' as en;
import "package:chrono/locales/en/parsers/ENTimeExpressionParser.dart";
import "package:chrono/types.dart";
import "package:flutter_test/flutter_test.dart";

import "../test_util.dart"
    show expectToBeDate, testSingleCase, testUnexpectedResult;

void main() {
  test("Test - Date + Time Expression", () {
    testSingleCase(en.casual, "Something happen on 2014-04-18 13:00 - 16:00 as",
        (ParsedResult result, String text) {
          expect(result.text, "2014-04-18 13:00 - 16:00");
      expectToBeDate(result.start, DateTime(2014, 4 , 18, 13));
      expectToBeDate(result.end!, DateTime(2014, 4 , 18, 16));
    });
  });
  test("Test - Time Expression", () {
    testSingleCase(en.casual, "between 3:30-4:30pm", DateTime(2020, 7 , 6),
        (ParsedResult result, String text) {
          expect(result.text, "3:30-4:30pm");
      expectToBeDate(result.start, DateTime(2020, 7 , 6, 15, 30));
      expectToBeDate(result.end!, DateTime(2020, 7 , 6, 16, 30));
    });
    testSingleCase(en.casual, "9:00 PST", DateTime(2020, 7 , 6),
        (ParsedResult result, String text) {
          expect(result.text, "9:00 PST");
      expect(result.start.get(Component.hour), 9);
      expect(result.start.get(Component.minute), 0);
      expect(result.start.get(Component.timezoneOffset), -480);
    });
  });
  test("Test - Quoted Expressions", () {
    testSingleCase(en.casual, "Want to meet for dinner (5pm EST)?",
        DateTime(2020, 7 , 6), (ParsedResult result, String text) {
          expect(result.text.contains("5pm EST"), true);
    });
    testSingleCase(en.casual, "between '3:30-4:30pm'", DateTime(2020, 7 , 6),
        (ParsedResult result, String text) {
      expect(result.text.contains("3:30-4:30pm"), true);
      expectToBeDate(result.start, DateTime(2020, 7 , 6, 15, 30));
      expectToBeDate(result.end!, DateTime(2020, 7 , 6, 16, 30));
    });
    testSingleCase(en.casual, "The date is '2014-04-18'",
        (ParsedResult result, String text) {
      expect(result.text.contains("2014-04-18"), true);
      expectToBeDate(result.start, DateTime(2014, 4 , 18, 12));
    });
  });
  test("Test - Strict Mode", () {
    testUnexpectedResult(en.strict, "Tuesday");
  });
  test("Test - Built-in English variants", () {
    testSingleCase(en.casual, "6/10/2018", (ParsedResult result, String text) {
      expectToBeDate(result.start, DateTime(2018, 6 , 10, 12));
    });
    // testSingleCase(en.casual.en.GB, "6/10/2018",
    //     (ParsedResult result, String text) {
    //   expectToBeDate(result.start,DateTime(2018, 10 , 6, 12));
    // });
  });
  test("Test - Random text", () {
    testSingleCase(en.casual,
        "Adam <Adam@supercalendar.com> написал(а):\nThe date is 02.07.2013",
        (ParsedResult result, String text) {
      expect(result.text, "02.07.2013");
    });
    testSingleCase(en.casual, "174 November 1,2001- March 31,2002",
        (ParsedResult result, String text) {
      expect(result.text, "November 1,2001- March 31,2002");
    });
    testSingleCase(
        en.casual, "...Thursday, December 15, 2011 Best Available Rate ",
        (ParsedResult result, String text) {
          expect(result.text, "Thursday, December 15, 2011");
      expect(result.start.get(Component.year), 2011);
    });
    testSingleCase(en.casual, "SUN 15SEP 11:05 AM - 12:50 PM",
        (ParsedResult result, String text) {
          expect(result.text, "SUN 15SEP 11:05 AM - 12:50 PM");
      expect(result.end!.get(Component.hour), 12);
      expect(result.end!.get(Component.minute), 50);
    });
    testSingleCase(en.casual, "FRI 13SEP 1:29 PM - FRI 13SEP 3:29 PM",
        (ParsedResult result, String text) {
          expect(result.text, "FRI 13SEP 1:29 PM - FRI 13SEP 3:29 PM");
      expect(result.start.get(Component.day), 13);
      expect(result.start.get(Component.hour), 13);
      expect(result.start.get(Component.minute), 29);
      expect(result.end!.get(Component.day), 13);
      expect(result.end!.get(Component.hour), 15);
      expect(result.end!.get(Component.minute), 29);
    });
    testSingleCase(en.casual, "9:00 AM to 5:00 PM, Tuesday, 20 May 2013",
        (ParsedResult result, String text) {
          expect(result.text, "9:00 AM to 5:00 PM, Tuesday, 20 May 2013");
      expectToBeDate(result.start, DateTime(2013, 5, 20, 9, 0));
      expectToBeDate(result.end!, DateTime(2013, 5, 20, 17, 0));
    });
    testSingleCase(
        en.casual, "Monday afternoon to last night", DateTime(2017, 7 , 7),
        (ParsedResult result, String text) {
          expect(result.text, "Monday afternoon to last night");
      expect(result.start.get(Component.day), 3);
      expect(result.start.get(Component.month), 7);
      expect(result.end!.get(Component.day), 7);
      expect(result.end!.get(Component.month), 7);
    });
    testSingleCase(en.casual, "03-27-2022, 02:00 AM", DateTime(2017, 7 , 7),
        (ParsedResult result, String text) {
          expect(result.text, "03-27-2022, 02:00 AM");
      expect(result.start.get(Component.day), 27);
      expect(result.start.get(Component.month), 3);
      expect(result.start.get(Component.year), 2022);
      expect(result.start.get(Component.hour), 2);
      expect(result.start.get(Component.meridiem), Meridiem.AM.index);
    });
  });
  test("Test - Wikipedia Texts", () {
    final text =
        "October 7, 2011, of which details were not revealed out of respect to Jobs's family.[239] " +
            "Apple announced on the same day that they had no plans for a public service, but were encouraging " +
            "\"well-wishers\" to send their remembrance messages to an email address created to receive such messages.[240] " +
            "Sunday, October 16, 2011";
    final results = en.casual.parse(text, referenceDate: DateTime(2012, 7, 10));
    expect(results.length, 2);
    {
      final result = results[0];
      expect(result.start.get(Component.year), 2011);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.day), 7);
      expect(result.index, 0);
      expect(result.text, "October 7, 2011");
    }
    {
      final result = results[1];
      expect(result.start.get(Component.year), 2011);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.day), 16);
      expect(result.index, 297);
      expect(result.text, "Sunday, October 16, 2011");
    }
  });
  test("Test - Parse multiple date results", () {
    const text =
        "I will see you at 2:30. If not I will see you somewhere between 3:30-4:30pm";
    final results = en.casual.parse(text, referenceDate: DateTime(2020, 7, 6));
    expect(results.length, 2);
    {
      final result = results[0];
      expect(result.text, "at 2:30");
      expect(result.start.get(Component.year), 2020);
      expect(result.start.get(Component.month), 7);
      expect(result.start.get(Component.day), 6);
      expect(result.start.get(Component.hour), 2);
      expect(result.end, null);
    }
    {
      final result = results[1];
      expect(result.text, "3:30-4:30pm");
      expect(result.start.get(Component.hour), 15);
      expect(result.start.get(Component.minute), 30);
      expect(result.end!.get(Component.hour), 16);
      expect(result.end!.get(Component.minute), 30);
    }
  });
  test("Test - Customize by removing time extraction", () {
    final custom = en.casual.clone();
    custom.parsers = custom.parsers
        .where((element) => element is! ENTimeExpressionParser)
        .toList();
    custom.parse("Thursday 9AM");
    testSingleCase(custom, "Thursday 9AM", DateTime(2020, 11 , 29),
        (ParsedResult result, String text) {
      expect(result.text, "Thursday");
      expect(result.start.get(Component.year), 2020);
      expect(result.start.get(Component.month), 11);
      expect(result.start.get(Component.day), 26);
    });
  });
}

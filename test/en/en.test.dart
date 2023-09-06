
import "package:flutter_test/flutter_test.dart";
import 'package:chrono/locales/en/index.dart' as en;
import "../test_util.dart" show testSingleCase, testUnexpectedResult;


void main() {
  test("Test - Date + Time Expression", () {
    testSingleCase(en.casual, "Something happen on 2014-04-18 13:00 - 16:00 as",
        (result) {
      expect(result.text).toBe("2014-04-18 13:00 - 16:00");
      expect(result.start).toBeDate(new Date(2014, 4 - 1, 18, 13));
      expect(result.end).toBeDate(new Date(2014, 4 - 1, 18, 16));
    });
  });
  test("Test - Time Expression", () {
    testSingleCase(en.casual, "between 3:30-4:30pm", new Date(2020, 7 - 1, 6),
        (result) {
      expect(result.text).toBe("3:30-4:30pm");
      expect(result.start).toBeDate(new Date(2020, 7 - 1, 6, 15, 30));
      expect(result.end).toBeDate(new Date(2020, 7 - 1, 6, 16, 30));
    });
    testSingleCase(en.casual, "9:00 PST", new Date(2020, 7 - 1, 6), (result) {
      expect(result.text).toBe("9:00 PST");
      expect(result.start.get("hour")).toBe(9);
      expect(result.start.get("minute")).toBe(0);
      expect(result.start.get("timezoneOffset")).toBe(-480);
    });
  });
  test("Test - Quoted Expressions", () {
    testSingleCase(
        en.casual, "Want to meet for dinner (5pm EST)?", new Date(2020, 7 - 1, 6),
        (result) {
      expect(result.text).toContain("5pm EST");
    });
    testSingleCase(en.casual, "between '3:30-4:30pm'", new Date(2020, 7 - 1, 6),
        (result) {
      expect(result.text).toContain("3:30-4:30pm");
      expect(result.start).toBeDate(new Date(2020, 7 - 1, 6, 15, 30));
      expect(result.end).toBeDate(new Date(2020, 7 - 1, 6, 16, 30));
    });
    testSingleCase(en.casual, "The date is '2014-04-18'", (result) {
      expect(result.text).toContain("2014-04-18");
      expect(result.start).toBeDate(new Date(2014, 4 - 1, 18, 12));
    });
  });
  test("Test - Strict Mode", () {
    testUnexpectedResult(en.casual.strict, "Tuesday");
  });
  test("Test - Built-in English variants", () {
    testSingleCase(en.casual.en, "6/10/2018", (result) {
      expect(result.start).toBeDate(new Date(2018, 6 - 1, 10, 12));
    });
    testSingleCase(en.casual.en.GB, "6/10/2018", (result) {
      expect(result.start).toBeDate(new Date(2018, 10 - 1, 6, 12));
    });
  });
  test("Test - Random text", () {
    testSingleCase(en.casual,
        "Adam <Adam@supercalendar.com> написал(а):\nThe date is 02.07.2013",
        (result) {
      expect(result.text).toBe("02.07.2013");
    });
    testSingleCase(en.casual, "174 November 1,2001- March 31,2002", (result) {
      expect(result.text).toBe("November 1,2001- March 31,2002");
    });
    testSingleCase(
        en.casual, "...Thursday, December 15, 2011 Best Available Rate ",
        (result) {
      expect(result.text).toBe("Thursday, December 15, 2011");
      expect(result.start.get("year")).toBe(2011);
    });
    testSingleCase(en.casual, "SUN 15SEP 11:05 AM - 12:50 PM", (result) {
      expect(result.text).toBe("SUN 15SEP 11:05 AM - 12:50 PM");
      expect(result.end.get("hour")).toBe(12);
      expect(result.end.get("minute")).toBe(50);
    });
    testSingleCase(en.casual, "FRI 13SEP 1:29 PM - FRI 13SEP 3:29 PM", (result) {
      expect(result.text).toBe("FRI 13SEP 1:29 PM - FRI 13SEP 3:29 PM");
      expect(result.start.get("day")).toBe(13);
      expect(result.start.get("hour")).toBe(13);
      expect(result.start.get("minute")).toBe(29);
      expect(result.end.get("day")).toBe(13);
      expect(result.end.get("hour")).toBe(15);
      expect(result.end.get("minute")).toBe(29);
    });
    testSingleCase(en.casual, "9:00 AM to 5:00 PM, Tuesday, 20 May 2013",
        (result) {
      expect(result.text).toBe("9:00 AM to 5:00 PM, Tuesday, 20 May 2013");
      expect(result.start).toBeDate(new Date(2013, 4, 20, 9, 0));
      expect(result.end).toBeDate(new Date(2013, 4, 20, 17, 0));
    });
    testSingleCase(
        en.casual, "Monday afternoon to last night", new Date(2017, 7 - 1, 7),
        (result) {
      expect(result.text).toBe("Monday afternoon to last night");
      expect(result.start.get("day")).toBe(3);
      expect(result.start.get("month")).toBe(7);
      expect(result.end.get("day")).toBe(7);
      expect(result.end.get("month")).toBe(7);
    });
    testSingleCase(en.casual, "03-27-2022, 02:00 AM", new Date(2017, 7 - 1, 7),
        (result) {
      expect(result.text).toBe("03-27-2022, 02:00 AM");
      expect(result.start.get("day")).toBe(27);
      expect(result.start.get("month")).toBe(3);
      expect(result.start.get("year")).toBe(2022);
      expect(result.start.get("hour")).toBe(2);
      expect(result.start.get("meridiem")).toBe(Meridiem.AM);
    });
  });
  test("Test - Wikipedia Texts", () {
    final text =
        "October 7, 2011, of which details were not revealed out of respect to Jobs's family.[239] " +
            "Apple announced on the same day that they had no plans for a public service, but were encouraging " +
            "\"well-wishers\" to send their remembrance messages to an email address created to receive such messages.[240] " +
            "Sunday, October 16, 2011";
    final results = en.casual.parse(text, new Date(2012, 7, 10));
    expect(results.length).toBe(2);
    {
      final result = results[0];
      expect(result.start.get("year")).toBe(2011);
      expect(result.start.get("month")).toBe(10);
      expect(result.start.get("day")).toBe(7);
      expect(result.index).toBe(0);
      expect(result.text).toBe("October 7, 2011");
    }
    {
      final result = results[1];
      expect(result.start.get("year")).toBe(2011);
      expect(result.start.get("month")).toBe(10);
      expect(result.start.get("day")).toBe(16);
      expect(result.index).toBe(297);
      expect(result.text).toBe("Sunday, October 16, 2011");
    }
  });
  test("Test - Parse multiple date results", () {
    const text =
        "I will see you at 2:30. If not I will see you somewhere between 3:30-4:30pm";
    final results = en.casual.parse(text, new Date(2020, 7 - 1, 6));
    expect(results.length).toBe(2);
    {
      final result = results[0];
      expect(result.text).toBe("at 2:30");
      expect(result.start.get("year")).toBe(2020);
      expect(result.start.get("month")).toBe(7);
      expect(result.start.get("day")).toBe(6);
      expect(result.start.get("hour")).toBe(2);
      expect(result.end).toBeNull();
    }
    {
      final result = results[1];
      expect(result.text).toBe("3:30-4:30pm");
      expect(result.start.get("hour")).toBe(15);
      expect(result.start.get("minute")).toBe(30);
      expect(result.end.get("hour")).toBe(16);
      expect(result.end.get("minute")).toBe(30);
    }
  });
  test("Test - Customize by removing time extraction", () {
    final custom = en.casual.en.casual.clone();
    custom.parsers =
        custom.parsers.filter((p) => !(p is ENTimeExpressionParser));
    custom.parse("Thursday 9AM");
    testSingleCase(custom, "Thursday 9AM", new Date(2020, 11 - 1, 29),
        (result, text) {
      expect(result.text).toBe("Thursday");
      expect(result.start.get("year")).toBe(2020);
      expect(result.start.get("month")).toBe(11);
      expect(result.start.get("day")).toBe(26);
    });
  });
}

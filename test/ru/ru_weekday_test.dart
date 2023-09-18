import 'package:chrono/locales/ru/index.dart' as ru;
import "package:chrono/ported/CustomValues.dart";
import "package:chrono/types.dart";
import "package:flutter_test/flutter_test.dart";

import "../test_util.dart" show ParsingOptionDummy, expectToBeDate, testSingleCase;

void main() {
  test("Test - Single Expression", () {
    testSingleCase(ru.casual, "понедельник", new DateTime(2012, 8, 9),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "понедельник");
      expectToBeDate(result.start, DateTime(2012, 8, 6, 12));
    });
    testSingleCase(ru.casual, "Дедлайн в пятницу...", new DateTime(2012, 8, 9),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "в пятницу");
      expectToBeDate(result.start, new DateTime(2012, 8, 10, 12));
    });
    testSingleCase(
        ru.casual, "Дедлайн в прошлый четверг!", new DateTime(2012, 8, 9),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "в прошлый четверг");
      expectToBeDate(result.start, new DateTime(2012, 8, 2, 12));
    });
    testSingleCase(
        ru.casual, "Дедлайн в следующий вторник", new DateTime(2015, 4, 18),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "в следующий вторник");
      expectToBeDate(result.start, new DateTime(2015, 4, 21, 12));
    });
  });
  test("Test - Weekday With Casual Time", () {
    testSingleCase(
        ru.casual, "Позвони в среду утром", new DateTime(2015, 4, 18),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "в среду утром");
      expectToBeDate(result.start, new DateTime(2015, 4, 15, morningHour));
    });
  });
  test("Test - Weekday Overlap", () {
    testSingleCase(
        ru.casual, "воскресенье, 7 декабря 2014", new DateTime(2012, 8, 9),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "воскресенье, 7 декабря 2014");
      expectToBeDate(result.start, new DateTime(2014, 12, 7, 12));
    });
  });
  test("Test - forward dates only option", () {
    testSingleCase(ru.casual, "В понедельник?", new DateTime(2012, 8, 9),
        ParsingOptionDummy(forwardDate: true), (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "В понедельник");
      expectToBeDate(result.start, new DateTime(2012, 8, 13, 12));
    });
    testSingleCase(ru.casual, "пятница", new DateTime(2023, 9, 18),
        ParsingOptionDummy(forwardDate: true), (ParsedResult result, String text) {
          expect(result.index, 0);
          expect(result.text, "пятница");
          expectToBeDate(result.start, new DateTime(2023, 9, 22, 12));
        });
  });
  test("Test - turn off forward date if 'last' keyword met",(){
    testSingleCase(ru.casual, "прошлый пн", new DateTime(2023, 9, 18),
        ParsingOptionDummy(forwardDate: true), (ParsedResult result, String text) {
          expect(result.index, 0);
          expect(result.text, "прошлый пн");
          expectToBeDate(result.start, new DateTime(2023, 9, 11, 12));
        });
    testSingleCase(ru.casual, "прошлый вт", new DateTime(2023, 9, 18),
        ParsingOptionDummy(forwardDate: true), (ParsedResult result, String text) {
          expect(result.index, 0);
          expect(result.text, "прошлый вт");
          expectToBeDate(result.start, new DateTime(2023, 9, 12, 12));
        });
    testSingleCase(ru.casual, "прошлая ср", new DateTime(2023, 9, 18),
        ParsingOptionDummy(forwardDate: true), (ParsedResult result, String text) {
          expect(result.index, 0);
          expect(result.text, "прошлая ср");
          expectToBeDate(result.start, new DateTime(2023, 9, 13, 12));
        });
    testSingleCase(ru.casual, "прошлый чт", new DateTime(2023, 9, 18),
        ParsingOptionDummy(forwardDate: true), (ParsedResult result, String text) {
          expect(result.index, 0);
          expect(result.text, "прошлый чт");
          expectToBeDate(result.start, new DateTime(2023, 9, 14, 12));
        });
    testSingleCase(ru.casual, "прошлая пт", new DateTime(2023, 9, 18),
        ParsingOptionDummy(forwardDate: true), (ParsedResult result, String text) {
          expect(result.index, 0);
          expect(result.text, "прошлая пт");
          expectToBeDate(result.start, new DateTime(2023, 9, 15, 12));
        });
    testSingleCase(ru.casual, "прошлая сб", new DateTime(2023, 9, 18),
        ParsingOptionDummy(forwardDate: true), (ParsedResult result, String text) {
          expect(result.index, 0);
          expect(result.text, "прошлая сб");
          expectToBeDate(result.start, new DateTime(2023, 9, 16, 12));
        });
    testSingleCase(ru.casual, "прошлое вс", new DateTime(2023, 9, 18),
        ParsingOptionDummy(forwardDate: true), (ParsedResult result, String text) {
          expect(result.index, 0);
          expect(result.text, "прошлое вс");
          expectToBeDate(result.start, new DateTime(2023, 9, 17, 12));
        });
  });
}

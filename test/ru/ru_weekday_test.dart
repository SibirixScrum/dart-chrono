import 'package:chrono/locales/ru/index.dart' as ru;
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
      expectToBeDate(result.start, new DateTime(2015, 4, 15, 6));
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
  });
}

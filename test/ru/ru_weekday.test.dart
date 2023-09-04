import 'package:chrono/locales/ru/index.dart' as ru;
import "package:flutter_test/flutter_test.dart";

import "../test_util.dart" show testSingleCase, expectToBeDate;

void main() {
  test("Test - Single Expression", () {
    testSingleCase(ru.casual, "понедельник", new DateTime(2012, 7, 9),
        (result) {
      expect(result.index, 0);
      expect(result.text, "понедельник");
      expectToBeDate(result.start, DateTime(2012, 7, 6, 12));
    });
    testSingleCase(ru.casual, "Дедлайн в пятницу...", new DateTime(2012, 7, 9),
        (result) {
      expect(result.index, 8);
      expect(result.text, "в пятницу");
      expectToBeDate(result.start, new DateTime(2012, 7, 10, 12));
    });
    testSingleCase(
        ru.casual, "Дедлайн в прошлый четверг!", new DateTime(2012, 7, 9),
        (result) {
      expect(result.index, 8);
      expect(result.text, "в прошлый четверг");
      expectToBeDate(result.start, new DateTime(2012, 7, 2, 12));
    });
    testSingleCase(
        ru.casual, "Дедлайн в следующий вторник", new DateTime(2015, 3, 18),
        (result) {
      expect(result.index, 8);
      expect(result.text, "в следующий вторник");
      expectToBeDate(result.start, new DateTime(2015, 3, 21, 12));
    });
  });
  test("Test - Weekday With Casual Time", () {
    testSingleCase(
        ru.casual, "Позвони в среду утром", new DateTime(2015, 3, 18),
        (result) {
      expect(result.index, 8);
      expect(result.text, "в среду утром");
      expectToBeDate(result.start, new DateTime(2015, 3, 15, 6));
    });
  });
  test("Test - Weekday Overlap", () {
    testSingleCase(
        ru.casual, "воскресенье, 7 декабря 2014", new DateTime(2012, 7, 9),
        (result) {
      expect(result.index, 0);
      expect(result.text, "воскресенье, 7 декабря 2014");
      expectToBeDate(result.start, new DateTime(2014, 12 - 1, 7, 12));
    });
  });
  test("Test - forward dates only option", () {
    testSingleCase(ru.casual, "В понедельник?", new DateTime(2012, 7, 9),
        {"forwardDate": true}, (result, _) {
      expect(result.index, 0);
      expect(result.text, "В понедельник");
      expectToBeDate(result.start, new DateTime(2012, 7, 13, 12));
    });
  });
}

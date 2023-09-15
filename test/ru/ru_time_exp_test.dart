import 'package:chrono/locales/ru/index.dart' as ru;
import 'package:chrono/types.dart';
import 'package:flutter_test/flutter_test.dart';

import "../test_util.dart"
    show expectToBeDate, testSingleCase, testUnexpectedResult;

void main() {
  test("Test - Time expression", () {
    testSingleCase(ru.casual, "20:32:13", new DateTime(2016, 10, 1, 8),
        (result, text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2016, 10, 1, 20, 32, 13));
    });
  });
  test("Test - Time range expression", () {
    testSingleCase(
        ru.casual, "10:00:00 - 21:45:01", new DateTime(2016, 10, 1, 8),
        (result, text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2016, 10, 1, 10));
      expectToBeDate(result.end, new DateTime(2016, 10, 1, 21, 45, 1));
    });
  });
  test("Test - Casual time number expression", () {
    testSingleCase(ru.casual, "в 11 утра", new DateTime(2016, 10, 1, 8),
        (result, text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2016, 10, 1, 11));
    });
    testSingleCase(ru.casual, "в 11 вечера", new DateTime(2016, 10, 1, 8),
        (result, text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2016, 10, 1, 23));
    });
  });
  test("Test - Time range's meridiem handling", () {
    testSingleCase(ru.casual, "с 10 до 11 утра", new DateTime(2016, 10, 1, 8),
        (result, text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2016, 10, 1, 10));
      expectToBeDate(result.end, new DateTime(2016, 10, 1, 11));
    });
    testSingleCase(ru.casual, "с 10 до 11 вечера", new DateTime(2016, 10, 1, 8),
        (result, text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2016, 10, 1, 22));
      expectToBeDate(result.end, new DateTime(2016, 10, 1, 23));
    });
    testSingleCase(ru.casual, "в 3 вечера", new DateTime(2016, 10, 1, 8),
            (result, text) {
          expect(result.index, 0);
          expect(result.text, text);
          expectToBeDate(result.start, new DateTime(2016, 10, 1, 15));
        });
    testSingleCase(ru.casual, "в 7 после полудня", new DateTime(2016, 10, 1, 8),
            (result, text) {
          expect(result.index, 0);
          expect(result.text, text);
          expectToBeDate(result.start, new DateTime(2016, 10, 1, 19));
        });
  });
  test("Test - Parsing causal positive cases", () {
    testSingleCase(ru.casual, "в 1", (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "в 1");
      expect(result.start.get(Component.hour), 1);
    });
    testSingleCase(ru.casual, "в 12", (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "в 12");
      expect(result.start.get(Component.hour), 12);
    });
    testSingleCase(ru.casual, "в 12.30", (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "в 12.30");
      expect(result.start.get(Component.hour), 12);
      expect(result.start.get(Component.minute), 30);
    });
  });
  test("Test - Parsing negative cases : [year-like] pattern", () {
    testUnexpectedResult(ru.casual, "2020");
    testUnexpectedResult(ru.casual, "2020  ");
  });
  test("Test - Parsing negative cases : 'at [some numbers]'", () {
    testUnexpectedResult(ru.casual, "Температура 101,194 градусов!");
    testUnexpectedResult(ru.casual, "Температура 101 градусов!");
    testUnexpectedResult(ru.casual, "Температура 10.1");
  });
  test("Test - Parsing negative cases : 'at [some numbers] - [some numbers]'",
      () {
    testUnexpectedResult(ru.casual, "Это в 10.1 - 10.12");
    testUnexpectedResult(ru.casual, "Это в 10 - 10.1");
  });
  test("Test - Parsing negative cases (Strict)", () {
    testUnexpectedResult(ru.strict, "Это в 101,194 телефон!");
    testUnexpectedResult(ru.strict, "Это в 101 стул!");
    testUnexpectedResult(ru.strict, "Это в 10.1");
    testUnexpectedResult(ru.strict, "Это в 10");
    testUnexpectedResult(ru.strict, "2020");
  });
  test(
      "Test - Parsing negative cases : 'at [some numbers] - [some numbers]' (Strict)",
      () {
    testUnexpectedResult(ru.strict, "Это в 10.1 - 10.12");
    testUnexpectedResult(ru.strict, "Это в 10 - 10.1");
    testUnexpectedResult(ru.strict, "Это в 10 - 20");
    testUnexpectedResult(ru.strict, "7-730");
  });
}

import 'package:chrono/locales/ru/index.dart' as ru;
import 'package:chrono/types.dart';
import 'package:flutter_test/flutter_test.dart';

import "../test_util.dart" show expectToBeDate, testSingleCase;

void main() {
  test("Test - Month-Year expression", () {
    testSingleCase(ru.casual, "Сентябрь 2012",
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "Сентябрь 2012");
      expectToBeDate(result.start, new DateTime(2012, 9, 1, 12));
    });
    testSingleCase(ru.casual, "сен 2012", (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "сен 2012");
      expectToBeDate(result.start, new DateTime(2012, 9, 1, 12));
    });
    testSingleCase(ru.casual, "сен. 2012", (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "сен. 2012");
      expectToBeDate(result.start, new DateTime(2012, 9, 1, 12));
    });
    testSingleCase(ru.casual, "сен-2012", (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "сен-2012");
      expectToBeDate(result.start, new DateTime(2012, 9, 1, 12));
    });
  });
  test("Test - Month-Only expression", () {
    testSingleCase(ru.casual, "в январе", new DateTime(2020, 11, 22),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "в январе");
      expectToBeDate(result.start, new DateTime(2021, 1, 1, 12));
    });
    testSingleCase(ru.casual, "в янв", new DateTime(2020, 11 - 1, 22),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "в янв");
      expectToBeDate(result.start, new DateTime(2021, 1, 1, 12));
    });
    testSingleCase(ru.casual, "май", new DateTime(2020, 11, 22),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "май");
      expectToBeDate(result.start, new DateTime(2021, 5, 1, 12));
    });
  });
  test("Test - Month expression in context", () {
    testSingleCase(ru.casual, "Это было в сентябре 2012 перед новым годом",
        (ParsedResult result, String text) {
      expect(result.index, 9);
      expect(result.text, "в сентябре 2012");
      expectToBeDate(result.start, new DateTime(2012, 9, 1, 12));
    });
  });
  test("Test - year 90's parsing", () {
    testSingleCase(ru.casual, "авг 96", new DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "авг 96");
      expectToBeDate(result.start, new DateTime(1996, 8, 1, 12));
    });
    testSingleCase(ru.casual, "96 авг 96", new DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 3);
      expect(result.text, "авг 96");
      expectToBeDate(result.start, new DateTime(1996, 8, 1, 12));
    });
  });
  test("Test - year 20хх's parsing", () {
    testSingleCase(ru.casual, "авг 30 года", new DateTime(2012, 7, 10),
            (ParsedResult result, String text) {
          expect(result.index, 0);
          expect(result.text, "авг 30 года");
          expectToBeDate(result.start, new DateTime(2030, 8, 1, 12));
        });
  });
}

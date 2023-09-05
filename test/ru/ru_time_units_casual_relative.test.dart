import 'package:chrono/locales/ru/index.dart' as ru;
import 'package:chrono/types.dart';
import 'package:flutter_test/flutter_test.dart';

import "../test_util.dart" show expectToBeDate, testSingleCase;

void main() {
  test("Test - Positive time units", () {
    testSingleCase(
        ru.casual, "следующие 2 недели", new DateTime(2016, 10, 1, 12),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2016, 10, 15, 12));
    });
    testSingleCase(ru.casual, "следующие 2 дня", new DateTime(2016, 10, 1, 12),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2016, 10, 3, 12));
    });
    testSingleCase(
        ru.casual, "следующие два года", new DateTime(2016, 10, 1, 12),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2018, 10, 1, 12));
    });
    testSingleCase(ru.casual, "следующие 2 недели 3 дня",
        new DateTime(2016, 10 , 1, 12), (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2016, 10, 18, 12));
    });
    testSingleCase(ru.casual, "через пару минут", new DateTime(2016, 10, 1, 12),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2016, 10, 1, 12, 2));
    });
    testSingleCase(ru.casual, "через полчаса", new DateTime(2016, 10, 1, 12),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2016, 10, 1, 12, 30));
    });
    testSingleCase(ru.casual, "через 2 часа", new DateTime(2016, 10, 1, 12),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2016, 10, 1, 14));
    });
    testSingleCase(ru.casual, "спустя 2 часа", new DateTime(2016, 10, 1, 12),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2016, 10, 1, 14));
    });
    testSingleCase(ru.casual, "через три месяца", new DateTime(2016, 10, 1, 12),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2017, 1, 1, 12));
    });
    testSingleCase(ru.casual, "через неделю", new DateTime(2016, 10, 1, 12),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2016, 10, 8, 12));
    });
    testSingleCase(ru.casual, "через месяц", new DateTime(2016, 10, 1, 12),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2016, 11, 1, 12));
    });
    testSingleCase(
        ru.casual, "через год", new DateTime(2020, 11, 22, 12, 11, 32, 6),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2021, 11, 22, 12, 11, 32, 6));
    });
    testSingleCase(
        ru.casual, "спустя год", new DateTime(2020, 11, 22, 12, 11, 32, 6),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2021, 11, 22, 12, 11, 32, 6));
    });
  });
  test("Test - Negative time units", () {
    testSingleCase(ru.casual, "прошлые 2 недели", new DateTime(2016, 10, 1, 12),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2016, 9, 17, 12));
    });
    testSingleCase(ru.casual, "прошлые два дня", new DateTime(2016, 10, 1, 12),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2016, 9, 29, 12));
    });
  });
  test("Test - Plus '+' sign", () {
    testSingleCase(ru.casual, "+15 минут", new DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2012, 7, 10, 12, 29));
    });
    testSingleCase(ru.casual, "+15мин", new DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2012, 7, 10, 12, 29));
    });
    testSingleCase(
        ru.casual, "+1 день 2 часа", new DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2012, 7, 11, 14, 14));
    });
  });
  test("Test - Minus '-' sign", () {
    testSingleCase(ru.casual, "-3 года", new DateTime(2015, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, text);
      expectToBeDate(result.start, new DateTime(2012, 7, 10, 12, 14));
    });
  });
}

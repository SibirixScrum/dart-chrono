import 'package:chrono/locales/ru/index.dart' as ru;
import "../test_util.dart" show testSingleCase;

void main() {
  test("Test - Positive time units", () {
    testSingleCase(
        ru.casual, "следующие 2 недели", new Date(2016, 10 - 1, 1, 12),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2016, 10 - 1, 15, 12));
    });
    testSingleCase(ru.casual, "следующие 2 дня", new Date(2016, 10 - 1, 1, 12),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2016, 10 - 1, 3, 12));
    });
    testSingleCase(
        ru.casual, "следующие два года", new Date(2016, 10 - 1, 1, 12),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2018, 10 - 1, 1, 12));
    });
    testSingleCase(
        ru.casual, "следующие 2 недели 3 дня", new Date(2016, 10 - 1, 1, 12),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2016, 10 - 1, 18, 12));
    });
    testSingleCase(ru.casual, "через пару минут", new Date(2016, 10 - 1, 1, 12),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2016, 10 - 1, 1, 12, 2));
    });
    testSingleCase(ru.casual, "через полчаса", new Date(2016, 10 - 1, 1, 12),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2016, 10 - 1, 1, 12, 30));
    });
    testSingleCase(ru.casual, "через 2 часа", new Date(2016, 10 - 1, 1, 12),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2016, 10 - 1, 1, 14));
    });
    testSingleCase(ru.casual, "спустя 2 часа", new Date(2016, 10 - 1, 1, 12),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2016, 10 - 1, 1, 14));
    });
    testSingleCase(ru.casual, "через три месяца", new Date(2016, 10 - 1, 1, 12),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2017, 1 - 1, 1, 12));
    });
    testSingleCase(ru.casual, "через неделю", new Date(2016, 10 - 1, 1, 12),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2016, 10 - 1, 8, 12));
    });
    testSingleCase(ru.casual, "через месяц", new Date(2016, 10 - 1, 1, 12),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2016, 11 - 1, 1, 12));
    });
    testSingleCase(
        ru.casual, "через год", new Date(2020, 11 - 1, 22, 12, 11, 32, 6),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2021, 11 - 1, 22, 12, 11, 32, 6));
    });
    testSingleCase(
        ru.casual, "спустя год", new Date(2020, 11 - 1, 22, 12, 11, 32, 6),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2021, 11 - 1, 22, 12, 11, 32, 6));
    });
  });
  test("Test - Negative time units", () {
    testSingleCase(ru.casual, "прошлые 2 недели", new Date(2016, 10 - 1, 1, 12),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2016, 9 - 1, 17, 12));
    });
    testSingleCase(ru.casual, "прошлые два дня", new Date(2016, 10 - 1, 1, 12),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2016, 9 - 1, 29, 12));
    });
  });
  test("Test - Plus '+' sign", () {
    testSingleCase(
        ru.casual, "+15 минут", new Date(2012, 7 - 1, 10, 12, 14),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2012, 7 - 1, 10, 12, 29));
    });
    testSingleCase(
        ru.casual, "+15мин", new Date(2012, 7 - 1, 10, 12, 14),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2012, 7 - 1, 10, 12, 29));
    });
    testSingleCase(
        ru.casual, "+1 день 2 часа", new Date(2012, 7 - 1, 10, 12, 14),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2012, 7 - 1, 11, 14, 14));
    });
  });
  test("Test - Minus '-' sign", () {
    testSingleCase(
        ru.casual, "-3 года", new Date(2015, 7 - 1, 10, 12, 14),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2012, 7 - 1, 10, 12, 14));
    });
  });
}

import 'package:chrono/locales/ru/index.dart' as ru;
import 'package:flutter_test/flutter_test.dart';
import "../test_util.dart" show testSingleCase;

void main() {
  test("Test - Month-Year expression", () {
    testSingleCase(ru.casual, "Сентябрь 2012", (result) {
      expect(result.index).toBe(0);
      expect(result.text).toBe("Сентябрь 2012");
      expect(result.start).toBeDate(new DateTime(2012, 9 - 1, 1, 12));
    });
    testSingleCase(ru.casual, "сен 2012", (result) {
      expect(result.index).toBe(0);
      expect(result.text).toBe("сен 2012");
      expect(result.start).toBeDate(new DateTime(2012, 9 - 1, 1, 12));
    });
    testSingleCase(ru.casual, "сен. 2012", (result) {
      expect(result.index).toBe(0);
      expect(result.text).toBe("сен. 2012");
      expect(result.start).toBeDate(new DateTime(2012, 9 - 1, 1, 12));
    });
    testSingleCase(ru.casual, "сен-2012", (result) {
      expect(result.index).toBe(0);
      expect(result.text).toBe("сен-2012");
      expect(result.start).toBeDate(new DateTime(2012, 9 - 1, 1, 12));
    });
  });
  test("Test - Month-Only expression", () {
    testSingleCase(ru.casual, "в январе", new DateTime(2020, 11 - 1, 22), (result) {
      expect(result.index).toBe(0);
      expect(result.text).toBe("в январе");
      expect(result.start).toBeDate(new DateTime(2021, 1 - 1, 1, 12));
    });
    testSingleCase(ru.casual, "в янв", new DateTime(2020, 11 - 1, 22), (result) {
      expect(result.index).toBe(0);
      expect(result.text).toBe("в янв");
      expect(result.start).toBeDate(new DateTime(2021, 1 - 1, 1, 12));
    });
    testSingleCase(ru.casual, "май", new DateTime(2020, 11 - 1, 22), (result) {
      expect(result.index).toBe(0);
      expect(result.text).toBe("май");
      expect(result.start).toBeDate(new DateTime(2021, 5 - 1, 1, 12));
    });
  });
  test("Test - Month expression in context", () {
    testSingleCase(ru.casual, "Это было в сентябре 2012 перед новым годом",
        (result) {
      expect(result.index).toBe(9);
      expect(result.text).toBe("в сентябре 2012");
      expect(result.start).toBeDate(new DateTime(2012, 9 - 1, 1, 12));
    });
  });
  test("Test - year 90's parsing", () {
    testSingleCase(ru.casual, "авг 96", new DateTime(2012, 7, 10), (result) {
      expect(result.index).toBe(0);
      expect(result.text).toBe("авг 96");
      expect(result.start).toBeDate(new DateTime(1996, 8 - 1, 1, 12));
    });
    testSingleCase(ru.casual, "96 авг 96", new DateTime(2012, 7, 10), (result) {
      expect(result.index).toBe(3);
      expect(result.text).toBe("авг 96");
      expect(result.start).toBeDate(new DateTime(1996, 8 - 1, 1, 12));
    });
  });
}

import 'package:chrono/locales/ru/index.dart' as ru;
import "../test_util.dart" show testSingleCase, testUnexpectedResult;

void main() {
  test("Test - Time expression", () {
    testSingleCase(ru.casual, "20:32:13", new Date(2016, 10 - 1, 1, 8),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2016, 10 - 1, 1, 20, 32, 13));
    });
  });
  test("Test - Time range expression", () {
    testSingleCase(
        ru.casual, "10:00:00 - 21:45:01", new Date(2016, 10 - 1, 1, 8),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2016, 10 - 1, 1, 10));
      expect(result.end).toBeDate(new Date(2016, 10 - 1, 1, 21, 45, 1));
    });
  });
  test("Test - Casual time number expression", () {
    testSingleCase(ru.casual, "в 11 утра", new Date(2016, 10 - 1, 1, 8),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2016, 10 - 1, 1, 11));
    });
    testSingleCase(ru.casual, "в 11 вечера", new Date(2016, 10 - 1, 1, 8),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2016, 10 - 1, 1, 23));
    });
  });
  test("Test - Time range's meridiem handling", () {
    testSingleCase(ru.casual, "с 10 до 11 утра", new Date(2016, 10 - 1, 1, 8),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2016, 10 - 1, 1, 10));
      expect(result.end).toBeDate(new Date(2016, 10 - 1, 1, 11));
    });
    testSingleCase(ru.casual, "с 10 до 11 вечера", new Date(2016, 10 - 1, 1, 8),
        (result, text) {
      expect(result.index).toBe(0);
      expect(result.text).toBe(text);
      expect(result.start).toBeDate(new Date(2016, 10 - 1, 1, 22));
      expect(result.end).toBeDate(new Date(2016, 10 - 1, 1, 23));
    });
  });
  test("Test - Parsing causal positive cases", () {
    testSingleCase(ru.casual, "в 1", (result) {
      expect(result.index).toBe(0);
      expect(result.text).toBe("в 1");
      expect(result.start.get("hour")).toBe(1);
    });
    testSingleCase(ru.casual, "в 12", (result) {
      expect(result.index).toBe(0);
      expect(result.text).toBe("в 12");
      expect(result.start.get("hour")).toBe(12);
    });
    testSingleCase(ru.casual, "в 12.30", (result) {
      expect(result.index).toBe(0);
      expect(result.text).toBe("в 12.30");
      expect(result.start.get("hour")).toBe(12);
      expect(result.start.get("minute")).toBe(30);
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

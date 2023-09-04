import 'package:chrono/locales/ru/index.dart' as ru;
import "../test_util.dart" show testSingleCase, testUnexpectedResult;

void main() {
  test("Test - Single Expression", () {
    testSingleCase(
        ru.casual, "5 дней назад что-то было", new Date(2012, 7 - 1, 10),
        (result) {
      expect(result.index).toBe(0);
      expect(result.text).toBe("5 дней назад");
      expect(result.start).toBeDate(new Date(2012, 7 - 1, 5));
    });
    testSingleCase(
        ru.casual, "5 минут назад что-то было", new Date(2012, 7 - 1, 10),
        (result) {
      expect(result.index).toBe(0);
      expect(result.text).toBe("5 минут назад");
      expect(result.start).toBeDate(new Date(2012, 7 - 1, 9, 23, 55));
    });
    testSingleCase(
        ru.casual, "полчаса назад что-то было", new Date(2012, 7 - 1, 10),
        (result) {
      expect(result.index).toBe(0);
      expect(result.text).toBe("полчаса назад");
      expect(result.start).toBeDate(new Date(2012, 7 - 1, 9, 23, 30));
    });
  });
  test("Test - Nested time ago", () {
    testSingleCase(
        ru.casual, "5 дней 2 часа назад что-то было", new Date(2012, 7 - 1, 10),
        (result) {
      expect(result.index).toBe(0);
      expect(result.text).toBe("5 дней 2 часа назад");
      expect(result.start).toBeDate(new Date(2012, 7 - 1, 4, 22));
    });
    testSingleCase(ru.casual, "5 минут 20 секунд назад что-то было",
        new Date(2012, 7 - 1, 10), (result) {
      expect(result.index).toBe(0);
      expect(result.text).toBe("5 минут 20 секунд назад");
      expect(result.start).toBeDate(new Date(2012, 7 - 1, 9, 23, 54, 40));
    });
    testSingleCase(ru.casual, "2 часа 5 минут назад что-то было",
        new Date(2012, 7 - 1, 10), (result) {
      expect(result.index).toBe(0);
      expect(result.text).toBe("2 часа 5 минут назад");
      expect(result.start).toBeDate(new Date(2012, 7 - 1, 9, 21, 55));
    });
  });
  test("Test - Negative cases", () {
    testUnexpectedResult(ru.casual, "15 часов 29 мин");
    testUnexpectedResult(ru.casual, "несколько часов");
    testUnexpectedResult(ru.casual, "5 дней");
  });
}

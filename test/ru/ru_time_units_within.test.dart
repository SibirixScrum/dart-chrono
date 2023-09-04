import 'package:chrono/locales/ru/index.dart' as ru;
import "../test_util.dart" show testSingleCase;

void main() {
  test("Test - The normal within expression", () {
    testSingleCase(
        ru.casual, "будет сделано в течение минуты", new Date(2012, 7, 10),
        (result) {
      expect(result.index).toBe(14);
      expect(result.text).toBe("в течение минуты");
      expect(result.start).toBeDate(new Date(2012, 7, 10, 0, 1));
    });
    testSingleCase(
        ru.casual, "будет сделано в течение 2 часов.", new Date(2012, 7, 10),
        (result) {
      expect(result.index).toBe(14);
      expect(result.text).toBe("в течение 2 часов");
      expect(result.start).toBeDate(new Date(2012, 7, 10, 2));
    });
  });
}

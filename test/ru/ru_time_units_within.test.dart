import 'package:chrono/locales/ru/index.dart' as ru;
import 'package:flutter_test/flutter_test.dart';
import "../test_util.dart" show testSingleCase;

void main() {
  test("Test - The normal within expression", () {
    testSingleCase(
        ru.casual, "будет сделано в течение минуты", new DateTime(2012, 7, 10),
        (result) {
      expect(result.index,14);
      expect(result.text,"в течение минуты");
      expect(result.start).toBeDate(new DateTime(2012, 7, 10, 0, 1));
    });
    testSingleCase(
        ru.casual, "будет сделано в течение 2 часов.", new DateTime(2012, 7, 10),
        (result) {
      expect(result.index,14);
      expect(result.text,"в течение 2 часов");
      expect(result.start).toBeDate(new DateTime(2012, 7, 10, 2));
    });
  });
}

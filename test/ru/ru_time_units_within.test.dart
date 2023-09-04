import 'package:chrono/locales/ru/index.dart' as ru;
import 'package:chrono/types.dart';
import 'package:flutter_test/flutter_test.dart';
import "../test_util.dart" show expectToBeDate, testSingleCase;

void main() {
  test("Test - The normal within expression", () {
    testSingleCase(
        ru.casual, "будет сделано в течение минуты", new DateTime(2012, 7, 10),
         (ParsedResult result, String text) {
      expect(result.index,14);
      expect(result.text,"в течение минуты");
      expectToBeDate(result.start,new DateTime(2012, 7, 10, 0, 1));
    });
    testSingleCase(
        ru.casual, "будет сделано в течение 2 часов.", new DateTime(2012, 7, 10),
         (ParsedResult result, String text) {
      expect(result.index,14);
      expect(result.text,"в течение 2 часов");
      expectToBeDate(result.start,new DateTime(2012, 7, 10, 2));
    });
  });
}

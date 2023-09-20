import 'package:chrono/locales/ru/index.dart' as ru;
import 'package:chrono/types.dart';
import 'package:flutter_test/flutter_test.dart';

import "../test_util.dart"
    show expectToBeDate, testSingleCase, testUnexpectedResult;

void main() {
  test("Test - slash date range", () {
    testSingleCase(ru.casual, "25 числа", DateTime(2023, 9, 20),
        ParsingOption(forwardDate: true),
            (ParsedResult result, String text) {
          expect(result.index, 0);
          expect(result.text, "25 числа");
          expectToBeDate(result.start, DateTime(2023, 9, 25,12));
        });
    testSingleCase(ru.casual, "25 число", DateTime(2023, 9, 20),
        ParsingOption(forwardDate: true),
            (ParsedResult result, String text) {
          expect(result.index, 0);
          expect(result.text, "25 число");
          expectToBeDate(result.start, DateTime(2023, 9, 25,12));
        });
    testSingleCase(ru.casual, "пойти в магазин 25 числа", DateTime(2023, 9, 20),
        ParsingOption(forwardDate: true),
            (ParsedResult result, String text) {
          expect(result.index, 16);
          expect(result.text, "25 числа");
          expectToBeDate(result.start, DateTime(2023, 9, 25,12));
        });
    testSingleCase(ru.casual, "25 числа", DateTime(2023, 9, 29),
        ParsingOption(forwardDate: true),
            (ParsedResult result, String text) {
          expect(result.index, 0);
          expect(result.text, "25 числа");
          expectToBeDate(result.start, DateTime(2023, 10, 25,12));
        });
    testSingleCase(ru.casual, "25 числа", DateTime(2023, 12, 29),
        ParsingOption(forwardDate: true),
            (ParsedResult result, String text) {
          expect(result.index, 0);
          expect(result.text, "25 числа");
          expectToBeDate(result.start, DateTime(2024, 1, 25,12));
        });



  });
}

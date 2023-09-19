import 'package:chrono/locales/ru/index.dart' as ru;
import 'package:chrono/ported/CustomValues.dart';
import 'package:chrono/types.dart';
import 'package:flutter_test/flutter_test.dart';

import "../test_util.dart"
    show expectToBeDate, testSingleCase, testUnexpectedResult;

void main() {
  test("Test - slash date range", () {
    testSingleCase(ru.casual, "с 27/3 по 24/5", DateTime(2023, 9, 18),
        ParsingOption(forwardDate: true),
        (ParsedResult result, String text) {
      expect(result.index, 2);
      expect(result.text, "27/3 по 24/5");
      expectToBeDate(result.start, DateTime(2024, 3, 27, 12));
      expectToBeDate(result.end!, DateTime(2024, 5, 24, 12));
    });
    testSingleCase(ru.casual, "с 27/3/24 до 24/5/24", DateTime(2023, 9, 18),
        ParsingOption(forwardDate: true),
            (ParsedResult result, String text) {
          expect(result.index, 2);
          expect(result.text, "27/3/24 до 24/5/24");
          expectToBeDate(result.start, DateTime(2024, 3, 27, 12));
          expectToBeDate(result.end!, DateTime(2024, 5, 24, 12));
        });
    testSingleCase(ru.casual, "от 27/3/2024 до 24/5/2024", DateTime(2023, 9, 18),
        ParsingOption(forwardDate: true),
            (ParsedResult result, String text) {
          expect(result.index, 3);
          expect(result.text, "27/3/2024 до 24/5/2024");
          expectToBeDate(result.start, DateTime(2024, 3, 27, 12));
          expectToBeDate(result.end!, DateTime(2024, 5, 24, 12));
        });
    testSingleCase(ru.casual, "пт-пт", DateTime(2023, 9, 19),
        ParsingOption(forwardDate: true),
            (ParsedResult result, String text) {
          expect(result.index, 0);
          expect(result.text, "пт-пт");
          expectToBeDate(result.start, DateTime(2023, 9, 22, 12));
          expectToBeDate(result.end!, DateTime(2023, 9, 29, 12));
        });
    testSingleCase(ru.casual, "пт-пт", DateTime(2023, 9, 28),
        ParsingOption(forwardDate: true),
            (ParsedResult result, String text) {
          expect(result.index, 0);
          expect(result.text, "пт-пт");
          expectToBeDate(result.start, DateTime(2023, 9, 29, 12));
          expectToBeDate(result.end!, DateTime(2023, 10, 6, 12));
        });

  });
}

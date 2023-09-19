import 'package:chrono/locales/ru/index.dart' as ru;
import 'package:chrono/ported/CustomValues.dart';
import 'package:chrono/types.dart';
import 'package:flutter_test/flutter_test.dart';

import "../test_util.dart"
    show expectToBeDate, testSingleCase, testUnexpectedResult;

void main() {
  test("Test - slash date range", () {
    testSingleCase(ru.casual, "с вечера до утра", DateTime(2023, 9, 19,14),
        ParsingOption(forwardDate: true),
            (ParsedResult result, String text) {
          expect(result.index, 2);
          expect(result.text, "вечера до утра");
          expectToBeDate(result.start, DateTime(2023, 9, 19, 18));
          expectToBeDate(result.end!, DateTime(2023, 9, 20, 9));
        });
  });
}
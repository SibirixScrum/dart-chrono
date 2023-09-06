import 'package:chrono/locales/en/index.dart' as en;
import 'package:chrono/types.dart';
import "package:flutter_test/flutter_test.dart";

import '../test_util.dart';

 void main() {
   test("Test - Single Expression", () {
     testSingleCase(
        en.casual, "2 weeks after yesterday", DateTime(2022, 2 - 1, 2),
        (ParsedResult result, String text) {
      expect(result.text, "2 weeks after yesterday");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2022);
      expect(result.start.get(Component.month), 2);
      expect(result.start.get(Component.day), 15);
      expect(result.start.get(Component.weekday), 2);
      expect(result.start.isCertain(Component.day), false);
      expect(result.start.isCertain(Component.month), false);
      expect(result.start.isCertain(Component.year), false);
      expect(result.start.isCertain(Component.weekday), false);
      expectToBeDate(result.start,DateTime(2022, 2 - 1, 15, 0));
    });
     testSingleCase(
        en.casual, "2 months before 02/02", DateTime(2022, 2 - 1, 2),
        (ParsedResult result, String text) {
      expect(result.text, "2 months before 02/02");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2021);
      expect(result.start.get(Component.month), 12);
      expect(result.start.get(Component.day), 2);
      expect(result.start.isCertain(Component.day), false);
      expect(result.start.isCertain(Component.month), true);
      expect(result.start.isCertain(Component.year), true);
      expectToBeDate(result.start,DateTime(2021, 12 - 1, 2, 12));
    });
     testSingleCase(
        en.casual, "2 days after next Friday", DateTime(2022, 2 - 1, 2),
        (ParsedResult result, String text) {
      expect(result.text, "2 days after next Friday");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2022);
      expect(result.start.get(Component.month), 2);
      expect(result.start.get(Component.day), 13);
      expect(result.start.isCertain(Component.day), true);
      expect(result.start.isCertain(Component.month), true);
      expect(result.start.isCertain(Component.year), true);
      expectToBeDate(result.start,DateTime(2022, 2 - 1, 13, 12));
    });
   });
 }
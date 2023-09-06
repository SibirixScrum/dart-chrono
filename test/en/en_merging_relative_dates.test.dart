import 'package:chrono/locales/en/index.dart' as en;
import 'package:chrono/types.dart';
import "package:flutter_test/flutter_test.dart";

import '../test_util.dart';

 void main() {
   test("Test - Single Expression", () {
     testSingleCase(
        en.casual.casual, "2 weeks after yesterday", DateTime(2022, 2 - 1, 2),
        (ParsedResult result, String text) {
      expect(result.text, "2 weeks after yesterday");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2022);
      expect(result.start.get("month"), 2);
      expect(result.start.get("day"), 15);
      expect(result.start.get("weekday"), 2);
      expect(result.start.isCertain("day"), false);
      expect(result.start.isCertain("month"), false);
      expect(result.start.isCertain("year"), false);
      expect(result.start.isCertain("weekday"), false);
      expect(result.start).toBeDate(DateTime(2022, 2 - 1, 15, 0));
    });
     testSingleCase(
        en.casual.casual, "2 months before 02/02", DateTime(2022, 2 - 1, 2),
        (ParsedResult result, String text) {
      expect(result.text, "2 months before 02/02");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2021);
      expect(result.start.get("month"), 12);
      expect(result.start.get("day"), 2);
      expect(result.start.isCertain("day"), false);
      expect(result.start.isCertain("month"), true);
      expect(result.start.isCertain("year"), true);
      expect(result.start).toBeDate(DateTime(2021, 12 - 1, 2, 12));
    });
     testSingleCase(
        en.casual.casual, "2 days after next Friday", DateTime(2022, 2 - 1, 2),
        (ParsedResult result, String text) {
      expect(result.text, "2 days after next Friday");
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2022);
      expect(result.start.get("month"), 2);
      expect(result.start.get("day"), 13);
      expect(result.start.isCertain("day"), true);
      expect(result.start.isCertain("month"), true);
      expect(result.start.isCertain("year"), true);
      expect(result.start).toBeDate(DateTime(2022, 2 - 1, 13, 12));
    });
   });
 }
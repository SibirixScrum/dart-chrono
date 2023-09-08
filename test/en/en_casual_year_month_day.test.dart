import 'package:chrono/locales/en/index.dart' as en;
import 'package:chrono/types.dart';
import "package:flutter_test/flutter_test.dart";

import '../test_util.dart';
 void main() {
   test("Test - Single Expression Start with Year", () {
    testSingleCase(en.casual, "2012/8/10", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expect(result.index, 0);
      expect(result.text, "2012/8/10");
      expectToBeDate(result.start,DateTime(2012, 8 , 10, 12));
    });
    testSingleCase(
        en.casual, "The Deadline is 2012/8/10", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 16);
      expect(result.text, "2012/8/10");
      expectToBeDate(result.start,DateTime(2012, 8, 10, 12));
    });
    testSingleCase(en.strict, "2014/2/28",
        (ParsedResult result, String text) {
      expect(result.text, "2014/2/28");
    });
    testSingleCase(en.strict, "2014/12/28",
        (ParsedResult result, String text) {
      expect(result.text, "2014/12/28");
      expectToBeDate(result.start,DateTime(2014, 12 , 28, 12));
    });
    testSingleCase(en.strict, "2014.12.28",
        (ParsedResult result, String text) {
      expect(result.text, "2014.12.28");
      expectToBeDate(result.start,DateTime(2014, 12 , 28, 12));
    });
    testSingleCase(en.strict, "2014 12 28",
        (ParsedResult result, String text) {
      expect(result.text, "2014 12 28");
      expectToBeDate(result.start,DateTime(2014, 12 , 28, 12));
    });
  });
   test("Test - Single Expression Start with Year and Month Name", () {
    testSingleCase(en.casual, "2012/Aug/10", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expect(result.index, 0);
      expect(result.text, "2012/Aug/10");
      expectToBeDate(result.start,DateTime(2012, 8 , 10, 12));
    });
    testSingleCase(
        en.casual, "The Deadline is 2012/aug/10", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 16);
      expect(result.text, "2012/aug/10");
      expectToBeDate(result.start,DateTime(2012, 8 , 10, 12));
    });
    testSingleCase(
        en.casual, "The Deadline is 2018 March 18", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 16);
      expect(result.text, "2018 March 18");
      expect(result.start.get(Component.year), 2018);
      expect(result.start.get(Component.month), 3);
      expect(result.start.get(Component.day), 18);
      expectToBeDate(result.start,DateTime(2018, 3 , 18, 12));
    });
   });
   test("Test - Negative year-month-day like pattern", () {
    testUnexpectedResult(en.casual, "2012-80-10", DateTime(2012, 7, 10));
    testUnexpectedResult(en.casual, "2012 80 10", DateTime(2012, 7, 10));
  });
 }
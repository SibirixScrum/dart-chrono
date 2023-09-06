
import 'package:chrono/locales/en/index.dart' as en;
import 'package:chrono/types.dart';
import "package:flutter_test/flutter_test.dart";

import '../test_util.dart';

 void main() {
  test("Test - Parsing Offset Expression", () {
    testSingleCase(en.casual, "    04/2016   ", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 4);
      expect(result.text, "04/2016");
    });
  });
  test("Test - Single Expression", () {
   testSingleCase(
        en.casual, "The event is going ahead (04/2016)", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 4);
      expect(result.start.get(Component.day), 1);
      expect(result.index, 26);
      expect(result.text, "04/2016");
      expectToBeDate(result.start,DateTime(2016, 4 - 1, 1, 12));
    });
    testSingleCase(en.casual, "Published: 06/2004", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2004);
      expect(result.start.get(Component.month), 6);
      expect(result.start.get(Component.day), 1);
      expect(result.index, 11);
      expect(result.text, "06/2004");
      expectToBeDate(result.start,DateTime(2004, 6 - 1, 1, 12));
    });
    testSingleCase(en.casual, "8/10/2012", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expect(result.index, 0);
      expect(result.text, "8/10/2012");
      expect(result.start.isCertain(Component.day), true);
      expect(result.start.isCertain(Component.month), true);
      expect(result.start.isCertain(Component.year), true);
      expectToBeDate(result.start,DateTime(2012, 8 - 1, 10, 12));
    });
    testSingleCase(en.casual, ": 8/1/2012", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 1);
      expect(result.index, 2);
      expect(result.text, "8/1/2012");
      expectToBeDate(result.start,DateTime(2012, 8 - 1, 1, 12));
    });
    testSingleCase(en.casual, "8/10", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expect(result.index, 0);
      expect(result.text, "8/10");
      expect(result.start.isCertain(Component.day), true);
      expect(result.start.isCertain(Component.month), true);
      expect(result.start.isCertain(Component.year), false);
      expectToBeDate(result.start,DateTime(2012, 8 - 1, 10, 12));
    });
    testSingleCase(
        en.casual, "The Deadline is 8/10/2012", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 16);
      expect(result.text, "8/10/2012");
      expectToBeDate(result.start,DateTime(2012, 7, 10, 12));
    });
    testSingleCase(
        en.casual, "The Deadline is Tuesday 11/3/2015", DateTime(2015, 10, 3),
        (ParsedResult result, String text) {
      expect(result.index, 16);
      expect(result.text, "Tuesday 11/3/2015");
      expectToBeDate(result.start,DateTime(2015, 10, 3, 12));
    });
    testSingleCase(en.strict, "2/28/2014",
        (ParsedResult result, String text) {
      expect(result.text, "2/28/2014");
    });
    testWithExpectedDate(
        en.strict, "12-30-16", DateTime(2016, 12 - 1, 30, 12));
    testSingleCase(en.strict, "Friday 12-30-16",
        (ParsedResult result, String text) {
      expect(result.text, "Friday 12-30-16");
      expectToBeDate(result.start,DateTime(2016, 12 - 1, 30, 12));
    });
  });
  test("Test - Single Expression Little-Endian", () {
  //   testSingleCase(en.casual.en.GB, "8/10/2012", DateTime(2012, 7, 10),
  //       (ParsedResult result, String text) {
  //     expect(result.start == null, isFalse);
  //     expect(result.start.get(Component.year), 2012);
  //     expect(result.start.get(Component.month), 10);
  //     expect(result.start.get(Component.day), 8);
  //     expect(result.index, 0);
  //     expect(result.text, "8/10/2012");
  //     expectToBeDate(result.start,DateTime(2012, 10 - 1, 8, 12));
  //   });
  //   testWithExpectedDate(
  //       en.strict, "30-12-16", DateTime(2016, 12 - 1, 30, 12));
  //   testSingleCase(en.strict, "Friday 30-12-16",
  //       (ParsedResult result, String text) {
  //     expect(result.text, "Friday 30-12-16");
  //     expectToBeDate(result.start,DateTime(2016, 12 - 1, 30, 12));
  //   });
  // });
  // test("Test - Single Expression Little-Endian with Month name", () {
  //   testSingleCase(en.casual.en.GB, "8/Oct/2012", DateTime(2012, 7, 10),
  //       (ParsedResult result, String text) {
  //     expect(result.start == null, isFalse);
  //     expect(result.start.get(Component.year), 2012);
  //     expect(result.start.get(Component.month), 10);
  //     expect(result.start.get(Component.day), 8);
  //     expect(result.index, 0);
  //     expect(result.text, "8/Oct/2012");
  //     expectToBeDate(result.start,DateTime(2012, 10 - 1, 8, 12));
  //   });
  // });
  test("Test - Range Expression", () {
   testSingleCase(en.casual, "8/10/2012 - 8/15/2012", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "8/10/2012 - 8/15/2012");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expectToBeDate(result.start,DateTime(2012, 8 - 1, 10, 12));
      expect(result.end == null, isFalse);
      expect(result.end!.get(Component.year), 2012);
      expect(result.end!.get(Component.month), 8);
      expect(result.end!.get(Component.day), 15);
      expectToBeDate(result.end!,DateTime(2012, 8 - 1, 15, 12));
    });
  });
  test("Test - Splitter variances patterns", () {
   final expectDate = DateTime(2015, 5 - 1, 25, 12, 0);
    testWithExpectedDate(en.casual, "2015-05-25", expectDate);
    testWithExpectedDate(en.casual, "2015/05/25", expectDate);
    testWithExpectedDate(en.casual, "2015.05.25", expectDate);
    testWithExpectedDate(en.casual, "05-25-2015", expectDate);
    testWithExpectedDate(en.casual, "05/25/2015", expectDate);
    testWithExpectedDate(en.casual, "05.25.2015", expectDate);
    testWithExpectedDate(en.casual, "/05/25/2015", expectDate);
    // Also, guessing ambiguous date
    testWithExpectedDate(en.casual, "25/05/2015", expectDate);
  });
  test("Test - Impossible Dates and Unexpected Results", () {
   testUnexpectedResult(en.casual, "8/32/2014");
   testUnexpectedResult(en.casual, "8/32");
   testUnexpectedResult(en.casual, "2/29/2014");
   testUnexpectedResult(en.casual, "2014/22/29");
   testUnexpectedResult(en.casual, "2014/13/22");
   testUnexpectedResult(en.casual, "80-32-89-89");
   testUnexpectedResult(en.casual, "02/29/2022");
   testUnexpectedResult(en.casual, "06/31/2022");
   testUnexpectedResult(en.casual, "06/-31/2022");
   testUnexpectedResult(en.casual, "18/13/2022");
   testUnexpectedResult(en.casual, "15/28/2022");
  });
  test("Test - forward dates only option", () {
   testSingleCase(
        en.casual, "5/31", DateTime(1999, 6 - 1, 1), {"forwardDate": true},
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2000);
      expect(result.start.get(Component.month), 5);
      expect(result.start.get(Component.day), 31);
      expect(result.index, 0);
      expect(result.text, "5/31");
      expect(result.start.isCertain(Component.day), true);
      expect(result.start.isCertain(Component.month), true);
      expect(result.start.isCertain(Component.year), false);
      expectToBeDate(result.start,DateTime(2000, 5 - 1, 31, 12));
    });
    testSingleCase(en.casual, "1/8 at 12pm", DateTime("Sep 25 2021 12:00:00"),
        {"forwardDate": true}, (ParsedResult result, String text) {
      expect(result.text, "1/8 at 12pm");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2022);
      expect(result.start.get(Component.month), 1);
      expect(result.start.get(Component.day), 8);
      expectToBeDate(result.start,DateTime(2022, 1 - 1, 8, 12));
    });
  });
 }
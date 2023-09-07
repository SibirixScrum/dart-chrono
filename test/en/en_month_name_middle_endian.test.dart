import 'package:chrono/locales/en/index.dart' as en;
import 'package:chrono/types.dart';
import "package:flutter_test/flutter_test.dart";

import '../test_util.dart';
 void main() {
   test("Test - Single Expression", () {
     testSingleCase(en.casual, "She is getting married soon (July 2017).",
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2017);
      expect(result.start.get(Component.month), 7);
      expect(result.start.get(Component.day), 1);
      expect(result.index, 29);
      expect(result.text, "July 2017");
      expectToBeDate(result.start,DateTime(2017, 7 , 1, 12));
    });
     testSingleCase(
        en.casual, "She is leaving in August.", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 1);
      expect(result.index, 18);
      expect(result.text, "August");
      expectToBeDate(result.start,DateTime(2012, 8 , 1, 12));
    });
     testSingleCase(
         en.casual,
        "I am arriving sometime in August, 2012, probably.",
        DateTime(2012, 7, 10), (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 1);
      expect(result.index, 26);
      expect(result.text, "August, 2012");
      expectToBeDate(result.start,DateTime(2012, 8 , 1, 12));
    });
    testSingleCase(en.casual, "August 10, 2012", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expect(result.index, 0);
      expect(result.text, "August 10, 2012");
      expectToBeDate(result.start,DateTime(2012, 8 , 10, 12));
    });
    testSingleCase(en.casual, "Nov 12, 2011", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2011);
      expect(result.start.get(Component.month), 11);
      expect(result.start.get(Component.day), 12);
      expect(result.index, 0);
      expect(result.text, "Nov 12, 2011");
      expectToBeDate(result.start,DateTime(2011, 11 , 12, 12));
    });
    testSingleCase(
        en.casual, "The Deadline is August 10", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expect(result.index, 16);
      expect(result.text, "August 10");
      expectToBeDate(result.start,DateTime(2012, 8 , 10, 12));
    });
     testSingleCase(
        en.casual, "The Deadline is August 10 2555 BE", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 16);
      expect(result.text, "August 10 2555 BE");
      expectToBeDate(result.start,DateTime(2012, 8 , 10, 12));
    });
     testSingleCase(
        en.casual, "The Deadline is August 10, 345 BC", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 16);
      expect(result.text, "August 10, 345 BC");
      expectToBeDate(result.start,DateTime(-345, 8 , 10, 12));
    });
     testSingleCase(
        en.casual, "The Deadline is August 10, 8 AD", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 16);
      expect(result.text, "August 10, 8 AD");
      final expectDate = DateTime(8, 8 , 10, 12);
      // expectDate.setFullYear(8);
      expectToBeDate(result.start,expectDate);
    });
     testSingleCase(
        en.casual, "The Deadline is Tuesday, January 10", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.text, "Tuesday, January 10");
      expect(result.start.get(Component.year), 2013);
      expect(result.start.get(Component.month), 1);
      expect(result.start.get(Component.day), 10);
      expect(result.start.get(Component.weekday), 2);
      expectToBeDate(result.start,DateTime(2013, 1 , 10, 12));
    });
     testSingleCase(en.casual, "Sun, Mar. 6, 2016", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 3);
      expect(result.start.get(Component.day), 6);
    });
     testSingleCase(en.casual, "Sun, March 6, 2016", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 3);
      expect(result.start.get(Component.day), 6);
    });
     testSingleCase(en.casual, "Sun., March 6, 2016", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 3);
      expect(result.start.get(Component.day), 6);
    });
     testSingleCase(en.casual, "Sunday, March 6, 2016", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 3);
      expect(result.start.get(Component.day), 6);
    });
     testSingleCase(en.casual, "Sunday, March 6, 2016", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 3);
      expect(result.start.get(Component.day), 6);
    });
     testSingleCase(en.casual, "Sunday, March, 6th 2016", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.text, "Sunday, March, 6th 2016");
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 3);
      expect(result.start.get(Component.day), 6);
    });
     testSingleCase(
        en.casual, "Wed, Jan 20th, 2016             ", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.text, "Wed, Jan 20th, 2016");
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 1);
      expect(result.start.get(Component.day), 20);
    });
   });
   test("Test - Single expression with separators", () {
     testWithExpectedDate(
        en.casual, "August-10, 2012", DateTime(2012, 8 , 10, 12, 0));
    testWithExpectedDate(
        en.casual, "August/10, 2012", DateTime(2012, 8 , 10, 12, 0));
    testWithExpectedDate(
        en.casual, "August/10/2012", DateTime(2012, 8 , 10, 12, 0));
    testWithExpectedDate(
        en.casual, "August-10-2012", DateTime(2012, 8 , 10, 12, 0));
  });
   test("Test - Range expression", () {
     testSingleCase(en.casual, "August 10 - 22, 2012", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "August 10 - 22, 2012");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expectToBeDate(result.start,DateTime(2012, 8 , 10, 12));
      expect(result.end == null, isFalse);
      expect(result.end!.get(Component.year), 2012);
      expect(result.end!.get(Component.month), 8);
      expect(result.end!.get(Component.day), 22);
      expectToBeDate(result.end!,DateTime(2012, 8 , 22, 12));
    });
     testSingleCase(en.casual, "August 10 to 22, 2012", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "August 10 to 22, 2012");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expectToBeDate(result.start,DateTime(2012, 8 , 10, 12));
      expect(result.end == null, isFalse);
      expect(result.end!.get(Component.year), 2012);
      expect(result.end!.get(Component.month), 8);
      expect(result.end!.get(Component.day), 22);
      expectToBeDate(result.end!,DateTime(2012, 8 , 22, 12));
    });
     testSingleCase(en.casual, "August 10 - November 12", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "August 10 - November 12");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expectToBeDate(result.start,DateTime(2012, 8 , 10, 12));
      expect(result.end == null, isFalse);
      expect(result.end!.get(Component.year), 2012);
      expect(result.end!.get(Component.month), 11);
      expect(result.end!.get(Component.day), 12);
      expectToBeDate(result.end!,DateTime(2012, 11 , 12, 12));
    });
     testSingleCase(en.casual, "Aug 10 to Nov 12", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "Aug 10 to Nov 12");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expectToBeDate(result.start,DateTime(2012, 8 , 10, 12));
      expect(result.end == null, isFalse);
      expect(result.end!.get(Component.year), 2012);
      expect(result.end!.get(Component.month), 11);
      expect(result.end!.get(Component.day), 12);
      expectToBeDate(result.end!,DateTime(2012, 11 , 12, 12));
    });
     testSingleCase(en.casual, "Aug 10 - Nov 12, 2013", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "Aug 10 - Nov 12, 2013");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2013);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expectToBeDate(result.start,DateTime(2013, 8 , 10, 12));
      expect(result.end == null, isFalse);
      expect(result.end!.get(Component.year), 2013);
      expect(result.end!.get(Component.month), 11);
      expect(result.end!.get(Component.day), 12);
      expectToBeDate(result.end!,DateTime(2013, 11 , 12, 12));
    });
     testSingleCase(en.casual, "Aug 10 - Nov 12, 2011", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "Aug 10 - Nov 12, 2011");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2011);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expectToBeDate(result.start,DateTime(2011, 8 , 10, 12));
      expect(result.end == null, isFalse);
      expect(result.end!.get(Component.year), 2011);
      expect(result.end!.get(Component.month), 11);
      expect(result.end!.get(Component.day), 12);
      expectToBeDate(result.end!,DateTime(2011, 11 , 12, 12));
    });
   });
   test("Test - Ordinal Words", () {
     testSingleCase(en.casual, "May eighth, 2010", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "May eighth, 2010");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2010);
      expect(result.start.get(Component.month), 5);
      expect(result.start.get(Component.day), 8);
    });
     testSingleCase(en.casual, "May twenty-fourth", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "May twenty-fourth");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 5);
      expect(result.start.get(Component.day), 24);
    });
     testSingleCase(en.casual, "May eighth - tenth, 2010", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "May eighth - tenth, 2010");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2010);
      expect(result.start.get(Component.month), 5);
      expect(result.start.get(Component.day), 8);
      expect(result.end == null, isFalse);
      expect(result.end!.get(Component.year), 2010);
      expect(result.end!.get(Component.month), 5);
      expect(result.end!.get(Component.day), 10);
    });
   });
   test("Test - Forward Option", () {
     testSingleCase(en.casual, "January 1st", DateTime(2016, 2 , 15),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 1);
      expect(result.start.get(Component.day), 1);
    });
    testSingleCase(en.casual, "January 1st", DateTime(2016, 2 , 15),
        {"forwardDate": true}, (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2017);
      expect(result.start.get(Component.month), 1);
      expect(result.start.get(Component.day), 1);
    });
  });
   test("Test - year 90's parsing", () {
    testSingleCase(en.casual, "Aug 9, 96", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.text, "Aug 9, 96");
      expect(result.start.get(Component.year), 1996);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 9);
    });
    testSingleCase(en.casual, "Aug 9 96", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.text, "Aug 9 96");
      expect(result.start.get(Component.year), 1996);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 9);
    });
  });
   test("Test - Impossible Dates (Strict Mode)", () {
     testUnexpectedResult(en.strict, "August 32, 2014");
    testUnexpectedResult(en.strict, "February 29, 2014");
    testUnexpectedResult(en.strict, "August 32", DateTime(2012, 7, 10));
    testUnexpectedResult(
        en.strict, "February 29", DateTime(2014, 7, 10));
  });
 }
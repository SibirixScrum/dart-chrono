import 'package:chrono/locales/en/index.dart' as en;
import 'package:chrono/types.dart';
import "package:flutter_test/flutter_test.dart";

import '../test_util.dart';

 void main() {
   test("Test - Single expression", () {
    testSingleCase(en.casual, "10 August 2012", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expect(result.index, 0);
      expect(result.text, "10 August 2012");
      expectToBeDate(result.start,DateTime(2012, 8 , 10, 12));
    });
    testSingleCase(en.casual, "3rd Feb 82", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 1982);
      expect(result.start.get(Component.month), 2);
      expect(result.start.get(Component.day), 3);
      expect(result.index, 0);
      expect(result.text, "3rd Feb 82");
      expectToBeDate(result.start,DateTime(1982, 2 , 3, 12));
    });
    testSingleCase(en.casual, "Sun 15Sep", DateTime(2013, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "Sun 15Sep");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2013);
      expect(result.start.get(Component.month), 9);
      expect(result.start.get(Component.day), 15);
      expectToBeDate(result.start,DateTime(2013, 9 , 15, 12));
    });
    testSingleCase(en.casual, "SUN 15SEP", DateTime(2013, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "SUN 15SEP");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2013);
      expect(result.start.get(Component.month), 9);
      expect(result.start.get(Component.day), 15);
      expectToBeDate(result.start,DateTime(2013, 9 , 15, 12));
    });
    testSingleCase(
        en.casual, "The Deadline is 10 August", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 16);
      expect(result.text, "10 August");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expectToBeDate(result.start,DateTime(2012, 8 , 10, 12));
    });
     testSingleCase(
        en.casual, "The Deadline is Tuesday, 10 January", DateTime(2012, 8, 10),
        (ParsedResult result, String text) {
      expect(result.index, 16);
      expect(result.text, "Tuesday, 10 January");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2013);
      expect(result.start.get(Component.month), 1);
      expect(result.start.get(Component.day), 10);
      expect(result.start.get(Component.weekday), 2);
      expectToBeDate(result.start,DateTime(2013, 1 , 10, 12));
    });
     testSingleCase(
        en.casual, "The Deadline is Tue, 10 January", DateTime(2012, 8, 10),
        (ParsedResult result, String text) {
      expect(result.index, 16);
      expect(result.text, "Tue, 10 January");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2013);
      expect(result.start.get(Component.month), 1);
      expect(result.start.get(Component.day), 10);
      expect(result.start.get(Component.weekday), 2);
      expectToBeDate(result.start,DateTime(2013, 1 , 10, 12));
    });
     testSingleCase(en.casual, "31st March, 2016", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "31st March, 2016");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 3);
      expect(result.start.get(Component.day), 31);
      expectToBeDate(result.start,DateTime(2016, 3 , 31, 12));
    });
     testSingleCase(en.casual, "23rd february, 2016", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "23rd february, 2016");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 2);
      expect(result.start.get(Component.day), 23);
      expectToBeDate(result.start,DateTime(2016, 2 , 23, 12));
    });
   });
   test("Test - Single expression with separators", () {
     testSingleCase(en.casual, "10-August 2012", DateTime(2012, 7, 8),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expectToBeDate(result.start,DateTime(2012, 8 , 10, 12, 0));
    });
     testSingleCase(en.casual, "10-August-2012", DateTime(2012, 7, 8),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expectToBeDate(result.start,DateTime(2012, 8 , 10, 12, 0));
    });
     testSingleCase(en.casual, "10/August 2012", DateTime(2012, 7, 8),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expectToBeDate(result.start,DateTime(2012, 8 , 10, 12, 0));
    });
     testSingleCase(en.casual, "10/August/2012", DateTime(2012, 7, 8),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expectToBeDate(result.start,DateTime(2012, 8 , 10, 12, 0));
    });
   });
   test("Test - Range expression", () {
     testSingleCase(en.casual, "10 - 22 August 2012", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "10 - 22 August 2012");
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
     testSingleCase(en.casual, "10 to 22 August 2012", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "10 to 22 August 2012");
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
     testSingleCase(en.casual, "10 August - 12 September", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "10 August - 12 September");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expectToBeDate(result.start,DateTime(2012, 8 , 10, 12));
      expect(result.end == null, isFalse);
      expect(result.end!.get(Component.year), 2012);
      expect(result.end!.get(Component.month), 9);
      expect(result.end!.get(Component.day), 12);
      expectToBeDate(result.end!,DateTime(2012, 9 , 12, 12));
    });
     testSingleCase(
        en.casual, "10 August - 12 September 2013", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "10 August - 12 September 2013");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2013);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expectToBeDate(result.start,DateTime(2013, 8 , 10, 12));
      expect(result.end == null, isFalse);
      expect(result.end!.get(Component.year), 2013);
      expect(result.end!.get(Component.month), 9);
      expect(result.end!.get(Component.day), 12);
      expectToBeDate(result.end!,DateTime(2013, 9 , 12, 12));
    });
     testSingleCase(
        en.casual, " 17 August 2013 to 19 August 2013", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.text, "17 August 2013 to 19 August 2013");
      expect(result.start.get(Component.year), 2013);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 17);
      expect(result.end!.get(Component.year), 2013);
      expect(result.end!.get(Component.month), 8);
      expect(result.end!.get(Component.day), 19);
    });
   });
   test("Test - Combined expression", () {
     testSingleCase(en.casual, "12th of July at 19:00", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "12th of July at 19:00");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 7);
      expect(result.start.get(Component.day), 12);
      expectToBeDate(result.start,DateTime(2012, 7 , 12, 19, 0));
    });
    testSingleCase(en.casual, "5 May 12:00", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "5 May 12:00");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 5);
      expect(result.start.get(Component.day), 5);
      expectToBeDate(result.start,DateTime(2012, 5 , 5, 12, 0));
    });
    testSingleCase(en.casual, "7 May 11:00", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "7 May 11:00");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 5);
      expect(result.start.get(Component.day), 7);
      expect(result.start.get(Component.hour), 11);
      expectToBeDate(result.start,DateTime(2012, 5 , 7, 11, 0));
    });
  });
   test("Test - Ordinal Words", () {
     testSingleCase(en.casual, "Twenty-fourth of May", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.text, "Twenty-fourth of May");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 5);
      expect(result.start.get(Component.day), 24);
    });
     testSingleCase(
        en.casual, "Eighth to eleventh May 2010", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.text, "Eighth to eleventh May 2010");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2010);
      expect(result.start.get(Component.month), 5);
      expect(result.start.get(Component.day), 8);
      expect(result.end == null, isFalse);
      expect(result.end!.get(Component.year), 2010);
      expect(result.end!.get(Component.month), 5);
      expect(result.end!.get(Component.day), 11);
    });
   });
   test("Test - little endian date followed by time", () {
     testSingleCase(
        en.casual, "24th October, 9 am", DateTime(2017, 7 , 7, 15),
        (ParsedResult result, String text) {
      expect(result.text, "24th October, 9 am");
      expect(result.start.get(Component.day), 24);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.hour), 9);
    });
     testSingleCase(
        en.casual, "24th October, 9 pm", DateTime(2017, 7 , 7, 15),
        (ParsedResult result, String text) {
      expect(result.text, "24th October, 9 pm");
      expect(result.start.get(Component.day), 24);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.hour), 21);
    });
     testSingleCase(en.casual, "24 October, 9 pm", DateTime(2017, 7 , 7, 15),
        (ParsedResult result, String text) {
      expect(result.text, "24 October, 9 pm");
      expect(result.start.get(Component.day), 24);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.hour), 21);
    });
     testSingleCase(
        en.casual, "24 October, 9 p.m.", DateTime(2017, 7 , 7, 15),
        (ParsedResult result, String text) {
      expect(result.text, "24 October, 9 p.m.");
      expect(result.start.get(Component.day), 24);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.hour), 21);
    });
     testSingleCase(
        en.casual, "24 October 10 o clock", DateTime(2017, 7 , 7, 15),
        (ParsedResult result, String text) {
      expect(result.text, "24 October 10 o clock");
      expect(result.start.get(Component.day), 24);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.hour), 10);
    });
   });
   test("Test - year 90's parsing", () {
    testSingleCase(en.casual, "03 Aug 96", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.text, "03 Aug 96");
      expect(result.start.get(Component.year), 1996);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 3);
    });
    testSingleCase(en.casual, "3 Aug 96", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.text, "3 Aug 96");
      expect(result.start.get(Component.year), 1996);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 3);
    });
    testSingleCase(en.casual, "9 Aug 96", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.text, "9 Aug 96");
      expect(result.start.get(Component.year), 1996);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 9);
    });
  });
   test("Test - Forward Option", () {
     testSingleCase(
        en.casual, "22-23 Feb at 7pm", DateTime(2016, 3 , 15),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 2);
      expect(result.start.get(Component.day), 22);
      expect(result.start.get(Component.hour), 19);
      expect(result.end!.get(Component.year), 2016);
      expect(result.end!.get(Component.month), 2);
      expect(result.end!.get(Component.day), 23);
      expect(result.end!.get(Component.hour), 19);
    });
     testSingleCase(
        en.casual,
        "22-23 Feb at 7pm",
        DateTime(2016, 3 , 15),
         ParsingOption(forwardDate:true), (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2017);
      expect(result.start.get(Component.month), 2);
      expect(result.start.get(Component.day), 22);
      expect(result.start.get(Component.hour), 19);
      expect(result.end!.get(Component.year), 2017);
      expect(result.end!.get(Component.month), 2);
      expect(result.end!.get(Component.day), 23);
      expect(result.end!.get(Component.hour), 19);
    });
    testSingleCase(en.casual, "17 August 2013 - 19 August 2013",
        (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2013);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 17);
      expect(result.end!.get(Component.year), 2013);
      expect(result.end!.get(Component.month), 8);
      expect(result.end!.get(Component.day), 19);
    });
  });
   test("Test - Impossible Dates (Strict Mode)", () {
     testUnexpectedResult(
        en.strict, "32 August 2014", DateTime(2012, 7, 10));
    testUnexpectedResult(
        en.strict, "29 February 2014", DateTime(2012, 7, 10));
    testUnexpectedResult(en.strict, "32 August", DateTime(2012, 7, 10));
    testUnexpectedResult(
        en.strict, "29 February", DateTime(2013, 7, 10));
  });
 }
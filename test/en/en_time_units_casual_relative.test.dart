import 'package:chrono/locales/en/index.dart' as en;
import 'package:chrono/locales/en/parsers/ENTimeUnitCasualRelativeFormatParser.dart';
import 'package:chrono/types.dart';
import "package:flutter_test/flutter_test.dart";

import '../test_util.dart';


 void main() {
   test("Test - Positive time units", () {
     testSingleCase(en.casual, "next 2 weeks", DateTime(2016, 10 , 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.day), 15);
    });
     testSingleCase(en.casual, "next 2 days", DateTime(2016, 10 , 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.day), 3);
      expect(result.start.get(Component.hour), 12);
    });
     testSingleCase(en.casual, "next two years", DateTime(2016, 10 , 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2018);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.day), 1);
      expect(result.start.get(Component.hour), 12);
    });
     testSingleCase(
        en.casual, "next 2 weeks 3 days", DateTime(2016, 10 , 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.day), 18);
      expect(result.start.get(Component.hour), 12);
    });
     testSingleCase(en.casual, "after a year", DateTime(2016, 10 , 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2017);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.day), 1);
      expect(result.start.get(Component.hour), 12);
    });
     testSingleCase(en.casual, "after an hour", DateTime(2016, 10 , 1, 15),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.day), 1);
      expect(result.start.get(Component.hour), 16);
    });
   });
   test("Test - Negative time units", () {
     testSingleCase(en.casual, "last 2 weeks", DateTime(2016, 10 , 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 9);
      expect(result.start.get(Component.day), 17);
      expect(result.start.get(Component.hour), 12);
    });
     testSingleCase(en.casual, "last two weeks", DateTime(2016, 10 , 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 9);
      expect(result.start.get(Component.day), 17);
      expect(result.start.get(Component.hour), 12);
    });
     testSingleCase(en.casual, "past 2 days", DateTime(2016, 10 , 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 9);
      expect(result.start.get(Component.day), 29);
      expect(result.start.get(Component.hour), 12);
    });
     testSingleCase(
        en.casual, "+2 months, 5 days", DateTime(2016, 10 , 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 12);
      expect(result.start.get(Component.day), 6);
      expect(result.start.get(Component.hour), 12);
    });
   });
   test("Test - Plus '+' sign", () {
     testSingleCase(
         en.casual, "+15 minutes", DateTime(2012, 7 , 10, 12, 14),
        (result, text) {
      expect(result.text, text);
      expect(result.start.get(Component.hour), 12);
      expect(result.start.get(Component.minute), 29);
      expectToBeDate(result.start,DateTime(2012, 7 , 10, 12, 29));
    });
     testSingleCase(
        en.casual, "+15min", DateTime(2012, 7 , 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.hour), 12);
      expect(result.start.get(Component.minute), 29);
      expectToBeDate(result.start,DateTime(2012, 7 , 10, 12, 29));
    });
     testSingleCase(
         en.casual, "+1 day 2 hour", DateTime(2012, 7 , 10, 12, 14),
        (result, text) {
      expect(result.text, text);
      expect(result.start.get(Component.day), 11);
      expect(result.start.get(Component.hour), 14);
      expect(result.start.get(Component.minute), 14);
      expectToBeDate(result.start,DateTime(2012, 7 , 11, 14, 14));
    });
     testSingleCase(en.casual, "+1m", DateTime(2012, 7 , 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.hour), 12);
      expect(result.start.get(Component.minute), 15);
      expectToBeDate(result.start,DateTime(2012, 7 , 10, 12, 15));
    });
   });
   test("Test - Minus '-' sign", () {
     testSingleCase(en.casual, "-3y", DateTime(2015, 7 , 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 7);
      expect(result.start.get(Component.day), 10);
      expect(result.start.get(Component.hour), 12);
      expect(result.start.get(Component.minute), 14);
      expectToBeDate(result.start,DateTime(2012, 7 , 10, 12, 14));
    });
     testSingleCase(en.casual, "-2hr5min", DateTime(2016, 10 , 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.day), 1);
      expect(result.start.get(Component.hour), 9);
      expect(result.start.get(Component.minute), 55);
    });
   });
   test("Test - Without custom parser without abbreviations", () {
     final custom = en.strict.clone();
     custom.parsers.add(new ENTimeUnitCasualRelativeFormatParser (false));
     testUnexpectedResult(custom, "-3y");
     testUnexpectedResult(custom, "last 2m");
     testSingleCase(custom, "-2 hours 5 minutes", DateTime(2016, 10 , 1, 12),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.day), 1);
      expect(result.start.get(Component.hour), 9);
      expect(result.start.get(Component.minute), 55);
    });
   });
   test("Test - Negative cases", () {
     testUnexpectedResult(
        en.casual, "3y", DateTime(2015, 7 , 10, 12, 14));
    testUnexpectedResult(
        en.casual, "1 m", DateTime(2015, 7 , 10, 12, 14));
    testUnexpectedResult(
        en.casual, "the day", DateTime(2015, 7 , 10, 12, 14));
    testUnexpectedResult(
        en.casual, "a day", DateTime(2015, 7 , 10, 12, 14));
  });
 }
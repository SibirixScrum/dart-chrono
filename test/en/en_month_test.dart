
import 'package:chrono/locales/en/index.dart' as en;
import 'package:chrono/types.dart';
import "package:flutter_test/flutter_test.dart";

import '../test_util.dart';

 void main() {
   test("Test - Month-Year expression", () {
    testSingleCase(en.casual, "September 2012",
        (ParsedResult result, String text) {
      expect(result.text, "September 2012");
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 9);
      expect(result.start.get(Component.day), 1);
      expect(result.start.isCertain(Component.year), true);
      expect(result.start.isCertain(Component.month), true);
      expect(result.start.isCertain(Component.day), false);
      expectToBeDate(result.start,DateTime(2012, 9 , 1, 12));
    });
    testSingleCase(en.casual, "Sept 2012", (ParsedResult result, String text) {
      expect(result.text, "Sept 2012");
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 9);
      expect(result.start.get(Component.day), 1);
      expect(result.start.isCertain(Component.year), true);
      expect(result.start.isCertain(Component.month), true);
      expect(result.start.isCertain(Component.day), false);
      expectToBeDate(result.start,DateTime(2012, 9 , 1, 12));
    });
    testSingleCase(en.casual, "Sep 2012", (ParsedResult result, String text) {
      expect(result.text, "Sep 2012");
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 9);
      expect(result.start.get(Component.day), 1);
      expect(result.start.isCertain(Component.year), true);
      expect(result.start.isCertain(Component.month), true);
      expect(result.start.isCertain(Component.day), false);
      expectToBeDate(result.start,DateTime(2012, 9 , 1, 12));
    });
    testSingleCase(en.casual, "Sep. 2012", (ParsedResult result, String text) {
      expect(result.text, "Sep. 2012");
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 9);
      expect(result.start.get(Component.day), 1);
      expect(result.start.isCertain(Component.year), true);
      expect(result.start.isCertain(Component.month), true);
      expect(result.start.isCertain(Component.day), false);
      expectToBeDate(result.start,DateTime(2012, 9 , 1, 12));
    });
    testSingleCase(en.casual, "Sep-2012", (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 9);
      expect(result.index, 0);
      expect(result.text, "Sep-2012");
      expectToBeDate(result.start,DateTime(2012, 9 , 1, 12));
    });
  });
   test("Test - Month-Only expression", () {
     testSingleCase(
         en.casual, "In January", DateTime(2020, 11 , 22),
        (ParsedResult result, String text) {
      expect(result.text.contains("January"),true);
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2021);
      expect(result.start.get(Component.month), 1);
      expect(result.start.get(Component.day), 1);
      expect(result.start.isCertain(Component.year), false);
      expect(result.start.isCertain(Component.month), true);
      expect(result.start.isCertain(Component.day), false);
      expectToBeDate(result.start,DateTime(2021, 1 , 1, 12));
    });
     testSingleCase(en.casual, "in Jan", DateTime(2020, 11 , 22),
        (ParsedResult result, String text) {
      expect(result.text.contains("Jan"),true);
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2021);
      expect(result.start.get(Component.month), 1);
      expect(result.start.get(Component.day), 1);
      expect(result.start.isCertain(Component.year), false);
      expect(result.start.isCertain(Component.month), true);
      expect(result.start.isCertain(Component.day), false);
      expectToBeDate(result.start,DateTime(2021, 1 , 1, 12));
    });
     testSingleCase(en.casual, "May", DateTime(2020, 11 , 22),
        (ParsedResult result, String text) {
      expect(result.text.contains("May"),true);
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2021);
      expect(result.start.get(Component.month), 5);
      expect(result.start.get(Component.day), 1);
      expect(result.start.isCertain(Component.year), false);
      expect(result.start.isCertain(Component.month), true);
      expect(result.start.isCertain(Component.day), false);
      expectToBeDate(result.start,DateTime(2021, 5 , 1, 12));
    });
   });
   test("Test - Month-Only Range expression", () {
     testSingleCase(en.casual, "From May to December", DateTime(2023, 4 , 9),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2023);
      expect(result.start.get(Component.month), 5);
      expect(result.end!.get(Component.year), 2023);
      expect(result.end!.get(Component.month), 12);
    });
     testSingleCase(en.casual, "From December to May", DateTime(2023, 4 , 9),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2022);
      expect(result.start.get(Component.month), 12);
      expect(result.end!.get(Component.year), 2023);
      expect(result.end!.get(Component.month), 5);
    });
     testSingleCase(
        en.casual, "From May to December, 2022", DateTime(2023, 4 , 9),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2022);
      expect(result.start.get(Component.month), 5);
      expect(result.end!.get(Component.year), 2022);
      expect(result.end!.get(Component.month), 12);
    });
     testSingleCase(
        en.casual, "From December to May 2022", DateTime(2023, 4 , 9),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2021);
      expect(result.start.get(Component.month), 12);
      expect(result.end!.get(Component.year), 2022);
      expect(result.end!.get(Component.month), 5);
    });
     testSingleCase(
        en.casual, "From December to May 2020", DateTime(2023, 4 , 9),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2019);
      expect(result.start.get(Component.month), 12);
      expect(result.end!.get(Component.year), 2020);
      expect(result.end!.get(Component.month), 5);
    });
     testSingleCase(
        en.casual, "From December to May 2025", DateTime(2023, 4 , 9),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2024);
      expect(result.start.get(Component.month), 12);
      expect(result.end!.get(Component.year), 2025);
      expect(result.end!.get(Component.month), 5);
    });
   });
   test("Test - Month with farward date option", () {
    testSingleCase(en.casual, "in December", DateTime(2023, 4 , 9),
        ParsingOption(forwardDate:true), (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2023);
      expect(result.start.get(Component.month), 12);
    });
    testSingleCase(
        en.casual, "in May", DateTime(2023, 4 , 9), ParsingOption(forwardDate:true),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2023);
      expect(result.start.get(Component.month), 5);
    });
    testSingleCase(en.casual, "From May to December", DateTime(2023, 4 , 9),
        ParsingOption(forwardDate:true), (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2023);
      expect(result.start.get(Component.month), 5);
      expect(result.end!.get(Component.year), 2023);
      expect(result.end!.get(Component.month), 12);
    });
    testSingleCase(en.casual, "From December to May", DateTime(2023, 4 , 9),
        ParsingOption(forwardDate:true), (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2023);
      expect(result.start.get(Component.month), 12);
      expect(result.end!.get(Component.year), 2024);
      expect(result.end!.get(Component.month), 5);
    });
  });
   test("Test - Month expression in context", () {
    testSingleCase(en.casual, "The date is Sep 2012 is the date",
        (ParsedResult result, String text) {
      expect(result.index, 12);
      expect(result.text, "Sep 2012");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 9);
      expectToBeDate(result.start,DateTime(2012, 9 , 1, 12));
    });
    testSingleCase(en.casual, "By Angie Mar November 2019",
        (ParsedResult result, String text) {
      expect(result.text, "November 2019");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2019);
      expect(result.start.get(Component.month), 11);
      expectToBeDate(result.start,DateTime(2019, 11 , 1, 12));
    });
  });
   test("Test - Month slash expression", () {
    testSingleCase(en.casual, "9/2012", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 9);
      expect(result.index, 0);
      expect(result.text, "9/2012");
      expectToBeDate(result.start,DateTime(2012, 9 , 1, 12));
    });
    testSingleCase(en.casual, "09/2012", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 9);
      expect(result.index, 0);
      expect(result.text, "09/2012");
      expectToBeDate(result.start,DateTime(2012, 9 , 1, 12));
    });
  });
   test("Test - year 90's parsing", () {
    testSingleCase(en.casual, "Aug 96", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.text, "Aug 96");
      expect(result.start.get(Component.year), 1996);
      expect(result.start.get(Component.month), 8);
    });
    testSingleCase(en.casual, "96 Aug 96", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.text, "Aug 96");
      expect(result.start.get(Component.year), 1996);
      expect(result.start.get(Component.month), 8);
    });
  });
   test("Test - Month should not have timezone", () {
     testSingleCase(
        en.casual,
        "People visiting Buñol towards the end of August get a good chance to participate in La Tomatina (under normal circumstances)",
        DateTime(2012, 7, 10), (ParsedResult result, String text) {
      expect(result.text, "August");
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
    });
   });
 }
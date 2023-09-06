import 'package:chrono/locales/en/index.dart' as en;
import 'package:chrono/types.dart';
import "package:flutter_test/flutter_test.dart";

import '../test_util.dart';

 void main() {
   test("Test - The normal within expression", () {
     testSingleCase(en.casual, "we have to make something in 5 days.",
        DateTime(2012, 7, 10), (ParsedResult result, String text) {
      expect(result.index, 26);
      expect(result.text, "in 5 days");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 15);
      expectToBeDate(result.start , DateTime(2012, 8 - 1, 15));
    });
     testSingleCase(en.casual, "we have to make something in five days.",
        DateTime(2012, 7, 10), (ParsedResult result, String text) {
      expect(result.index, 26);
      expect(result.text, "in five days");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 15);
      expectToBeDate(result.start , DateTime(2012, 8 - 1, 15));
    });
     testSingleCase(en.casual, "we have to make something within 10 day",
        DateTime(2012, 7, 10), (ParsedResult result, String text) {
      expect(result.index, 26);
      expect(result.text, "within 10 day");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 20);
      expectToBeDate(result.start , DateTime(2012, 8 - 1, 20));
    });
     testSingleCase(en.casual, "in 5 minutes", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "in 5 minutes");
      expectToBeDate(result.start , DateTime(2012, 7, 10, 12, 19));
    });
     testSingleCase(
        en.casual, "wait for 5 minutes", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 5);
      expect(result.text, "for 5 minutes");
      expectToBeDate(result.start , DateTime(2012, 7, 10, 12, 19));
    });
     testSingleCase(en.casual, "within 1 hour", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "within 1 hour");
      expectToBeDate(result.start , DateTime(2012, 7, 10, 13, 14));
    });
     testSingleCase(
        en.casual, "In 5 minutes I will go home", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "In 5 minutes");
      expectToBeDate(result.start , DateTime(2012, 7, 10, 12, 19));
    });
     testSingleCase(en.casual, "In 5 minutes A car need to move",
        DateTime(2012, 7, 10, 12, 14), (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "In 5 minutes");
      expectToBeDate(result.start , DateTime(2012, 7, 10, 12, 19));
    });
     testSingleCase(en.casual, "In 5 seconds A car need to move",
        DateTime(2012, 7, 10, 12, 14), (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "In 5 seconds");
      expectToBeDate(result.start , DateTime(2012, 7, 10, 12, 14, 5));
    });
     testSingleCase(
        en.casual, "within half an hour", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "within half an hour");
      expectToBeDate(result.start , DateTime(2012, 7, 10, 12, 44));
    });
     testSingleCase(en.casual, "within two weeks", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "within two weeks");
      expectToBeDate(result.start , DateTime(2012, 7, 24, 12, 14));
    });
     testSingleCase(en.casual, "within a month", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "within a month");
      expectToBeDate(result.start , DateTime(2012, 8, 10, 12, 14));
    });
     testSingleCase(
        en.casual, "within a few months", DateTime(2012, 6, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "within a few months");
      expectToBeDate(result.start , DateTime(2012, 9, 10, 12, 14));
    });
     testSingleCase(en.casual, "within one year", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "within one year");
      expectToBeDate(result.start , DateTime(2013, 7, 10, 12, 14));
    });
     testSingleCase(en.casual, "within one Year", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "within one Year");
      expectToBeDate(result.start , DateTime(2013, 7, 10, 12, 14));
    });
     testSingleCase(en.casual, "within One year", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "within One year");
      expectToBeDate(result.start , DateTime(2013, 7, 10, 12, 14));
    });
     testSingleCase(en.casual, "In 5 Minutes A car need to move",
        DateTime(2012, 7, 10, 12, 14), (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "In 5 Minutes");
      expectToBeDate(result.start , DateTime(2012, 7, 10, 12, 19));
    });
     testSingleCase(en.casual, "In 5 mins a car need to move",
        DateTime(2012, 7, 10, 12, 14), (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "In 5 mins");
      expectToBeDate(result.start , DateTime(2012, 7, 10, 12, 19));
    });
     testSingleCase(en.casual, "in a week", DateTime(2016, 10 - 1, 1),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.day), 8);
    });
     testSingleCase(
        en.casual, "In around 5 hours", DateTime(2016, 10 - 1, 1, 13),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.day), 1);
      expect(result.start.get(Component.hour), 18);
    });
     testSingleCase(
        en.casual, "In about ~5 hours", DateTime(2016, 10 - 1, 1, 13),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.day), 1);
      expect(result.start.get(Component.hour), 18);
    });
     testSingleCase(en.casual, "in 1 month", DateTime(2016, 10 - 1, 1, 14, 52),
        (ParsedResult result, String text) {
      expect(result.text, "in 1 month");
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 11);
      expect(result.start.get(Component.day), 1);
    });
   });
   test("Test - The within expression with certain keywords", () {
     testSingleCase(
         en.casual, "In  about 5 hours", DateTime(2012, 8 - 1, 10, 12, 49),
        (result, text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expect(result.start.get(Component.hour), 17);
      expect(result.start.get(Component.minute), 49);
    });
     testSingleCase(
         en.casual, "within around 3 hours", DateTime(2012, 8 - 1, 10, 12, 49),
        (result, text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expect(result.start.get(Component.hour), 15);
      expect(result.start.get(Component.minute), 49);
    });
     testSingleCase(
         en.casual, "In several hours", DateTime(2012, 8 - 1, 10, 12, 49),
        (result, text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expect(result.start.get(Component.hour), 19);
      expect(result.start.get(Component.minute), 49);
    });
     testSingleCase(
         en.casual, "In a couple of days", DateTime(2012, 8 - 1, 10, 12, 49),
        (result, text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 12);
      expect(result.start.get(Component.hour), 12);
      expect(result.start.get(Component.minute), 49);
    });
   });
   test("Test - Single Expression (Implied)", () {
     testSingleCase(en.casual, "within 30 days", DateTime(2012, 7, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(!result.start.isCertain(Component.year) == null, isFalse);
      expect(!result.start.isCertain(Component.month) == null, isFalse);
      expect(!result.start.isCertain(Component.day) == null, isFalse);
      expect(!result.start.isCertain(Component.hour) == null, isFalse);
      expect(!result.start.isCertain(Component.minute) == null, isFalse);
      expect(!result.start.isCertain(Component.second) == null, isFalse);
    });
   });
   test("Test - Implied time values", () {
     testSingleCase(en.casual, "in 24 hours", DateTime(2020, 7 - 1, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.hour), 12);
      expect(result.start.get(Component.minute), 14);
      expect(result.start.get(Component.day), 11);
      expect(result.start.get(Component.month), 7);
      expect(result.start.get(Component.year), 2020);
    });
     testSingleCase(en.casual, "in one day", DateTime(2020, 7 - 1, 10, 12, 14),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.hour), 12);
      expect(result.start.get(Component.minute), 14);
      expect(result.start.get(Component.day), 11);
      expect(result.start.get(Component.month), 7);
      expect(result.start.get(Component.year), 2020);
    });
   });
   test("Test - Time units' certainty", () {
     testSingleCase(en.casual, "in 2 minute", DateTime(2016, 10 - 1, 1, 14, 52),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.day), 1);
      expect(result.start.get(Component.hour), 14);
      expect(result.start.get(Component.minute), 54);
      expect(result.start.isCertain(Component.year),true);
      expect(result.start.isCertain(Component.month),true);
      expect(result.start.isCertain(Component.day),true);
      expect(result.start.isCertain(Component.hour),true);
      expect(result.start.isCertain(Component.minute),true);
    });
     testSingleCase(en.casual, "in 2hour", DateTime(2016, 10 - 1, 1, 14, 52),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.day), 1);
      expect(result.start.get(Component.hour), 16);
      expect(result.start.get(Component.minute), 52);
      expect(result.start.isCertain(Component.year),true);
      expect(result.start.isCertain(Component.month),true);
      expect(result.start.isCertain(Component.day),true);
      expect(result.start.isCertain(Component.hour),true);
      expect(result.start.isCertain(Component.minute),true);
    });
     testSingleCase(
        en.casual, "in a few year", DateTime(2016, 10 - 1, 1, 14, 52),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2019);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.day), 1);
      expect(result.start.get(Component.hour), 14);
      expect(result.start.get(Component.minute), 52);
      expect(result.start.isCertain(Component.month),false);
      expect(result.start.isCertain(Component.day),false);
      expect(result.start.isCertain(Component.hour),false);
      expect(result.start.isCertain(Component.minute),false);
    });
     testSingleCase(
        en.casual, "within 12 month", DateTime(2016, 10 - 1, 1, 14, 52),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2017);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.day), 1);
      expect(result.start.get(Component.hour), 14);
      expect(result.start.get(Component.minute), 52);
      expect(result.start.isCertain(Component.year),true);
      expect(result.start.isCertain(Component.month),true);
      expect(result.start.isCertain(Component.day),false);
      expect(result.start.isCertain(Component.hour),false);
      expect(result.start.isCertain(Component.minute),false);
    });
     testSingleCase(
        en.casual, "within 3 days", DateTime(2016, 10 - 1, 1, 14, 52),
        (ParsedResult result, String text) {
      expect(result.text, text);
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 10);
      expect(result.start.get(Component.day), 4);
      expect(result.start.get(Component.hour), 14);
      expect(result.start.get(Component.minute), 52);
      expect(result.start.isCertain(Component.year),true);
      expect(result.start.isCertain(Component.month),true);
      expect(result.start.isCertain(Component.day),true);
      expect(result.start.isCertain(Component.hour),false);
      expect(result.start.isCertain(Component.minute),false);
    });
     testSingleCase(
        en.casual,
        "give it 2 months",
        DateTime(2016, 10 - 1, 1, 14, 52),
        {"forwardDate": true}, (ParsedResult result, String text) {
      expect(result.text, "2 months");
      expect(result.start.get(Component.year), 2016);
      expect(result.start.get(Component.month), 12);
      expect(result.start.get(Component.day), 1);
      expect(result.start.get(Component.hour), 14);
      expect(result.start.get(Component.minute), 52);
      expect(result.start.isCertain(Component.year),true);
      expect(result.start.isCertain(Component.month),true);
      expect(result.start.isCertain(Component.day),false);
      expect(result.start.isCertain(Component.hour),false);
      expect(result.start.isCertain(Component.minute),false);
    });
   });
   test("Test - Strict mode", () {
     testSingleCase(en.casual, "in 2hour", DateTime(2016, 10 - 1, 1, 14, 52),
        (ParsedResult result, String text) {
      expect(result.start.get(Component.hour), 16);
      expect(result.start.get(Component.minute), 52);
    });
     testUnexpectedResult(en.strict, "in 15m");
     testUnexpectedResult(en.strict, "within 5hr");
   });
 }
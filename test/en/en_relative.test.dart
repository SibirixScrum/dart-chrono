import 'package:chrono/locales/en/index.dart' as en;
import 'package:chrono/types.dart';
import "package:flutter_test/flutter_test.dart";
import '../test_util.dart';
 void main() {
  test("Test - 'This' expressions", () {
   testSingleCase(
       en.casual, "this week", DateTime(2017, 11 - 1, 19, 12), (
       ParsedResult result, String text) {
    expect(result.text, text);
    expect(result.start.get(Component.year), 2017);
    expect(result.start.get(Component.month), 11);
    expect(result.start.get(Component.day), 19);
    expect(result.start.get(Component.hour), 12);
   });
   testSingleCase(
       en.casual, "this month", DateTime(2017, 11 - 1, 19, 12), (
       ParsedResult result, String text) {
    expect(result.text, text);
    expect(result.start.get(Component.year), 2017);
    expect(result.start.get(Component.month), 11);
    expect(result.start.get(Component.day), 1);
    expect(result.start.get(Component.hour), 12);
   });
   testSingleCase(
       en.casual, "this month", DateTime(2017, 11 - 1, 1, 12), (
       ParsedResult result, String text) {
    expect(result.text, text);
    expect(result.start.get(Component.year), 2017);
    expect(result.start.get(Component.month), 11);
    expect(result.start.get(Component.day), 1);
    expect(result.start.get(Component.hour), 12);
   });
   testSingleCase(
       en.casual, "this year", DateTime(2017, 11 - 1, 19, 12), (
       ParsedResult result, String text) {
    expect(result.text, text);
    expect(result.start.get(Component.year), 2017);
    expect(result.start.get(Component.month), 1);
    expect(result.start.get(Component.day), 1);
    expect(result.start.get(Component.hour), 12);
   });
  });
  test("Test - Past relative expressions", () {
   testSingleCase(
       en.casual, "last week", DateTime(2016, 10 - 1, 1, 12), (
       ParsedResult result, String text) {
    expect(result.text, text);
    expect(result.start.get(Component.year), 2016);
    expect(result.start.get(Component.month), 9);
    expect(result.start.get(Component.day), 24);
    expect(result.start.get(Component.hour), 12);
   });
   testSingleCase(
       en.casual, "lastmonth", DateTime(2016, 10 - 1, 1, 12), (
       ParsedResult result, String text) {
    expect(result.text, text);
    expect(result.start.get(Component.year), 2016);
    expect(result.start.get(Component.month), 9);
    expect(result.start.get(Component.day), 1);
    expect(result.start.get(Component.hour), 12);
   });
   testSingleCase(
       en.casual, "last day", DateTime(2016, 10 - 1, 1, 12), (
       ParsedResult result, String text) {
    expect(result.text, text);
    expect(result.start.get(Component.year), 2016);
    expect(result.start.get(Component.month), 9);
    expect(result.start.get(Component.day), 30);
    expect(result.start.get(Component.hour), 12);
   });
   testSingleCase(
       en.casual, "last month", DateTime(2016, 10 - 1, 1, 12), (
       ParsedResult result, String text) {
    expect(result.text, text);
    expect(result.start.get(Component.year), 2016);
    expect(result.start.get(Component.month), 9);
    expect(result.start.get(Component.day), 1);
    expect(result.start.get(Component.hour), 12);
   });
   testSingleCase(
       en.casual, "past week", DateTime(2016, 10 - 1, 1, 12), (
       ParsedResult result, String text) {
    expect(result.text, text);
    expect(result.start.get(Component.year), 2016);
    expect(result.start.get(Component.month), 9);
    expect(result.start.get(Component.day), 24);
    expect(result.start.get(Component.hour), 12);
   });
  });
  test("Test - Future relative expressions", () {
   testSingleCase(
       en.casual, "next hour", DateTime(2016, 10 - 1, 1, 12), (
       ParsedResult result, String text) {
    expect(result.text, text);
    expect(result.start.get(Component.year), 2016);
    expect(result.start.get(Component.month), 10);
    expect(result.start.get(Component.day), 1);
    expect(result.start.get(Component.hour), 13);
   });
   testSingleCase(
       en.casual, "next week", DateTime(2016, 10 - 1, 1, 12), (
       ParsedResult result, String text) {
    expect(result.text, text);
    expect(result.start.get(Component.year), 2016);
    expect(result.start.get(Component.month), 10);
    expect(result.start.get(Component.day), 8);
    expect(result.start.get(Component.hour), 12);
   });
   testSingleCase(
       en.casual, "next day", DateTime(2016, 10 - 1, 1, 12), (
       ParsedResult result, String text) {
    expect(result.text, text);
    expect(result.start.get(Component.year), 2016);
    expect(result.start.get(Component.month), 10);
    expect(result.start.get(Component.day), 2);
    expect(result.start.get(Component.hour), 12);
   });
   testSingleCase(
       en.casual, "next month", DateTime(2016, 10 - 1, 1, 12), (
       ParsedResult result, String text) {
    expect(result.text, text);
    expect(result.start.get(Component.year), 2016);
    expect(result.start.get(Component.month), 11);
    expect(result.start.get(Component.day), 1);
    expect(result.start.get(Component.hour), 12);
    expect(result.start.isCertain(Component.year), true);
    expect(result.start.isCertain(Component.month), true);
    expect(result.start.isCertain(Component.day), false);
    expect(result.start.isCertain(Component.hour), false);
   });
   testSingleCase(en.casual, "next year", DateTime(
       2020,
       11 - 1,
       22,
       12,
       11,
       32,
       6), (ParsedResult result, String text) {
    expect(result.text, text);
    expect(result.start.get(Component.year), 2021);
    expect(result.start.get(Component.month), 11);
    expect(result.start.get(Component.day), 22);
    expect(result.start.get(Component.hour), 12);
    expect(result.start.get(Component.minute), 11);
    expect(result.start.get(Component.second), 32);
    expect(result.start.get(Component.millisecond), 6);
    expect(result.start.isCertain(Component.year), true);
    expect(result.start.isCertain(Component.month), false);
    expect(result.start.isCertain(Component.day), false);
    expect(result.start.isCertain(Component.hour), false);
    expect(result.start.isCertain(Component.minute), false);
    expect(result.start.isCertain(Component.second), false);
    expect(result.start.isCertain(Component.millisecond), false);
    expect(result.start.isCertain(Component.timezoneOffset), false);
   });
   testSingleCase(
       en.casual, "next quarter", DateTime(2021, 1 - 1, 22, 12), (
       ParsedResult result, String text) {
    expect(result.text, text);
    expect(result.start.get(Component.year), 2021);
    expect(result.start.get(Component.month), 4);
    expect(result.start.get(Component.day), 22);
    expect(result.start.get(Component.hour), 12);
    expect(result.start.isCertain(Component.year), false);
    expect(result.start.isCertain(Component.month), false);
    expect(result.start.isCertain(Component.day), false);
    expect(result.start.isCertain(Component.hour), false);
   });
   testSingleCase(
       en.casual, "next qtr", DateTime(2021, 10 - 1, 22, 12), (
       ParsedResult result, String text) {
    expect(result.text, text);
    expect(result.start.get(Component.year), 2022);
    expect(result.start.get(Component.month), 1);
    expect(result.start.get(Component.day), 22);
    expect(result.start.get(Component.hour), 12);
    expect(result.start.isCertain(Component.year), false);
    expect(result.start.isCertain(Component.month), false);
    expect(result.start.isCertain(Component.day), false);
    expect(result.start.isCertain(Component.hour), false);
   });
   testSingleCase(
       en.casual, "next two quarter", DateTime(2021, 1 - 1, 22, 12), (
       ParsedResult result, String text) {
    expect(result.text, text);
    expect(result.start.get(Component.year), 2021);
    expect(result.start.get(Component.month), 7);
    expect(result.start.get(Component.day), 22);
    expect(result.start.get(Component.hour), 12);
    expect(result.start.isCertain(Component.year), false);
    expect(result.start.isCertain(Component.month), false);
    expect(result.start.isCertain(Component.day), false);
    expect(result.start.isCertain(Component.hour), false);
   });
   testSingleCase(en.casual, "after this year", DateTime(
       2020,
       11 - 1,
       22,
       12,
       11,
       32,
       6), (ParsedResult result, String text) {
    expect(result.text, text);
    expect(result.start.get(Component.year), 2021);
    expect(result.start.get(Component.month), 11);
    expect(result.start.get(Component.day), 22);
    expect(result.start.get(Component.hour), 12);
    expect(result.start.get(Component.minute), 11);
    expect(result.start.get(Component.second), 32);
    expect(result.start.get(Component.millisecond), 6);
    expect(result.start.isCertain(Component.year), true);
    expect(result.start.isCertain(Component.month), false);
    expect(result.start.isCertain(Component.day), false);
    expect(result.start.isCertain(Component.hour), false);
    expect(result.start.isCertain(Component.minute), false);
    expect(result.start.isCertain(Component.second), false);
    expect(result.start.isCertain(Component.millisecond), false);
    expect(result.start.isCertain(Component.timezoneOffset), false);
   });
   testSingleCase(
       en.casual, "Connect back after this year",
       DateTime(2022, 4 - 1, 16, 12), (result, text) {
    expect(result.start.get(Component.year), 2023);
    expect(result.start.get(Component.month), 4);
    expect(result.start.get(Component.day), 16);
   });
  });
  test("Test - Relative date components' certainty", () {
   final refDate = DateTime(2016, 10 - 1, 7, 12);
   testSingleCase(
       en.casual, "next hour", refDate, (ParsedResult result, String text) {
    expect(result.text, text);
    expect(result.start.get(Component.year), 2016);
    expect(result.start.get(Component.month), 10);
    expect(result.start.get(Component.day), 7);
    expect(result.start.get(Component.hour), 13);
    expect(result.start.get(Component.timezoneOffset),
        refDate.getTimezoneOffset() * -1);
    expect(result.start.isCertain(Component.year), true);
    expect(result.start.isCertain(Component.month), true);
    expect(result.start.isCertain(Component.day), true);
    expect(result.start.isCertain(Component.hour), true);
    expect(result.start.isCertain(Component.timezoneOffset), true);
   });
   testSingleCase(
       en.casual, "next month", refDate, (ParsedResult result, String text) {
    //const expectedDate = DateTime(2016, 11, 7, 12);
    expect(result.text, text);
    expect(result.start.get(Component.year), 2016);
    expect(result.start.get(Component.month), 11);
    expect(result.start.get(Component.day), 7);
    expect(result.start.get(Component.hour), 12);
    //expect(result.start.get(Component.timezoneOffset) , -expectedDate.getTimezoneOffset());
    expect(result.start.isCertain(Component.year), true);
    expect(result.start.isCertain(Component.month), true);
    expect(result.start.isCertain(Component.day), false);
    expect(result.start.isCertain(Component.hour), false);
    expect(result.start.isCertain(Component.timezoneOffset), false);
   });
  });
  test("Test - Relative date components' certainty and imply timezone", () {
   final refDate = DateTime(
       "Sun Nov 29 2020 13:24:13 GMT+0900 (Japan Standard Time)");
   {
    const text = "now";
    final result =;
    expect(result.text, text);
    result.start.imply("timezoneOffset", 60);
    expectToBeDate(result.start,
        DateTime("Sun Nov 29 2020 13:24:13 GMT+0900 (Japan Standard Time)"));
    expectToBeDate(result.start,DateTime("Sun Nov 29 2020 5:24:13 GMT+0100"));
   }
   {
    const text = "tomorrow at 5pm";
    final result =;
    expect(result.text, text);
    result.start.imply("timezoneOffset", 60);
    expectToBeDate(result.start,
        DateTime("Sun Dec 1 2020 1:00:00 GMT+0900 (Japan Standard Time)"));
    expectToBeDate(result.start,DateTime("Sun Nov 30 2020 17:00:00 GMT+0100"));
   }
   {
    const text = "in 10 minutes";
    final result =;
    expect(result.text, text);
    result.start.imply("timezoneOffset", 60);
    expectToBeDate(result.start,
        DateTime("Sun Nov 29 2020 13:34:13 GMT+0900 (Japan Standard Time)"));
    expectToBeDate(result.start,DateTime("Sun Nov 29 2020 5:34:13 GMT+0100"));
   }
   {
    const text = "in 10 minutes";
    final result =;
    expect(result.text, text);
    result.start.imply("timezoneOffset", 60);
    expectToBeDate(result.start,
        DateTime("Sun Nov 29 2020 13:34:13 GMT+0900 (Japan Standard Time)"));
    expectToBeDate(result.start,DateTime("Sun Nov 29 2020 5:34:13 GMT+0100"));
   }
   {
    const text = "in 10 minutes";
    final result =;
    expect(result.text, text);
    result.start.imply("timezoneOffset", 60);
    expectToBeDate(result.start,
        DateTime("Sun Nov 29 2020 13:34:13 GMT+0900 (Japan Standard Time)"));
    expectToBeDate(result.start,DateTime("Sun Nov 29 2020 5:34:13 GMT+0100"));
   }
   {
    const text = "in 20 minutes";
    final result =;
    expect(result.text, text);
    expect(result.start.isCertain(Component.timezoneOffset), false);
   }
  });
 }
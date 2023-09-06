import 'package:chrono/locales/en/index.dart' as en;
import "package:flutter_test/flutter_test.dart";
import '../test_util.dart';
 void main() {
  test("Test - 'This' expressions", () {
   testSingleCase(
       en.casual, "this week", new Date (2017, 11 - 1, 19, 12), (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2017);
    expect(result.start.get("month")).toBe(11);
    expect(result.start.get("day")).toBe(19);
    expect(result.start.get("hour")).toBe(12);
   });
   testSingleCase(
       en.casual, "this month", new Date (2017, 11 - 1, 19, 12), (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2017);
    expect(result.start.get("month")).toBe(11);
    expect(result.start.get("day")).toBe(1);
    expect(result.start.get("hour")).toBe(12);
   });
   testSingleCase(
       en.casual, "this month", new Date (2017, 11 - 1, 1, 12), (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2017);
    expect(result.start.get("month")).toBe(11);
    expect(result.start.get("day")).toBe(1);
    expect(result.start.get("hour")).toBe(12);
   });
   testSingleCase(
       en.casual, "this year", new Date (2017, 11 - 1, 19, 12), (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2017);
    expect(result.start.get("month")).toBe(1);
    expect(result.start.get("day")).toBe(1);
    expect(result.start.get("hour")).toBe(12);
   });
  });
  test("Test - Past relative expressions", () {
   testSingleCase(
       en.casual, "last week", new Date (2016, 10 - 1, 1, 12), (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2016);
    expect(result.start.get("month")).toBe(9);
    expect(result.start.get("day")).toBe(24);
    expect(result.start.get("hour")).toBe(12);
   });
   testSingleCase(
       en.casual, "lastmonth", new Date (2016, 10 - 1, 1, 12), (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2016);
    expect(result.start.get("month")).toBe(9);
    expect(result.start.get("day")).toBe(1);
    expect(result.start.get("hour")).toBe(12);
   });
   testSingleCase(
       en.casual, "last day", new Date (2016, 10 - 1, 1, 12), (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2016);
    expect(result.start.get("month")).toBe(9);
    expect(result.start.get("day")).toBe(30);
    expect(result.start.get("hour")).toBe(12);
   });
   testSingleCase(
       en.casual, "last month", new Date (2016, 10 - 1, 1, 12), (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2016);
    expect(result.start.get("month")).toBe(9);
    expect(result.start.get("day")).toBe(1);
    expect(result.start.get("hour")).toBe(12);
   });
   testSingleCase(
       en.casual, "past week", new Date (2016, 10 - 1, 1, 12), (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2016);
    expect(result.start.get("month")).toBe(9);
    expect(result.start.get("day")).toBe(24);
    expect(result.start.get("hour")).toBe(12);
   });
  });
  test("Test - Future relative expressions", () {
   testSingleCase(
       en.casual, "next hour", new Date (2016, 10 - 1, 1, 12), (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2016);
    expect(result.start.get("month")).toBe(10);
    expect(result.start.get("day")).toBe(1);
    expect(result.start.get("hour")).toBe(13);
   });
   testSingleCase(
       en.casual, "next week", new Date (2016, 10 - 1, 1, 12), (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2016);
    expect(result.start.get("month")).toBe(10);
    expect(result.start.get("day")).toBe(8);
    expect(result.start.get("hour")).toBe(12);
   });
   testSingleCase(
       en.casual, "next day", new Date (2016, 10 - 1, 1, 12), (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2016);
    expect(result.start.get("month")).toBe(10);
    expect(result.start.get("day")).toBe(2);
    expect(result.start.get("hour")).toBe(12);
   });
   testSingleCase(
       en.casual, "next month", new Date (2016, 10 - 1, 1, 12), (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2016);
    expect(result.start.get("month")).toBe(11);
    expect(result.start.get("day")).toBe(1);
    expect(result.start.get("hour")).toBe(12);
    expect(result.start.isCertain("year")).toBe(true);
    expect(result.start.isCertain("month")).toBe(true);
    expect(result.start.isCertain("day")).toBe(false);
    expect(result.start.isCertain("hour")).toBe(false);
   });
   testSingleCase(en.casual, "next year", new Date (
       2020,
       11 - 1,
       22,
       12,
       11,
       32,
       6), (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2021);
    expect(result.start.get("month")).toBe(11);
    expect(result.start.get("day")).toBe(22);
    expect(result.start.get("hour")).toBe(12);
    expect(result.start.get("minute")).toBe(11);
    expect(result.start.get("second")).toBe(32);
    expect(result.start.get("millisecond")).toBe(6);
    expect(result.start.isCertain("year")).toBe(true);
    expect(result.start.isCertain("month")).toBe(false);
    expect(result.start.isCertain("day")).toBe(false);
    expect(result.start.isCertain("hour")).toBe(false);
    expect(result.start.isCertain("minute")).toBe(false);
    expect(result.start.isCertain("second")).toBe(false);
    expect(result.start.isCertain("millisecond")).toBe(false);
    expect(result.start.isCertain("timezoneOffset")).toBe(false);
   });
   testSingleCase(
       en.casual, "next quarter", new Date (2021, 1 - 1, 22, 12), (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2021);
    expect(result.start.get("month")).toBe(4);
    expect(result.start.get("day")).toBe(22);
    expect(result.start.get("hour")).toBe(12);
    expect(result.start.isCertain("year")).toBe(false);
    expect(result.start.isCertain("month")).toBe(false);
    expect(result.start.isCertain("day")).toBe(false);
    expect(result.start.isCertain("hour")).toBe(false);
   });
   testSingleCase(
       en.casual, "next qtr", new Date (2021, 10 - 1, 22, 12), (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2022);
    expect(result.start.get("month")).toBe(1);
    expect(result.start.get("day")).toBe(22);
    expect(result.start.get("hour")).toBe(12);
    expect(result.start.isCertain("year")).toBe(false);
    expect(result.start.isCertain("month")).toBe(false);
    expect(result.start.isCertain("day")).toBe(false);
    expect(result.start.isCertain("hour")).toBe(false);
   });
   testSingleCase(
       en.casual, "next two quarter", new Date (2021, 1 - 1, 22, 12), (result,
       text) {
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2021);
    expect(result.start.get("month")).toBe(7);
    expect(result.start.get("day")).toBe(22);
    expect(result.start.get("hour")).toBe(12);
    expect(result.start.isCertain("year")).toBe(false);
    expect(result.start.isCertain("month")).toBe(false);
    expect(result.start.isCertain("day")).toBe(false);
    expect(result.start.isCertain("hour")).toBe(false);
   });
   testSingleCase(en.casual, "after this year", new Date (
       2020,
       11 - 1,
       22,
       12,
       11,
       32,
       6), (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2021);
    expect(result.start.get("month")).toBe(11);
    expect(result.start.get("day")).toBe(22);
    expect(result.start.get("hour")).toBe(12);
    expect(result.start.get("minute")).toBe(11);
    expect(result.start.get("second")).toBe(32);
    expect(result.start.get("millisecond")).toBe(6);
    expect(result.start.isCertain("year")).toBe(true);
    expect(result.start.isCertain("month")).toBe(false);
    expect(result.start.isCertain("day")).toBe(false);
    expect(result.start.isCertain("hour")).toBe(false);
    expect(result.start.isCertain("minute")).toBe(false);
    expect(result.start.isCertain("second")).toBe(false);
    expect(result.start.isCertain("millisecond")).toBe(false);
    expect(result.start.isCertain("timezoneOffset")).toBe(false);
   });
   testSingleCase(
       en.casual, "Connect back after this year", new Date (2022, 4 - 1, 16, 12), (
       result, text) {
    expect(result.start.get("year")).toBe(2023);
    expect(result.start.get("month")).toBe(4);
    expect(result.start.get("day")).toBe(16);
   });
  });
  test("Test - Relative date components' certainty", () {
   final refDate = new Date (2016, 10 - 1, 7, 12);
   testSingleCase(en.casual, "next hour", refDate, (result, text) {
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2016);
    expect(result.start.get("month")).toBe(10);
    expect(result.start.get("day")).toBe(7);
    expect(result.start.get("hour")).toBe(13);
    expect(result.start.get("timezoneOffset")).toBe(
        refDate.getTimezoneOffset() * -1);
    expect(result.start.isCertain("year")).toBe(true);
    expect(result.start.isCertain("month")).toBe(true);
    expect(result.start.isCertain("day")).toBe(true);
    expect(result.start.isCertain("hour")).toBe(true);
    expect(result.start.isCertain("timezoneOffset")).toBe(true);
   });
   testSingleCase(en.casual, "next month", refDate, (result, text) {
    //const expectedDate = new Date(2016, 11, 7, 12);
    expect(result.text).toBe(text);
    expect(result.start.get("year")).toBe(2016);
    expect(result.start.get("month")).toBe(11);
    expect(result.start.get("day")).toBe(7);
    expect(result.start.get("hour")).toBe(12);
    //expect(result.start.get("timezoneOffset")).toBe(-expectedDate.getTimezoneOffset());
    expect(result.start.isCertain("year")).toBe(true);
    expect(result.start.isCertain("month")).toBe(true);
    expect(result.start.isCertain("day")).toBe(false);
    expect(result.start.isCertain("hour")).toBe(false);
    expect(result.start.isCertain("timezoneOffset")).toBe(false);
   });
  });
  test("Test - Relative date components' certainty and imply timezone", () {
   final refDate = new Date (
       "Sun Nov 29 2020 13:24:13 GMT+0900 (Japan Standard Time)");
   {
    const text = "now";
    final result =;
    expect(result.text).toBe(text);
    result.start.imply("timezoneOffset", 60);
    expect(result).toBeDate(
        new Date ("Sun Nov 29 2020 13:24:13 GMT+0900 (Japan Standard Time)"));
    expect(result).toBeDate(new Date ("Sun Nov 29 2020 5:24:13 GMT+0100"));
   }
   {
    const text = "tomorrow at 5pm";
    final result =;
    expect(result.text).toBe(text);
    result.start.imply("timezoneOffset", 60);
    expect(result).toBeDate(
        new Date ("Sun Dec 1 2020 1:00:00 GMT+0900 (Japan Standard Time)"));
    expect(result).toBeDate(new Date ("Sun Nov 30 2020 17:00:00 GMT+0100"));
   }
   {
    const text = "in 10 minutes";
    final result =;
    expect(result.text).toBe(text);
    result.start.imply("timezoneOffset", 60);
    expect(result).toBeDate(
        new Date ("Sun Nov 29 2020 13:34:13 GMT+0900 (Japan Standard Time)"));
    expect(result).toBeDate(new Date ("Sun Nov 29 2020 5:34:13 GMT+0100"));
   }
   {
    const text = "in 10 minutes";
    final result =;
    expect(result.text).toBe(text);
    result.start.imply("timezoneOffset", 60);
    expect(result).toBeDate(
        new Date ("Sun Nov 29 2020 13:34:13 GMT+0900 (Japan Standard Time)"));
    expect(result).toBeDate(new Date ("Sun Nov 29 2020 5:34:13 GMT+0100"));
   }
   {
    const text = "in 10 minutes";
    final result =;
    expect(result.text).toBe(text);
    result.start.imply("timezoneOffset", 60);
    expect(result).toBeDate(
        new Date ("Sun Nov 29 2020 13:34:13 GMT+0900 (Japan Standard Time)"));
    expect(result).toBeDate(new Date ("Sun Nov 29 2020 5:34:13 GMT+0100"));
   }
   {
    const text = "in 20 minutes";
    final result =;
    expect(result.text).toBe(text);
    expect(result.start.isCertain("timezoneOffset")).toBe(false);
   }
  });
 }
import 'package:chrono/locales/en/index.dart' as en;
import "package:flutter_test/flutter_test.dart";
import '../test_util.dart';

 void main() {
   test("Test - Later Expression", () {
     testSingleCase(
         en.casual, "2 days later", new Date (2012, 7, 10, 12), (result) {
       expect(result.start).not.toBeNull();
       expect(result.start.get("year")).toBe(2012);
       expect(result.start.get("month")).toBe(8);
       expect(result.start.get("day")).toBe(12);
       expect(result.index).toBe(0);
       expect(result.text).toBe("2 days later");
       expect(result.start.isCertain("day")).toBe(true);
       expect(result.start.isCertain("month")).toBe(true);
       expect(result.start).toBeDate(new Date (2012, 8 - 1, 12, 12));
     });
     testSingleCase(
         en.casual, "5 minutes later", new Date (2012, 7, 10, 10, 0), (result) {
       expect(result.start).not.toBeNull();
       expect(result.start.get("year")).toBe(2012);
       expect(result.start.get("month")).toBe(8);
       expect(result.start.get("day")).toBe(10);
       expect(result.start.get("hour")).toBe(10);
       expect(result.start.get("minute")).toBe(5);
       expect(result.index).toBe(0);
       expect(result.text).toBe("5 minutes later");
       expect(result.start.isCertain("hour")).toBe(true);
       expect(result.start.isCertain("minute")).toBe(true);
       expect(result.start).toBeDate(new Date (2012, 8 - 1, 10, 10, 5));
     });
     testSingleCase(
         en.casual, "3 week later", new Date (2012, 7 - 1, 10, 10, 0), (result) {
       expect(result.start).not.toBeNull();
       expect(result.start.get("year")).toBe(2012);
       expect(result.start.get("month")).toBe(7);
       expect(result.start.get("day")).toBe(31);
       expect(result.index).toBe(0);
       expect(result.text).toBe("3 week later");
       expect(result.start).toBeDate(new Date (2012, 7 - 1, 31, 10, 0));
     });
     testSingleCase(
         en.casual, "3w later", new Date (2012, 7 - 1, 10, 10, 0), (result) {
       expect(result.start).not.toBeNull();
       expect(result.start.get("year")).toBe(2012);
       expect(result.start.get("month")).toBe(7);
       expect(result.start.get("day")).toBe(31);
       expect(result.index).toBe(0);
       expect(result.text).toBe("3w later");
     });
     testSingleCase(
         en.casual, "3mo later", new Date (2012, 7 - 1, 10, 10, 0), (result) {
       expect(result.start).not.toBeNull();
       expect(result.start.get("year")).toBe(2012);
       expect(result.start.get("month")).toBe(10);
       expect(result.start.get("day")).toBe(10);
       expect(result.index).toBe(0);
       expect(result.text).toBe("3mo later");
     });
   });
   test("Test - From now Expression", () {
     testSingleCase(
         en.casual, "5 days from now, we did something", new Date (2012, 7, 10), (
         result) {
       expect(result.start).not.toBeNull();
       expect(result.start.get("year")).toBe(2012);
       expect(result.start.get("month")).toBe(8);
       expect(result.start.get("day")).toBe(15);
       expect(result.index).toBe(0);
       expect(result.text).toBe("5 days from now");
       expect(result.start).toBeDate(new Date (2012, 8 - 1, 15));
     });
     testSingleCase(
         en.casual, "10 days from now, we did something", new Date (2012, 7, 10), (
         result) {
       expect(result.start).not.toBeNull();
       expect(result.start.get("year")).toBe(2012);
       expect(result.start.get("month")).toBe(8);
       expect(result.start.get("day")).toBe(20);
       expect(result.index).toBe(0);
       expect(result.text).toBe("10 days from now");
       expect(result.start).toBeDate(new Date (2012, 8 - 1, 20));
     });
     testSingleCase(
         en.casual, "15 minute from now", new Date (2012, 7, 10, 12, 14), (
         result) {
       expect(result.index).toBe(0);
       expect(result.text).toBe("15 minute from now");
       expect(result.start.get("hour")).toBe(12);
       expect(result.start.get("minute")).toBe(29);
       expect(result.start.get("meridiem")).toBe(Meridiem.PM);
       expect(result.start).toBeDate(new Date (2012, 7, 10, 12, 29));
     });
     testSingleCase(
         en.casual, "15 minutes earlier", new Date (2012, 7, 10, 12, 14), (
         result) {
       expect(result.index).toBe(0);
       expect(result.text).toBe("15 minutes earlier");
       expect(result.start.get("hour")).toBe(11);
       expect(result.start.get("minute")).toBe(59);
       expect(result.start.get("meridiem")).toBe(Meridiem.AM);
       expect(result.start).toBeDate(new Date (2012, 7, 10, 11, 59));
     });
     testSingleCase(
         en.casual, "15 minute out", new Date (2012, 7, 10, 12, 14), (result) {
       expect(result.index).toBe(0);
       expect(result.text).toBe("15 minute out");
       expect(result.start.get("hour")).toBe(12);
       expect(result.start.get("minute")).toBe(29);
       expect(result.start.get("meridiem")).toBe(Meridiem.PM);
       expect(result.start).toBeDate(new Date (2012, 7, 10, 12, 29));
     });
     testSingleCase(
         en.casual, "   12 hours from now", new Date (2012, 7, 10, 12, 14), (
         result) {
       expect(result.index).toBe(3);
       expect(result.text).toBe("12 hours from now");
       expect(result.start.get("day")).toBe(11);
       expect(result.start.get("hour")).toBe(0);
       expect(result.start.get("minute")).toBe(14);
       expect(result.start).toBeDate(new Date (2012, 7, 11, 0, 14));
     });
     testSingleCase(
         en.casual, "   12 hrs from now", new Date (2012, 7, 10, 12, 14), (
         result) {
       expect(result.index).toBe(3);
       expect(result.text).toBe("12 hrs from now");
       expect(result.start.get("day")).toBe(11);
       expect(result.start.get("hour")).toBe(0);
       expect(result.start.get("minute")).toBe(14);
       expect(result.start.get("meridiem")).toBe(Meridiem.AM);
     });
     testSingleCase(
         en.casual, "   half an hour from now", new Date (2012, 7, 10, 12, 14), (
         result) {
       expect(result.index).toBe(3);
       expect(result.text).toBe("half an hour from now");
       expect(result.start.get("hour")).toBe(12);
       expect(result.start.get("minute")).toBe(44);
       expect(result.start.get("meridiem")).toBe(Meridiem.PM);
       expect(result.start).toBeDate(new Date (2012, 7, 10, 12, 44));
     });
     testSingleCase(en.casual, "12 hours from now I did something",
         new Date (2012, 7, 10, 12, 14), (result) {
           expect(result.index).toBe(0);
           expect(result.text).toBe("12 hours from now");
           expect(result.start.get("day")).toBe(11);
           expect(result.start.get("hour")).toBe(0);
           expect(result.start.get("minute")).toBe(14);
           expect(result.start).toBeDate(new Date (2012, 7, 11, 0, 14));
         });
     testSingleCase(en.casual, "12 seconds from now I did something",
         new Date (2012, 7, 10, 12, 14), (result) {
           expect(result.index).toBe(0);
           expect(result.text).toBe("12 seconds from now");
           expect(result.start.get("hour")).toBe(12);
           expect(result.start.get("minute")).toBe(14);
           expect(result.start.get("second")).toBe(12);
           expect(result.start).toBeDate(new Date (2012, 7, 10, 12, 14, 12));
         });
     testSingleCase(en.casual, "three seconds from now I did something",
         new Date (2012, 7, 10, 12, 14), (result) {
           expect(result.index).toBe(0);
           expect(result.text).toBe("three seconds from now");
           expect(result.start.get("hour")).toBe(12);
           expect(result.start.get("minute")).toBe(14);
           expect(result.start.get("second")).toBe(3);
           expect(result.start).toBeDate(new Date (2012, 7, 10, 12, 14, 3));
         });
     testSingleCase(
         en.casual, "5 Days from now, we did something", new Date (2012, 7, 10), (
         result) {
       expect(result.start).not.toBeNull();
       expect(result.start.get("year")).toBe(2012);
       expect(result.start.get("month")).toBe(8);
       expect(result.start.get("day")).toBe(15);
       expect(result.index).toBe(0);
       expect(result.text).toBe("5 Days from now");
       expect(result.start).toBeDate(new Date (2012, 8 - 1, 15));
     });
     testSingleCase(
         en.casual, "   half An hour from now", new Date (2012, 7, 10, 12, 14), (
         result) {
       expect(result.index).toBe(3);
       expect(result.text).toBe("half An hour from now");
       expect(result.start.get("hour")).toBe(12);
       expect(result.start.get("minute")).toBe(44);
       expect(result.start).toBeDate(new Date (2012, 7, 10, 12, 44));
     });
     testSingleCase(
         en.casual, "A days from now, we did something", new Date (2012, 7, 10), (
         result) {
       expect(result.start).not.toBeNull();
       expect(result.start.get("year")).toBe(2012);
       expect(result.start.get("month")).toBe(8);
       expect(result.start.get("day")).toBe(11);
       expect(result.index).toBe(0);
       expect(result.text).toBe("A days from now");
       expect(result.start).toBeDate(new Date (2012, 8 - 1, 11));
     });
     testSingleCase(
         en.casual, "a min out", new Date (2012, 7, 10, 12, 14), (result) {
       expect(result.index).toBe(0);
       expect(result.text).toBe("a min out");
       expect(result.start.get("hour")).toBe(12);
       expect(result.start.get("minute")).toBe(15);
       expect(result.start).toBeDate(new Date (2012, 7, 10, 12, 15));
     });
     testSingleCase(
         en.casual, "in 1 hour", new Date (2012, 7, 10, 12, 14), (result) {
       expect(result.index).toBe(0);
       expect(result.text).toBe("in 1 hour");
       expect(result.start.get("hour")).toBe(13);
       expect(result.start.get("minute")).toBe(14);
       expect(result.start).toBeDate(new Date (2012, 7, 10, 13, 14));
     });
     testSingleCase(
         en.casual, "in 1 mon", new Date (2012, 7, 10, 12, 14), (result) {
       expect(result.index).toBe(0);
       expect(result.text).toBe("in 1 mon");
       expect(result.start.get("month")).toBe(8 + 1);
       expect(result.start).toBeDate(new Date (2012, 8, 10, 12, 14));
     });
     testSingleCase(
         en.casual, "in 1.5 hours", new Date (2012, 7, 10, 12, 40), (result) {
       expect(result.index).toBe(0);
       expect(result.text).toBe("in 1.5 hours");
       expect(result.start.get("hour")).toBe(14);
       expect(result.start.get("minute")).toBe(10);
       expect(result.start).toBeDate(new Date (2012, 7, 10, 14, 10));
     });
     testSingleCase(
         en.casual, "in 1d 2hr 5min", new Date (2012, 7, 10, 12, 40), (result) {
       expect(result.index).toBe(0);
       expect(result.text).toBe("in 1d 2hr 5min");
       expect(result.start.get("day")).toBe(11);
       expect(result.start.get("hour")).toBe(14);
       expect(result.start.get("minute")).toBe(45);
       expect(result.start).toBeDate(new Date (2012, 7, 11, 14, 45));
     });
   });
   test("Test - Strict mode", () {
     testSingleCase(
         en.casual, "the min after", new Date (2012, 7, 10, 12, 14), (result) {
       expect(result.index).toBe(0);
       expect(result.text).toBe("the min after");
       expect(result.start.get("hour")).toBe(12);
       expect(result.start.get("minute")).toBe(15);
       expect(result.start.get("meridiem")).toBe(Meridiem.PM);
       expect(result.start).toBeDate(new Date (2012, 7, 10, 12, 15));
     });
     testSingleCase(
         en.casual.strict, "15 minutes from now", new Date (2012, 7, 10, 12, 14), (
         result, text) {
       expect(result.text).toBe(text);
       expect(result.start.get("hour")).toBe(12);
       expect(result.start.get("minute")).toBe(29);
       expect(result.start).toBeDate(new Date (2012, 7, 10, 12, 29));
     });
     testSingleCase(
         en.casual.strict, "25 minutes later", new Date (2012, 7, 10, 12, 40), (
         result) {
       expect(result.index).toBe(0);
       expect(result.text).toBe("25 minutes later");
       expect(result.start.get("hour")).toBe(13);
       expect(result.start.get("minute")).toBe(5);
       expect(result.start).toBeDate(new Date (2012, 7, 10, 13, 5));
     });
     testUnexpectedResult(en.casual.strict, "15m from now");
     testUnexpectedResult(en.casual.strict, "15s later");
   });
   test("Test - After with reference", () {
     testSingleCase(
         en.casual, "2 day after today", new Date (2012, 7, 10), (result) {
       expect(result.start.get("year")).toBe(2012);
       expect(result.start.get("month")).toBe(8);
       expect(result.start.get("day")).toBe(12);
     });
     testSingleCase(
         en.casual, "the day after tomorrow", new Date (2012, 7, 10), (result) {
       expect(result.start.get("year")).toBe(2012);
       expect(result.start.get("month")).toBe(8);
       expect(result.start.get("day")).toBe(12);
     });
     testSingleCase(
         en.casual, "2 day after tomorrow", new Date (2012, 7, 10), (result) {
       expect(result.text).toBe("2 day after tomorrow");
       expect(result.start.get("year")).toBe(2012);
       expect(result.start.get("month")).toBe(8);
       expect(result.start.get("day")).toBe(13);
     });
     testSingleCase(
         en.casual, "a week after tomorrow", new Date (2012, 7, 10), (result) {
       expect(result.text).toBe("a week after tomorrow");
       expect(result.start.get("year")).toBe(2012);
       expect(result.start.get("month")).toBe(8);
       expect(result.start.get("day")).toBe(18);
     });
   });
 }
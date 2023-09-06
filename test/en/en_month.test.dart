
import 'package:chrono/locales/en/index.dart' as en;
import "package:flutter_test/flutter_test.dart";
import '../test_util.dart';

 void main() {
   test("Test - Month-Year expression", () {
     testSingleCase(en.casual, "September 2012", (result) {
       expect(result.text).toBe("September 2012");
       expect(result.start.get("year")).toBe(2012);
       expect(result.start.get("month")).toBe(9);
       expect(result.start.get("day")).toBe(1);
       expect(result.start.isCertain("year")).toBe(true);
       expect(result.start.isCertain("month")).toBe(true);
       expect(result.start.isCertain("day")).toBe(false);
       expect(result.start).toBeDate(new Date (2012, 9 - 1, 1, 12));
     });
     testSingleCase(en.casual, "Sept 2012", (result) {
       expect(result.text).toBe("Sept 2012");
       expect(result.start.get("year")).toBe(2012);
       expect(result.start.get("month")).toBe(9);
       expect(result.start.get("day")).toBe(1);
       expect(result.start.isCertain("year")).toBe(true);
       expect(result.start.isCertain("month")).toBe(true);
       expect(result.start.isCertain("day")).toBe(false);
       expect(result.start).toBeDate(new Date (2012, 9 - 1, 1, 12));
     });
     testSingleCase(en.casual, "Sep 2012", (result) {
       expect(result.text).toBe("Sep 2012");
       expect(result.start.get("year")).toBe(2012);
       expect(result.start.get("month")).toBe(9);
       expect(result.start.get("day")).toBe(1);
       expect(result.start.isCertain("year")).toBe(true);
       expect(result.start.isCertain("month")).toBe(true);
       expect(result.start.isCertain("day")).toBe(false);
       expect(result.start).toBeDate(new Date (2012, 9 - 1, 1, 12));
     });
     testSingleCase(en.casual, "Sep. 2012", (result) {
       expect(result.text).toBe("Sep. 2012");
       expect(result.start.get("year")).toBe(2012);
       expect(result.start.get("month")).toBe(9);
       expect(result.start.get("day")).toBe(1);
       expect(result.start.isCertain("year")).toBe(true);
       expect(result.start.isCertain("month")).toBe(true);
       expect(result.start.isCertain("day")).toBe(false);
       expect(result.start).toBeDate(new Date (2012, 9 - 1, 1, 12));
     });
     testSingleCase(en.casual, "Sep-2012", (result) {
       expect(result.start).not.toBeNull();
       expect(result.start.get("year")).toBe(2012);
       expect(result.start.get("month")).toBe(9);
       expect(result.index).toBe(0);
       expect(result.text).toBe("Sep-2012");
       expect(result.start).toBeDate(new Date (2012, 9 - 1, 1, 12));
     });
   });
   test("Test - Month-Only expression", () {
     testSingleCase(
         en.casual, "In January", new Date (2020, 11 - 1, 22), (result) {
       expect(result.text).toContain("January");
       expect(result.start).not.toBeNull();
       expect(result.start.get("year")).toBe(2021);
       expect(result.start.get("month")).toBe(1);
       expect(result.start.get("day")).toBe(1);
       expect(result.start.isCertain("year")).toBe(false);
       expect(result.start.isCertain("month")).toBe(true);
       expect(result.start.isCertain("day")).toBe(false);
       expect(result.start).toBeDate(new Date (2021, 1 - 1, 1, 12));
     });
     testSingleCase(en.casual, "in Jan", new Date (2020, 11 - 1, 22), (result) {
       expect(result.text).toContain("Jan");
       expect(result.start).not.toBeNull();
       expect(result.start.get("year")).toBe(2021);
       expect(result.start.get("month")).toBe(1);
       expect(result.start.get("day")).toBe(1);
       expect(result.start.isCertain("year")).toBe(false);
       expect(result.start.isCertain("month")).toBe(true);
       expect(result.start.isCertain("day")).toBe(false);
       expect(result.start).toBeDate(new Date (2021, 1 - 1, 1, 12));
     });
     testSingleCase(en.casual, "May", new Date (2020, 11 - 1, 22), (result) {
       expect(result.text).toContain("May");
       expect(result.start).not.toBeNull();
       expect(result.start.get("year")).toBe(2021);
       expect(result.start.get("month")).toBe(5);
       expect(result.start.get("day")).toBe(1);
       expect(result.start.isCertain("year")).toBe(false);
       expect(result.start.isCertain("month")).toBe(true);
       expect(result.start.isCertain("day")).toBe(false);
       expect(result.start).toBeDate(new Date (2021, 5 - 1, 1, 12));
     });
   });
   test("Test - Month-Only Range expression", () {
     testSingleCase(
         en.casual, "From May to December", new Date (2023, 4 - 1, 9), (result) {
       expect(result.start.get("year")).toBe(2023);
       expect(result.start.get("month")).toBe(5);
       expect(result.end.get("year")).toBe(2023);
       expect(result.end.get("month")).toBe(12);
     });
     testSingleCase(
         en.casual, "From December to May", new Date (2023, 4 - 1, 9), (result) {
       expect(result.start.get("year")).toBe(2022);
       expect(result.start.get("month")).toBe(12);
       expect(result.end.get("year")).toBe(2023);
       expect(result.end.get("month")).toBe(5);
     });
     testSingleCase(
         en.casual, "From May to December, 2022", new Date (2023, 4 - 1, 9), (
         result) {
       expect(result.start.get("year")).toBe(2022);
       expect(result.start.get("month")).toBe(5);
       expect(result.end.get("year")).toBe(2022);
       expect(result.end.get("month")).toBe(12);
     });
     testSingleCase(
         en.casual, "From December to May 2022", new Date (2023, 4 - 1, 9), (
         result) {
       expect(result.start.get("year")).toBe(2021);
       expect(result.start.get("month")).toBe(12);
       expect(result.end.get("year")).toBe(2022);
       expect(result.end.get("month")).toBe(5);
     });
     testSingleCase(
         en.casual, "From December to May 2020", new Date (2023, 4 - 1, 9), (
         result) {
       expect(result.start.get("year")).toBe(2019);
       expect(result.start.get("month")).toBe(12);
       expect(result.end.get("year")).toBe(2020);
       expect(result.end.get("month")).toBe(5);
     });
     testSingleCase(
         en.casual, "From December to May 2025", new Date (2023, 4 - 1, 9), (
         result) {
       expect(result.start.get("year")).toBe(2024);
       expect(result.start.get("month")).toBe(12);
       expect(result.end.get("year")).toBe(2025);
       expect(result.end.get("month")).toBe(5);
     });
   });
   test("Test - Month with farward date option", () {
     testSingleCase(en.casual, "in December", new Date (2023, 4 - 1, 9),
         { "forwardDate": true}, (result) {
           expect(result.start.get("year")).toBe(2023);
           expect(result.start.get("month")).toBe(12);
         });
     testSingleCase(
         en.casual, "in May", new Date (2023, 4 - 1, 9), { "forwardDate": true}, (
         result) {
       expect(result.start.get("year")).toBe(2023);
       expect(result.start.get("month")).toBe(5);
     });
     testSingleCase(en.casual, "From May to December", new Date (2023, 4 - 1, 9),
         { "forwardDate": true}, (result) {
           expect(result.start.get("year")).toBe(2023);
           expect(result.start.get("month")).toBe(5);
           expect(result.end.get("year")).toBe(2023);
           expect(result.end.get("month")).toBe(12);
         });
     testSingleCase(en.casual, "From December to May", new Date (2023, 4 - 1, 9),
         { "forwardDate": true}, (result) {
           expect(result.start.get("year")).toBe(2023);
           expect(result.start.get("month")).toBe(12);
           expect(result.end.get("year")).toBe(2024);
           expect(result.end.get("month")).toBe(5);
         });
   });
   test("Test - Month expression in context", () {
     testSingleCase(en.casual, "The date is Sep 2012 is the date", (result) {
       expect(result.index).toBe(12);
       expect(result.text).toBe("Sep 2012");
       expect(result.start).not.toBeNull();
       expect(result.start.get("year")).toBe(2012);
       expect(result.start.get("month")).toBe(9);
       expect(result.start).toBeDate(new Date (2012, 9 - 1, 1, 12));
     });
     testSingleCase(en.casual, "By Angie Mar November 2019", (result) {
       expect(result.text).toBe("November 2019");
       expect(result.start).not.toBeNull();
       expect(result.start.get("year")).toBe(2019);
       expect(result.start.get("month")).toBe(11);
       expect(result.start).toBeDate(new Date (2019, 11 - 1, 1, 12));
     });
   });
   test("Test - Month slash expression", () {
     testSingleCase(en.casual, "9/2012", new Date (2012, 7, 10), (result) {
       expect(result.start).not.toBeNull();
       expect(result.start.get("year")).toBe(2012);
       expect(result.start.get("month")).toBe(9);
       expect(result.index).toBe(0);
       expect(result.text).toBe("9/2012");
       expect(result.start).toBeDate(new Date (2012, 9 - 1, 1, 12));
     });
     testSingleCase(en.casual, "09/2012", new Date (2012, 7, 10), (result) {
       expect(result.start.get("year")).toBe(2012);
       expect(result.start.get("month")).toBe(9);
       expect(result.index).toBe(0);
       expect(result.text).toBe("09/2012");
       expect(result.start).toBeDate(new Date (2012, 9 - 1, 1, 12));
     });
   });
   test("Test - year 90's parsing", () {
     testSingleCase(en.casual, "Aug 96", new Date (2012, 7, 10), (result) {
       expect(result.text).toBe("Aug 96");
       expect(result.start.get("year")).toBe(1996);
       expect(result.start.get("month")).toBe(8);
     });
     testSingleCase(en.casual, "96 Aug 96", new Date (2012, 7, 10), (result) {
       expect(result.text).toBe("Aug 96");
       expect(result.start.get("year")).toBe(1996);
       expect(result.start.get("month")).toBe(8);
     });
   });
   test("Test - Month should not have timezone", () {
     testSingleCase(en.casual,
         "People visiting Buñol towards the end of August get a good chance to participate in La Tomatina (under normal circumstances)",
         new Date (2012, 7, 10), (result) {
           expect(result.text).toBe("August");
           expect(result.start.get("year")).toBe(2012);
           expect(result.start.get("month")).toBe(8);
         });
   });
 }
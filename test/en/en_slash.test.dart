
import 'package:chrono/locales/en/index.dart' as en;
import "package:flutter_test/flutter_test.dart";
import '../test_util.dart';

 void main() {
  test("Test - Parsing Offset Expression", () {
   testSingleCase(en.casual, "    04/2016   ", new Date (2012, 7, 10), (result) {
    expect(result.index).toBe(4);
    expect(result.text).toBe("04/2016");
   });
  });
  test("Test - Single Expression", () {
   testSingleCase(
       en.casual, "The event is going ahead (04/2016)", new Date (2012, 7, 10), (
       result) {
    expect(result.start).not.toBeNull();
    expect(result.start.get("year")).toBe(2016);
    expect(result.start.get("month")).toBe(4);
    expect(result.start.get("day")).toBe(1);
    expect(result.index).toBe(26);
    expect(result.text).toBe("04/2016");
    expect(result.start).toBeDate(new Date (2016, 4 - 1, 1, 12));
   });
   testSingleCase(
       en.casual, "Published: 06/2004", new Date (2012, 7, 10), (result) {
    expect(result.start).not.toBeNull();
    expect(result.start.get("year")).toBe(2004);
    expect(result.start.get("month")).toBe(6);
    expect(result.start.get("day")).toBe(1);
    expect(result.index).toBe(11);
    expect(result.text).toBe("06/2004");
    expect(result.start).toBeDate(new Date (2004, 6 - 1, 1, 12));
   });
   testSingleCase(en.casual, "8/10/2012", new Date (2012, 7, 10), (result) {
    expect(result.start).not.toBeNull();
    expect(result.start.get("year")).toBe(2012);
    expect(result.start.get("month")).toBe(8);
    expect(result.start.get("day")).toBe(10);
    expect(result.index).toBe(0);
    expect(result.text).toBe("8/10/2012");
    expect(result.start.isCertain("day")).toBe(true);
    expect(result.start.isCertain("month")).toBe(true);
    expect(result.start.isCertain("year")).toBe(true);
    expect(result.start).toBeDate(new Date (2012, 8 - 1, 10, 12));
   });
   testSingleCase(en.casual, ": 8/1/2012", new Date (2012, 7, 10), (result) {
    expect(result.start).not.toBeNull();
    expect(result.start.get("year")).toBe(2012);
    expect(result.start.get("month")).toBe(8);
    expect(result.start.get("day")).toBe(1);
    expect(result.index).toBe(2);
    expect(result.text).toBe("8/1/2012");
    expect(result.start).toBeDate(new Date (2012, 8 - 1, 1, 12));
   });
   testSingleCase(en.casual, "8/10", new Date (2012, 7, 10), (result) {
    expect(result.start).not.toBeNull();
    expect(result.start.get("year")).toBe(2012);
    expect(result.start.get("month")).toBe(8);
    expect(result.start.get("day")).toBe(10);
    expect(result.index).toBe(0);
    expect(result.text).toBe("8/10");
    expect(result.start.isCertain("day")).toBe(true);
    expect(result.start.isCertain("month")).toBe(true);
    expect(result.start.isCertain("year")).toBe(false);
    expect(result.start).toBeDate(new Date (2012, 8 - 1, 10, 12));
   });
   testSingleCase(
       en.casual, "The Deadline is 8/10/2012", new Date (2012, 7, 10), (result) {
    expect(result.index).toBe(16);
    expect(result.text).toBe("8/10/2012");
    expect(result.start).toBeDate(new Date (2012, 7, 10, 12));
   });
   testSingleCase(
       en.casual, "The Deadline is Tuesday 11/3/2015", new Date (2015, 10, 3), (
       result) {
    expect(result.index).toBe(16);
    expect(result.text).toBe("Tuesday 11/3/2015");
    expect(result.start).toBeDate(new Date (2015, 10, 3, 12));
   });
   testSingleCase(en.casual.strict, "2/28/2014", (result) {
    expect(result.text).toBe("2/28/2014");
   });
   testWithExpectedDate(
       en.casual.strict, "12-30-16", new Date (2016, 12 - 1, 30, 12));
   testSingleCase(en.casual.strict, "Friday 12-30-16", (result) {
    expect(result.text).toBe("Friday 12-30-16");
    expect(result).toBeDate(new Date (2016, 12 - 1, 30, 12));
   });
  });
  test("Test - Single Expression Little-Endian", () {
   testSingleCase(en.casual.en.GB, "8/10/2012", new Date (2012, 7, 10), (result) {
    expect(result.start).not.toBeNull();
    expect(result.start.get("year")).toBe(2012);
    expect(result.start.get("month")).toBe(10);
    expect(result.start.get("day")).toBe(8);
    expect(result.index).toBe(0);
    expect(result.text).toBe("8/10/2012");
    expect(result.start).toBeDate(new Date (2012, 10 - 1, 8, 12));
   });
   testWithExpectedDate(
       en.casual.strict, "30-12-16", new Date (2016, 12 - 1, 30, 12));
   testSingleCase(en.casual.strict, "Friday 30-12-16", (result) {
    expect(result.text).toBe("Friday 30-12-16");
    expect(result).toBeDate(new Date (2016, 12 - 1, 30, 12));
   });
  });
  test("Test - Single Expression Little-Endian with Month name", () {
   testSingleCase(en.casual.en.GB, "8/Oct/2012", new Date (2012, 7, 10), (result) {
    expect(result.start).not.toBeNull();
    expect(result.start.get("year")).toBe(2012);
    expect(result.start.get("month")).toBe(10);
    expect(result.start.get("day")).toBe(8);
    expect(result.index).toBe(0);
    expect(result.text).toBe("8/Oct/2012");
    expect(result.start).toBeDate(new Date (2012, 10 - 1, 8, 12));
   });
  });
  test("Test - Range Expression", () {
   testSingleCase(
       en.casual.en, "8/10/2012 - 8/15/2012", new Date (2012, 7, 10), (result) {
    expect(result.index).toBe(0);
    expect(result.text).toBe("8/10/2012 - 8/15/2012");
    expect(result.start).not.toBeNull();
    expect(result.start.get("year")).toBe(2012);
    expect(result.start.get("month")).toBe(8);
    expect(result.start.get("day")).toBe(10);
    expect(result.start).toBeDate(new Date (2012, 8 - 1, 10, 12));
    expect(result.end).not.toBeNull();
    expect(result.end.get("year")).toBe(2012);
    expect(result.end.get("month")).toBe(8);
    expect(result.end.get("day")).toBe(15);
    expect(result.end).toBeDate(new Date (2012, 8 - 1, 15, 12));
   });
  });
  test("Test - Splitter variances patterns", () {
   final expectDate = new Date (2015, 5 - 1, 25, 12, 0);
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
       en.casual, "5/31", new Date (1999, 6 - 1, 1), { "forwardDate": true}, (
       result) {
    expect(result.start).not.toBeNull();
    expect(result.start.get("year")).toBe(2000);
    expect(result.start.get("month")).toBe(5);
    expect(result.start.get("day")).toBe(31);
    expect(result.index).toBe(0);
    expect(result.text).toBe("5/31");
    expect(result.start.isCertain("day")).toBe(true);
    expect(result.start.isCertain("month")).toBe(true);
    expect(result.start.isCertain("year")).toBe(false);
    expect(result.start).toBeDate(new Date (2000, 5 - 1, 31, 12));
   });
   testSingleCase(en.casual, "1/8 at 12pm", new Date ("Sep 25 2021 12:00:00"),
       { "forwardDate": true}, (result) {
        expect(result.text).toBe("1/8 at 12pm");
        expect(result.start).not.toBeNull();
        expect(result.start.get("year")).toBe(2022);
        expect(result.start.get("month")).toBe(1);
        expect(result.start.get("day")).toBe(8);
        expect(result.start).toBeDate(new Date (2022, 1 - 1, 8, 12));
       });
  });
 }
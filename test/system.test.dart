import 'package:chrono/chrono.dart';
import 'package:chrono/locales/ru/index.dart' as ru;
import 'package:chrono/types.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_util.dart';

void main() {
  final chrono = ru.casual;
  // test("Test - Load modules", () {
  //   expect(chrono).toBeDefined();
  //   expect(chrono.Chrono).toBeDefined();
  //   expect(chrono.parse).toBeDefined();
  //   expect(chrono.parseDate).toBeDefined();
  //   expect(chrono.casual).toBeDefined();
  //   expect(chrono.strict).toBeDefined();
  // });
  // test("Test - Basic parse date functions", () {
  //   expect(chrono.parseDateTime("7:00PM July 5th, 2020"))
  //       .toStrictEqual(new DateTime(2020, 7 - 1, 5, 19));
  //   expect(chrono.en.parseDateTime("7:00PM July 5th, 2020"))
  //       .toStrictEqual(new DateTime(2020, 7 - 1, 5, 19));
  //   expect(chrono.strict.parseDateTime("7:00PM July 5th, 2020"))
  //       .toStrictEqual(new DateTime(2020, 7 - 1, 5, 19));
  //   expect(chrono.casual.parseDateTime("7:00PM July 5th, 2020"))
  //       .toStrictEqual(new DateTime(2020, 7 - 1, 5, 19));
  // });
  test("Test - Add custom parser", () {
    final Parser customParser = CustomParser((context, match) {
      expect(match[0], "25th");
      expect(context.refDate == null, isFalse);
      return {"day": int.parse(match[1])};
    }, (_) {
      return new RegExp(r'(\d{1,2})(st|nd|rd|th)', caseSensitive: false);
    });
    // {
    //   "pattern": () {
    //     return new RegExp(r'(\d{1,2})(st|nd|rd|th)', caseSensitive: false);
    //   },
    //   "extract": (context, match) {
    //     expect(match[0],"25th");
    //     expect(context.refDate == null,isFalse);
    //     return {"day": int.parse(match[1])};
    //   }
    // };
    final custom = Chrono(Configuration([customParser], []));
    testSingleCase(custom, "meeting on 25th", new DateTime(2017, 11 - 1, 19),
        (result) {
      expect(result.text, "25th");
      expect(result.start.get("month"), 11);
      expect(result.start.get("day"), 25);
    });
  });
  test("Test - Add custom parser example", () {
    final custom = ru.casual.clone();
    final Parser customParser = CustomParser((context, match) {
      return {"day": 25, "month": 12};
    }, (_) {
      return new RegExp(r'\bChristmas\b', caseSensitive: false);
    });
    custom.parsers.add(customParser);
    testSingleCase(custom, "I'll arrive at 2.30AM on Christmas", (result) {
      expect(result.text, "at 2.30AM on Christmas");
      expect(result.start.get("month"), 12);
      expect(result.start.get("day"), 25);
      expect(result.start.get("hour"), 2);
      expect(result.start.get("minute"), 30);
    });
    testSingleCase(custom, "I'll arrive at Christmas night", (result) {
      expect(result.text, "Christmas night");
      expect(result.start.get("month"), 12);
      expect(result.start.get("day"), 25);
      expect(result.start.get("meridiem"), Meridiem.PM.index);
      expect(result.start.get("meridiem"), 1);
    });
    testSingleCase(custom, "Doing something tomorrow", (result) {
      expect(result.text, "tomorrow");
    });
  });
  test("Test - Add custom refiner example", () {
    final custom = ru.casual.clone();
    final customRefiner = CustomRefiner((context, results){
      // If there is no AM/PM (meridiem) specified,

      //  let all time between 1:00 - 4:00 be PM (13.00 - 16.00)
      results.forEach((result) {
        if (!result.start.isCertain("meridiem") &&
            result.start.get("hour") >= 1 &&
            result.start.get("hour") < 4) {
          result.start.assign("meridiem", Meridiem.PM);
          result.start.assign("hour", result.start.get("hour") + 12);
        }
      });
      return results;
    } );

    // custom.refiners.add(refine: (context, results) {
    //   // If there is no AM/PM (meridiem) specified,
    //
    //   //  let all time between 1:00 - 4:00 be PM (13.00 - 16.00)
    //   results.forEach((result) {
    //     if (!result.start.isCertain("meridiem") &&
    //         result.start.get("hour") >= 1 &&
    //         result.start.get("hour") < 4) {
    //       result.start.assign("meridiem", Meridiem.PM);
    //       result.start.assign("hour", result.start.get("hour") + 12);
    //     }
    //   });
    //   return results;
    // });
    testSingleCase(custom, "This is at 2.30", (result) {
      expect(result.text, "at 2.30");
      expect(result.start.get("hour"), 14);
      expect(result.start.get("minute"), 30);
    });
    testSingleCase(custom, "This is at 2.30 AM", (result) {
      expect(result.text, "at 2.30 AM");
      expect(result.start.get("hour"), 2);
      expect(result.start.get("minute"), 30);
    });
  });
  test("Test - Remove a parser example", () {
    final custom = chrono.en.strict.clone();
    custom.parsers =
        custom.parsers.filter((r) => !(r is SlashDateFormatParser));
    custom.parsers.push(new SlashDateFormatParser(true));
    testSingleCase(custom, "6/10/2018", (result) {
      expect(result.text, "6/10/2018");
      expect(result.start.get("year"), 2018);
      expect(result.start.get("month"), 10);
      expect(result.start.get("day"), 6);
    });
  });
  test("Test - Remove a refiner example", () {
    final custom = chrono.casual.clone();
    custom.refiners =
        custom.refiners.filter((r) => !(r is UnlikelyFormatFilter));
    testSingleCase(custom, "This is at 2.30", (result) {
      expect(result.text, "at 2.30");
      expect(result.start.get("hour"), 2);
      expect(result.start.get("minute"), 30);
    });
  });
  test("Test - Replace a parser example", () {
    final custom = chrono.en.casual.clone();
    testSingleCase(custom, "next 5m", new DateTime(2016, 10 - 1, 1, 14, 52),
        (result, text) {
      expect(result.start.get("hour"), 14);
      expect(result.start.get("minute"), 57);
    });
    testSingleCase(
        custom, "next 5 minutes", new DateTime(2016, 10 - 1, 1, 14, 52),
        (result, text) {
      expect(result.start.get("hour"), 14);
      expect(result.start.get("minute"), 57);
    });
    final index = custom.parsers
        .findIndex((r) => r is ENTimeUnitCasualRelativeFormatParser);
    custom.parsers[index] = new ENTimeUnitCasualRelativeFormatParser(false);
    testUnexpectedResult(custom, "next 5m");
    testSingleCase(
        custom, "next 5 minutes", new DateTime(2016, 10 - 1, 1, 14, 52),
        (result, text) {
      expect(result.start.get("hour"), 14);
      expect(result.start.get("minute"), 57);
    });
  });
  test("Test - Compare with native js", () {
    final testByCompareWithNative = (text) {
      final expectedDate = new DateTime(text);
      testSingleCase(chrono, text, (result) {
        expect(result.text, text);
        expectToBeDate(result, expectedDate);
      });
    };
    testByCompareWithNative("1994-11-05T13:15:30Z");
    testByCompareWithNative("1994-02-28T08:15:30-05:30");
    testByCompareWithNative("1994-11-05T08:15:30-05:30");
    testByCompareWithNative("1994-11-05T08:15:30+11:30");
    testByCompareWithNative("2014-11-30T08:15:30-05:30");
    testByCompareWithNative("Sat, 21 Feb 2015 11:50:48 -0500");
    testByCompareWithNative("22 Feb 2015 04:12:00 -0000");
    testByCompareWithNative("1900-01-01T00:00:00-01:00");
    testByCompareWithNative("1900-01-01T00:00:00-00:00");
    testByCompareWithNative("9999-12-31T23:59:00-00:00");
    testByCompareWithNative("09/25/2017 10:31:50.522 PM");
    testByCompareWithNative("Sat Nov 05 1994 22:45:30 GMT+0900 (JST)");
    testByCompareWithNative("Fri, 31 Mar 2000 07:00:00 UTC");
    testByCompareWithNative("2014-12-14T18:22:14.759Z");
  });
}

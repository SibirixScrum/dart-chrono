import "package:chrono/chrono.dart";
import "package:flutter_test/flutter_test.dart";

import "test_util.dart" show ParsingReferenceDummy, testSingleCase;

void main() {
  final chrono = Chrono();
  test("Test - Timezone difference on reference example", () {
    testSingleCase(Chrono(), "Friday at 4pm", {
      "instant": DateTime.parse("2021-06-09T07:00:00-0500"),
      "timezone": "CDT"
    }, (result) {
      expect(result, DateTime.parse("2021-06-11T16:00:00-0500"));
      expect(result, DateTime.parse("2021-06-12T06:00:00+0900"));
    });
  });
  test("Test - Timezone difference on default timezone", () {
    const INPUT = "Friday at 4pm";
    final REF_INSTANT = new DateTime(2021, 6 - 1, 9, 7, 0, 0);
    final EXPECTED_INSTANT = new DateTime(2021, 6 - 1, 11, 16, 0, 0);
    testSingleCase(chrono, INPUT, REF_INSTANT, (result) {
      expect(result, EXPECTED_INSTANT);
    });
    testSingleCase(chrono, INPUT, ParsingReferenceDummy(REF_INSTANT), (result) {
      expect(result, EXPECTED_INSTANT);
    });
    testSingleCase(chrono, INPUT, ParsingReferenceDummy(REF_INSTANT, null),
        (result) {
      expect(result, EXPECTED_INSTANT);
    });
    testSingleCase(chrono, INPUT, ParsingReferenceDummy(REF_INSTANT, ""),
        (result) {
      expect(result, EXPECTED_INSTANT);
    });
  });
  test("Test - Timezone difference on reference date", () {
// Sun Jun 06 2021 19:00:00 GMT+0900 (JST)

// Sun Jun 06 2021 11:00:00 GMT+0100 (BST)
    final refInstant = new DateTime("2021-06-06T19:00:00 GMT+0900 (JST)");
    testSingleCase(
        chrono, "At 4pm tomorrow", {"instant": refInstant, "timezone": "BST"},
        (result) {
      final expectedInstant = new Date("2021-06-07T16:00:00 GMT+0100 (BST)");
      expect(result).toBeDate(expectedInstant);
    });
    testSingleCase(
        chrono, "At 4pm tomorrow", {"instant": refInstant, "timezone": "JST"},
        (result) {
      final expectedInstant = new Date("2021-06-07T16:00:00 GMT+0900 (JST)");
      expect(result).toBeDate(expectedInstant);
    });
  });
  test("Test - Timezone difference on written date", () {
// Sun Jun 06 2021 19:00:00 GMT+0900 (JST)

// Sun Jun 06 2021 11:00:00 GMT+0100 (BST)
    final refInstant = new Date("06 2021-06-06T19:00:00 GMT+0900 (JST)");
    testSingleCase(chrono, "2021-06-06T19:00:00", {"timezone": "JST"},
        (result) {
      expect(result).toBeDate(refInstant);
    });
    testSingleCase(chrono, "2021-06-06T11:00:00", {"timezone": "BST"},
        (result) {
      expect(result).toBeDate(refInstant);
    });
    testSingleCase(chrono, "2021-06-06T11:00:00", {"timezone": 60}, (result) {
      expect(result).toBeDate(refInstant);
    });
  });
  test("Test - Precise [now] mentioned", () {
    final refDate =
        new Date("Sat Mar 13 2021 14:22:14 GMT+0900 (Japan Standard Time)");
    testSingleCase(chrono, "now", refDate, (result) {
      expect(result).toBeDate(refDate);
    });
    testSingleCase(chrono, "now", {"instant": refDate}, (result) {
      expect(result).toBeDate(refDate);
    });
    testSingleCase(chrono, "now", {"instant": refDate, "timezone": 540},
        (result) {
      expect(result).toBeDate(refDate);
    });
    testSingleCase(chrono, "now", {"instant": refDate, "timezone": "JST"},
        (result) {
      expect(result).toBeDate(refDate);
    });
    testSingleCase(chrono, "now", {"instant": refDate, "timezone": -300},
        (result) {
      expect(result).toBeDate(refDate);
    });
  });
  test("Test - Precise date/time mentioned", () {
    const text = "Sat Mar 13 2021 14:22:14 GMT+0900";
    final refDate = new Date();
    testSingleCase(chrono, text, refDate, (result, text) {
      expect(result).toBeDate(new Date(text));
    });
    testSingleCase(chrono, text, {"instant": refDate}, (result) {
      expect(result).toBeDate(new Date(text));
    });
    testSingleCase(chrono, text, {"instant": refDate, "timezone": 540},
        (result) {
      expect(result).toBeDate(new Date(text));
    });
    testSingleCase(chrono, text, {"instant": refDate, "timezone": "JST"},
        (result) {
      expect(result).toBeDate(new Date(text));
    });
    testSingleCase(chrono, text, {"instant": refDate, "timezone": -300},
        (result) {
      expect(result).toBeDate(new Date(text));
    });
  });
}

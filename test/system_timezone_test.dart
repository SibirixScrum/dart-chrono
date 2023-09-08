import "package:chrono/chrono.dart";
import "package:flutter_test/flutter_test.dart";

import "test_util.dart"
    show ParsingReferenceDummy, expectToBeDate, testSingleCase;

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
    final refInstant = DateTime.parse("2021-06-06T19:00:00+0900");
    testSingleCase(
        chrono, "At 4pm tomorrow", {"instant": refInstant, "timezone": "BST"},
        (result) {
      final expectedInstant = DateTime.parse("2021-06-07T16:00:00+0100");
      expectToBeDate(result, expectedInstant);
    });
    testSingleCase(
        chrono, "At 4pm tomorrow", {"instant": refInstant, "timezone": "JST"},
        (result) {
      final expectedInstant = DateTime.parse("2021-06-07T16:00:00+0900");
      expectToBeDate(result, expectedInstant);
    });
  });
  test("Test - Timezone difference on written date", () {
// Sun Jun 06 2021 19:00:00 GMT+0900 (JST)

// Sun Jun 06 2021 11:00:00 GMT+0100 (BST)
    final refInstant = DateTime.parse("06 2021-06-06T19:00:00+0900");
    testSingleCase(chrono, "2021-06-06T19:00:00", {"timezone": "JST"},
        (result) {
      expectToBeDate(result, refInstant);
    });
    testSingleCase(chrono, "2021-06-06T11:00:00", {"timezone": "BST"},
        (result) {
      expectToBeDate(result, refInstant);
    });
    testSingleCase(chrono, "2021-06-06T11:00:00", {"timezone": 60}, (result) {
      expectToBeDate(result, refInstant);
    });
  });
  test("Test - Precise [now] mentioned", () {
    final refDate = DateTime.parse("Sat Mar 13 2021 14:22:14+0900");
    testSingleCase(chrono, "now", refDate, (result) {
      expectToBeDate(result, refDate);
    });
    testSingleCase(chrono, "now", {"instant": refDate}, (result) {
      expectToBeDate(result, refDate);
    });
    testSingleCase(chrono, "now", {"instant": refDate, "timezone": 540},
        (result) {
      expectToBeDate(result, refDate);
    });
    testSingleCase(chrono, "now", {"instant": refDate, "timezone": "JST"},
        (result) {
      expectToBeDate(result, refDate);
    });
    testSingleCase(chrono, "now", {"instant": refDate, "timezone": -300},
        (result) {
      expectToBeDate(result, refDate);
    });
  });
  test("Test - Precise date/time mentioned", () {
    const text = "2021-03-13T14:22:14+0900";
    final refDate = DateTime.now();
    testSingleCase(chrono, text, refDate, (result, text) {
      expectToBeDate(result, DateTime.parse(text));
    });
    testSingleCase(chrono, text, {"instant": refDate}, (result) {
      expectToBeDate(result, DateTime.parse(text));
    });
    testSingleCase(chrono, text, {"instant": refDate, "timezone": 540},
        (result) {
      expectToBeDate(result, DateTime.parse(text));
    });
    testSingleCase(chrono, text, {"instant": refDate, "timezone": "JST"},
        (result) {
      expectToBeDate(result, DateTime.parse(text));
    });
    testSingleCase(chrono, text, {"instant": refDate, "timezone": -300},
        (result) {
      expectToBeDate(result, DateTime.parse(text));
    });
  });
}

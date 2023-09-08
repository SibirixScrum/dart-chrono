import "package:chrono/chrono.dart";
import "package:chrono/types.dart";
import "package:flutter_test/flutter_test.dart";

import "test_util.dart"
    show ParsingReferenceDummy, expectToBeDate, testSingleCase;

void main() {
  final chrono = Chrono();
  test("Test - Timezone difference on reference example", () {
    testSingleCase(Chrono(), "Friday at 4pm", ParsingReference(DateTime.parse("2021-06-09T07:00:00-0500"),"CDT")
        , (ParsedResult result, String text) {
      expectToBeDate(result.start, DateTime.parse("2021-06-11T16:00:00-0500"));
      expectToBeDate(result.start,  DateTime.parse("2021-06-12T06:00:00+0900"));
    });
  });
  test("Test - Timezone difference on default timezone", () {
    const INPUT = "Friday at 4pm";
    final REF_INSTANT = new DateTime(2021, 6, 9, 7, 0, 0);
    final EXPECTED_INSTANT = new DateTime(2021, 6, 11, 16, 0, 0);
    testSingleCase(chrono, INPUT, REF_INSTANT, (ParsedResult result, String text) {
      expectToBeDate(result.start,  EXPECTED_INSTANT);
    });
    testSingleCase(chrono, INPUT, ParsingReferenceDummy(REF_INSTANT), (ParsedResult result, String text) {
      expectToBeDate(result.start,  EXPECTED_INSTANT);
    });
    testSingleCase(chrono, INPUT, ParsingReferenceDummy(REF_INSTANT, null),
            (ParsedResult result, String text) {
      expectToBeDate(result.start,  EXPECTED_INSTANT);
    });
    testSingleCase(chrono, INPUT, ParsingReferenceDummy(REF_INSTANT, ""),
            (ParsedResult result, String text) {
      expectToBeDate(result.start,  EXPECTED_INSTANT);
    });
  });
  test("Test - Timezone difference on reference date", () {
// Sun Jun 06 2021 19:00:00 GMT+0900 (JST)

// Sun Jun 06 2021 11:00:00 GMT+0100 (BST)
    final refInstant = DateTime.parse("2021-06-06T19:00:00+0900");
    testSingleCase(
        chrono, "At 4pm tomorrow", ParsingReference(refInstant,"BST"),
       (ParsedResult result, String text) {
      final expectedInstant = DateTime.parse("2021-06-07T16:00:00+0100");
      expectToBeDate(result.start, expectedInstant);
    });
    testSingleCase(
        chrono, "At 4pm tomorrow", ParsingReference(refInstant,"JST"),
        (ParsedResult result, String text) {
      final expectedInstant = DateTime.parse("2021-06-07T16:00:00+0900");
      expectToBeDate(result.start, expectedInstant);
    });
  });
  test("Test - Timezone difference on written date", () {
// Sun Jun 06 2021 19:00:00 GMT+0900 (JST)

// Sun Jun 06 2021 11:00:00 GMT+0100 (BST)
    final refInstant = DateTime.parse("2021-06-06T19:00:00+0900");
    testSingleCase(chrono, "Sun Jun 06 2021 19:00:00",   ParsingReference(null,"JST"),
       (ParsedResult result, String text) {
      expectToBeDate(result.start, refInstant);
    });
    testSingleCase(chrono, "Sun Jun 06 2021 11:00:00", ParsingReference(null,"BST"),
        (ParsedResult result, String text) {
      expectToBeDate(result.start, refInstant);
    });
    testSingleCase(chrono, "Sun Jun 06 2021 11:00:00", ParsingReference(null,60), (ParsedResult result, String text) {
      expectToBeDate(result.start, refInstant);
    });
  });
  test("Test - Precise [now] mentioned", () {
    final refDate = DateTime.parse("2021-03-13T14:22:14+0900");
    testSingleCase(chrono, "now", refDate, (ParsedResult result, String text) {
      expectToBeDate(result.start, refDate);
    });
    testSingleCase(chrono, "now", ParsingReference(refDate), (ParsedResult result, String text) {
      expectToBeDate(result.start, refDate);
    });
    testSingleCase(chrono, "now", ParsingReference(refDate,540),
        (ParsedResult result, String text) {
      expectToBeDate(result.start, refDate);
    });
    testSingleCase(chrono, "now", ParsingReference(refDate,"JST"),
        (ParsedResult result, String text) {
      expectToBeDate(result.start, refDate);
    });
    testSingleCase(chrono, "now", ParsingReference(refDate,-300),
        (ParsedResult result, String text) {
      expectToBeDate(result.start, refDate);
    });
  });
  test("Test - Precise date/time mentioned", () {
    const text = "2021-03-13T14:22:14+0900";
    final refDate = DateTime.now();
    testSingleCase(chrono, text, refDate,(ParsedResult result, String text) {
      expectToBeDate(result.start, DateTime.parse(text));
    });
    testSingleCase(chrono, text, ParsingReference(refDate), (ParsedResult result, String text) {
      expectToBeDate(result.start, DateTime.parse(text));
    });
    testSingleCase(chrono, text, ParsingReference(refDate,540),
        (ParsedResult result, String text) {
      expectToBeDate(result.start, DateTime.parse(text));
    });
    testSingleCase(chrono, text, ParsingReference(refDate,"JST"),
        (ParsedResult result, String text) {
      expectToBeDate(result.start, DateTime.parse(text));
    });
    testSingleCase(chrono, text,ParsingReference(refDate,-300),
        (ParsedResult result, String text) {
      expectToBeDate(result.start, DateTime.parse(text));
    });
  });
}

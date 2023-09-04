import "dart:convert";
import "dart:html";

import "package:chrono/chrono.dart";
import "package:chrono/debugging.dart";
import "package:chrono/results.dart";
import "package:chrono/types.dart";
import "package:flutter_test/flutter_test.dart";

abstract class ChronoLike {
  List<ParsedResult> parse(String text,
      [dynamic /* ParsingReference | Date */ referenceDate, ParsingOption? option]);
}

typedef CheckResult = void Function(ParsedResult p, String text);

// testSingleCase(ChronoLike chrono, String text, [ CheckResult? checkResult ]);
//
// testSingleCase(ChronoLike chrono, String text,
//     [ dynamic /* ParsingReference | Date | CheckResult */ refDateOrCheckResult, CheckResult checkResult ]);
//
// testSingleCase(ChronoLike chrono, String text,
//     [ dynamic /* ParsingReference | Date | CheckResult */ refDateOrCheckResult, dynamic /* ParsingOption | CheckResult */ optionOrCheckResult, CheckResult checkResult ]);

testSingleCase(Chrono chrono, String text,
    [dynamic /* ParsingReference | Date | CheckResult */ refDateOrCheckResult,
    dynamic /* ParsingOption | CheckResult */ optionOrCheckResult,
    CheckResult? checkResult]) {
  if (identical(checkResult, null) && optionOrCheckResult is CheckResult) {
    checkResult = optionOrCheckResult;
    optionOrCheckResult = null;
  }
  if (optionOrCheckResult == null && refDateOrCheckResult is CheckResult) {
    checkResult = refDateOrCheckResult;
    refDateOrCheckResult = null;
  }
  final debugHandler = BufferedDebugHandler();
  optionOrCheckResult =
      optionOrCheckResult is ParsingOption ? optionOrCheckResult : () {};
  if (optionOrCheckResult is ParsingOption) {
    optionOrCheckResult.debug = debugHandler;
  }
  try {
    final results = chrono.parse(
        text, refDateOrCheckResult as DateTime, optionOrCheckResult);
    toBeSingleOnText(results, text);
    if (checkResult != null) {
      checkResult(results[0], text);
    }
  } catch (e, e_stack) {
    debugHandler.executeBufferedBlocks();
    // e_stack = e_stack.replace(new RegExp(r'[^\n]*at .*test_util.*\n'), ""); //пофиг на реплейс стактрейса?
    rethrow;
  }
}

testWithExpectedDate(Chrono chrono, String text, DateTime expectedDate) {
  testSingleCase(chrono, text, (ParsedResult result) {
    toBeDate(result.start, expectedDate);
  });
}

testUnexpectedResult(ChronoLike chrono, String text,
    [DateTime? refDate, ParsingOption? options]) {
  final debugHandler = new BufferedDebugHandler();
  options?.debug = debugHandler;
  try {
    final results = chrono.parse(text, refDate, options);
    expect(results.length, 0,reason: "result must be empty");
  } catch (e, e_stack) {
    debugHandler.executeBufferedBlocks();
    // e_stack = e_stack.replace(new RegExp(r'[^\n]*at .*test_util.*\n'), "");  //пофиг на реплейс стактрейса?
    rethrow;
  }
}

num measureMilliSec(void block()) {
  final startTime = DateTime.now().millisecondsSinceEpoch;
  block();
  final endTime = DateTime.now().millisecondsSinceEpoch;
  return endTime - startTime;
}
// --------------------------------------------------

// noinspection JSUnusedGlobalSymbols

toBeDate(resultOrComponent, DateTime date) {
  expect(resultOrComponent is DateTime, isTrue,
      reason: 'resultOrComponent must be datetime');
  final actualDate = resultOrComponent.date();
  final actualTime = actualDate.getTime();
  final expectedTime = date.millisecondsSinceEpoch;
  expect(actualTime, expectedTime,
      reason:
          "expected date must be $date, received: $actualDate $resultOrComponent");
}

toBeSingleOnText(List<ParsedResult> results, text) {
  expect(results.length, 1,
      reason:
          "result must have length 1, result from $text = ${results.map((result) => JsonEncoder().convert(result))}");
}

class ParsingReferenceDummy implements ParsingReference{
  @override
  DateTime instant;

  @override
  var timezone;

  ParsingReferenceDummy(this.instant,[this.timezone]);
}
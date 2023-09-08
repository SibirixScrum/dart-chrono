import "package:chrono/chrono.dart";
import "package:chrono/debugging.dart";
import "package:chrono/types.dart";
import "package:flutter_test/flutter_test.dart";

abstract class ChronoLike {
  List<ParsedResult> parse(String text,
      [dynamic /* ParsingReference | Date */ referenceDate,
      ParsingOption? option]);
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
  optionOrCheckResult = optionOrCheckResult is ParsingOption
      ? optionOrCheckResult
      : ParsingOptionDummy();
  if (optionOrCheckResult is ParsingOption) {
    optionOrCheckResult.debug = debugHandler;
  }
  try {
    // if(refDateOrCheckResult is ParsingReference){
    //   final timezone = refDateOrCheckResult.timezone;
    //   refDateOrCheckResult = refDateOrCheckResult.instant;
    //   if(timezone is int){
    //     if(timezone>0) {
    //       (refDateOrCheckResult as DateTime?)?.add(Duration(minutes: timezone));
    //     }else{
    //       (refDateOrCheckResult as DateTime?)?.subtract(Duration(minutes: timezone));
    //     }
    //   }
    // }
    final results = chrono.parse(text, refDateOrCheckResult,
        optionOrCheckResult as ParsingOption?);
    expectToBeSingleOnText(results, text);
    if (checkResult != null) {
      checkResult(results[0], text);
    }
  } on Exception {
    debugHandler.executeBufferedBlocks();
    // e_stack = e_stack.replace(new RegExp(r'[^\n]*at .*test_util.*\n'), ""); //пофиг на реплейс стактрейса?
    rethrow;
  }
}

testWithExpectedDate(Chrono chrono, String text, DateTime expectedDate) {
  testSingleCase(chrono, text, (ParsedResult result, String text) {
    expectToBeDate(result.start, expectedDate);
  });
}

testUnexpectedResult(Chrono chrono, String text,
    [DateTime? refDate, ParsingOption? options]) {
  final debugHandler = new BufferedDebugHandler();
  options?.debug = debugHandler;
  try {
    final results = chrono.parse(text, refDate, options);
    expect(results.length, 0, reason: "result must be empty");
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

expectToBeDate(ParsedComponents resultOrComponent, DateTime date) {
  // expect(re, isTrue,
  //     reason: 'resultOrComponent must be datetime');
  final actualDate = resultOrComponent.date();
  final actualTime = actualDate.millisecondsSinceEpoch;
  final expectedTime = date.millisecondsSinceEpoch;
  expect(actualTime, expectedTime,
      reason:
          "expected date must be $date, received: $actualDate $resultOrComponent");
}

expectToBeSingleOnText(List<ParsedResult> results, text) {
  expect(results.length, 1,
      reason:
          "result must have length 1, result from $text = ${results.map((result) => "text = ${result.text}"
              "start = ${result.start.date()}"
              "end = ${result.end?.date()}"
              "refDate = ${result.refDate}")}");
}

class ParsingReferenceDummy implements ParsingReference {
  @override
  DateTime instant;

  @override
  var timezone;

  ParsingReferenceDummy(this.instant, [this.timezone]);
}

class ParsingOptionDummy implements ParsingOption {
  @override
  var debug;

  @override
  bool? forwardDate;

  @override
  TimezoneAbbrMap? timezones;

  ParsingOptionDummy({this.forwardDate,this.debug,this.timezones});
}

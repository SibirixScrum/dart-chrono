/*

*/
import "package:chrono/chrono.dart";
import "package:chrono/ported/RegExpMatchArray.dart";

import "../../calculation/mergingCalculation.dart" show mergeDateTimeResult;
import "../../results.dart" show ParsingResult;
import "../abstractRefiners.dart" show MergingRefiner;

abstract class AbstractMergeDateTimeRefiner extends MergingRefiner {
  RegExp patternBetween();

  @override
  ParsingResult mergeResults(String textBetween, ParsingResult currentResult,
      ParsingResult nextResult, ParsingContext context) {
    final result = currentResult.start.isOnlyDate()
        ? mergeDateTimeResult(currentResult, nextResult)
        : mergeDateTimeResult(nextResult, currentResult);
    result.index = currentResult.index;
    result.text = currentResult.text + textBetween + nextResult.text;
    return result;
  }

  @override
  bool shouldMergeResults(String textBetween, ParsingResult currentResult,
      ParsingResult nextResult, ParsingContext context) {
    return (((currentResult.start.isOnlyDate() &&
                nextResult.start.isOnlyTime()) ||
            (nextResult.start.isOnlyDate() &&
                currentResult.start.isOnlyTime())) &&
        (patternBetween().exec(textBetween)?.matches.isNotEmpty ?? false));
  }

}

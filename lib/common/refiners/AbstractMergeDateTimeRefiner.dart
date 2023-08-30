/*

*/
import "../abstractRefiners.dart" show MergingRefiner;
import "../../results.dart" show ParsingResult;
import "../../calculation/mergingCalculation.dart" show mergeDateTimeResult;

class AbstractMergeDateTimeRefiner extends MergingRefiner {
  RegExp patternBetween();
  bool shouldMergeResults(String textBetween, ParsingResult currentResult,
      ParsingResult nextResult) {
    return (((currentResult.start.isOnlyDate() &&
                nextResult.start.isOnlyTime()) ||
            (nextResult.start.isOnlyDate() &&
                currentResult.start.isOnlyTime())) &&
        textBetween.match(this.patternBetween()) != null);
  }

  ParsingResult mergeResults(String textBetween, ParsingResult currentResult,
      ParsingResult nextResult) {
    final result = currentResult.start.isOnlyDate()
        ? mergeDateTimeResult(currentResult, nextResult)
        : mergeDateTimeResult(nextResult, currentResult);
    result.index = currentResult.index;
    result.text = currentResult.text + textBetween + nextResult.text;
    return result;
  }
}

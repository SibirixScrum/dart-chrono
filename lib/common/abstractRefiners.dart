import "../chrono.dart" show ParsingContext, Refiner;
import "../results.dart" show ParsingResult;

/**
 * A special type of [Refiner] to filter the results
 */
abstract class Filter implements Refiner {
  bool isValid(ParsingContext context, ParsingResult result);

  List<ParsingResult> refine(
      ParsingContext context, List<ParsingResult> results) {
    return results.where((r) => isValid(context, r)).toList();
  }
}

/**
 * A special type of [Refiner] to merge consecutive results
 */
abstract class MergingRefiner implements Refiner {
  bool shouldMergeResults(String textBetween, ParsingResult currentResult,
      ParsingResult nextResult, ParsingContext context);

  ParsingResult mergeResults(String textBetween, ParsingResult currentResult,
      ParsingResult nextResult, ParsingContext context);

  List<ParsingResult> refine(
      ParsingContext context, List<ParsingResult> results) {
    if (results.length < 2) {
      return results;
    }
    final List<ParsingResult> mergedResults = [];
    var curResult = results[0];
    var nextResult = null;
    for (var i = 1; i < results.length; i++) {
      nextResult = results[i];
      final textBetween = context.text
          .substring(curResult.index + curResult.text.length, nextResult.index);
      if (!this
          .shouldMergeResults(textBetween, curResult, nextResult, context)) {
        mergedResults.add(curResult);
        curResult = nextResult;
      } else {
        final left = curResult;
        final right = nextResult;
        final mergedResult =
            this.mergeResults(textBetween, left, right, context);
        context.debug(() {
          print(
              '''MergingRefiner merged ${left} and ${right} into ${mergedResult}''');
        });
        curResult = mergedResult;
      }
    }
    if (curResult != null) {
      mergedResults.add(curResult);
    }
    return mergedResults;
  }
}

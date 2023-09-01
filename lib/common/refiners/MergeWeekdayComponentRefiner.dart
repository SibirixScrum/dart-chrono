/*
  
*/
import "package:chrono/chrono.dart";
import "package:chrono/ported/RegExpMatchArray.dart";
import "package:chrono/types.dart";

import "../../results.dart" show ParsingResult;
import "../abstractRefiners.dart" show MergingRefiner;

/**
 * Merge weekday component into more completed data
 * - [Sunday] [12/7/2014] => [Sunday 12/7/2014]
 * - [Tuesday], [January 13, 2012] => [Sunday 12/7/2014]
 */
class MergeWeekdayComponentRefiner extends MergingRefiner {
  @override
  ParsingResult mergeResults(String textBetween, ParsingResult currentResult,
      ParsingResult nextResult, ParsingContext context) {
    final newResult = nextResult.clone();
    newResult.index = currentResult.index;
    newResult.text = currentResult.text + textBetween + newResult.text;
    newResult.start
        .assign("weekday", currentResult.start.get(Component.weekday));
    if (newResult.end) {
      newResult.end
          .assign("weekday", currentResult.start.get(Component.weekday));
    }
    return newResult;
  }

  @override
  bool shouldMergeResults(String textBetween, ParsingResult currentResult,
      ParsingResult nextResult, ParsingContext context) {
    final weekdayThenNormalDate =
        currentResult.start.isOnlyWeekdayComponent() &&
            !currentResult.start.isCertain(Component.hour) &&
            nextResult.start.isCertain(Component.day);
    return weekdayThenNormalDate &&
        (new RegExp(r'^,?\s*$').exec(textBetween)?.matches.isNotEmpty ?? false);
  }
// ParsingResult mergeResults(String textBetween, ParsingResult currentResult,
//     ParsingResult nextResult) {
//   final newResult = nextResult.clone();
//   newResult.index = currentResult.index;
//   newResult.text = currentResult.text + textBetween + newResult.text;
//   newResult.start.assign("weekday", currentResult.start.get("weekday"));
//   if (newResult.end) {
//     newResult.end.assign("weekday", currentResult.start.get("weekday"));
//   }
//   return newResult;
// }
//
// bool shouldMergeResults(String textBetween, ParsingResult currentResult,
//     ParsingResult nextResult) {
//   final weekdayThenNormalDate =
//       currentResult.start.isOnlyWeekdayComponent() &&
//           !currentResult.start.isCertain("hour") &&
//           nextResult.start.isCertain("day");
//   return weekdayThenNormalDate &&
//       textBetween.match(new RegExp(r'^,?\s*$')) != null;
// }
}

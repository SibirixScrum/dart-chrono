/*

*/
import "package:chrono/chrono.dart";
import "package:chrono/ported/RegExpMatchArray.dart";
import "package:chrono/types.dart";

import "../../calculation/mergingCalculation.dart" show mergeDateTimeResult;
import "../../results.dart" show ParsingResult;
import "../abstractRefiners.dart" show MergingRefiner;

abstract class AbstractMergeDateTimeRefiner extends MergingRefiner {
  RegExp patternBetween();

  @override
  ParsingResult mergeResults(String textBetween, ParsingResult currentResult,
      ParsingResult nextResult, ParsingContext context) {
    late ParsingResult result;
    if(currentResult.start.isOnlyDate() &&
        nextResult.start.isOnlyTime()){
      result = mergeDateTimeResult(currentResult, nextResult);
    }else if(
    nextResult.start.isOnlyDate() &&
        currentResult.start.isOnlyTime()
    ){
      result = mergeDateTimeResult(nextResult, currentResult);
    } else if(
    currentResult.start.isOnlyCasualRef() &&
        !nextResult.start.isOnlyCasualRef()
    ){
      result = mergeDateTimeResult(currentResult, nextResult);
    }else if(
    !currentResult.start.isOnlyCasualRef() &&
        nextResult.start.isOnlyCasualRef()
    ){
      if(currentResult.end!=null){
        if(currentResult.end!.isCertain(Component.meridiem) &&
        nextResult.start.get(Component.casualReference)! == CasualReference.morning.index
        ){
          currentResult.end!.assign(Component.meridiem, Meridiem.AM.index);
          final hour = currentResult.end!.get(Component.hour);
          if(hour != null && hour >= 12){
            if(currentResult.end!.isCertain(Component.hour)) {
              currentResult.end!.assign(Component.hour, hour - 12);
            }else{
              currentResult.end!.imply(Component.hour, hour - 12);
            }
          }
        }
      }
      result = mergeDateTimeResult(nextResult, currentResult);
    }
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
                currentResult.start.isOnlyTime()) ||
            (currentResult.start.isOnlyCasualRef() &&
                !nextResult.start.isOnlyCasualRef()) ||
            (!currentResult.start.isOnlyCasualRef() &&
                nextResult.start.isOnlyCasualRef())) &&
        (patternBetween().exec(textBetween)?.matches.isNotEmpty ?? false));
  }

// bool shouldMergeResults(String textBetween, ParsingResult currentResult,
//     ParsingResult nextResult) {
//   return (((currentResult.start.isOnlyDate() &&
//               nextResult.start.isOnlyTime()) ||
//           (nextResult.start.isOnlyDate() &&
//               currentResult.start.isOnlyTime())) &&
//       textBetween.match(this.patternBetween()) != null);
// }
//
// ParsingResult mergeResults(String textBetween, ParsingResult currentResult,
//     ParsingResult nextResult) {
//   final result = currentResult.start.isOnlyDate()
//       ? mergeDateTimeResult(currentResult, nextResult)
//       : mergeDateTimeResult(nextResult, currentResult);
//   result.index = currentResult.index;
//   result.text = currentResult.text + textBetween + nextResult.text;
//   return result;
// }
}

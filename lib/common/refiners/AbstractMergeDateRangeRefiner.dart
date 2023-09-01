/*
  
*/
import "package:chrono/chrono.dart";
import "package:chrono/ported/RegExpMatchArray.dart";
import "package:chrono/types.dart";

import "../../results.dart" show ParsingResult;
import "../abstractRefiners.dart" show MergingRefiner;

abstract class AbstractMergeDateRangeRefiner extends MergingRefiner {
  RegExp patternBetween();

  @override
  ParsingResult mergeResults(String textBetween, ParsingResult currentResult, ParsingResult nextResult, ParsingContext context) {
     if (!currentResult.start.isOnlyWeekdayComponent() &&
         !nextResult.start.isOnlyWeekdayComponent()) {
       nextResult.start.getCertainComponents().forEach((key) {
         if (!currentResult.start.isCertain(key)) {
           currentResult.start.imply(key, nextResult.start.get(key)!);
         }
       });
       currentResult.start.getCertainComponents().forEach((key) {
         if (!nextResult.start.isCertain(key)) {
           nextResult.start.imply(key, currentResult.start.get(key)!);
         }
       });
     }
     if (currentResult.start.date().getTime() > nextResult.start.date().getTime()) {
       var fromMoment = currentResult.start.dayjs();
       var toMoment = nextResult.start.dayjs();
       if (nextResult.start.isOnlyWeekdayComponent() &&
           toMoment.add(7, "days").isAfter(fromMoment)) {
         toMoment = toMoment.add(7, "days");
         nextResult.start.imply(Component.day, toMoment.date());
         nextResult.start.imply(Component.month, toMoment.month() + 1);
         nextResult.start.imply(Component.year, toMoment.year());
       } else if (currentResult.start.isOnlyWeekdayComponent() &&
           fromMoment.add(-7, "days").isBefore(toMoment)) {
         fromMoment = fromMoment.add(-7, "days");
         currentResult.start.imply(Component.day, fromMoment.date());
         currentResult.start.imply(Component.month, fromMoment.month() + 1);
         currentResult.start.imply(Component.year, fromMoment.year());
       } else if (nextResult.start.isDateWithUnknownYear() &&
           toMoment.add(1, "years").isAfter(fromMoment)) {
         toMoment = toMoment.add(1, "years");
         nextResult.start.imply(Component.year, toMoment.year());
       } else if (currentResult.start.isDateWithUnknownYear() &&
           fromMoment.add(-1, "years").isBefore(toMoment)) {
         fromMoment = fromMoment.add(-1, "years");
         currentResult.start.imply(Component.year, fromMoment.year());
       } else {
        final temp = nextResult;
        nextResult = currentResult;
        currentResult = temp;
       }
     }
     final result = currentResult.clone();
     result.start = currentResult.start;
     result.end = nextResult.start;
     result.index = currentResult.index<nextResult.index ? currentResult.index : nextResult.index;
     if (currentResult.index < nextResult.index) {
       result.text = currentResult.text + textBetween + nextResult.text;
     } else {
       result.text = nextResult.text + textBetween + currentResult.text;
     }
     return result;
  }

  @override
  bool shouldMergeResults(String textBetween, ParsingResult currentResult, ParsingResult nextResult, ParsingContext context) {
     return currentResult.end == null && nextResult.end == null &&
         (this.patternBetween().exec(textBetween)?.matches .isNotEmpty ?? false);
  }

  // bool shouldMergeResults(textBetween, currentResult, nextResult) {
  //   return !currentResult.end && !nextResult.end &&
  //       textBetween.match(this.patternBetween()) != null;
  // }
  //
  // ParsingResult mergeResults(textBetween, fromResult, toResult) {
  //   if (!fromResult.start.isOnlyWeekdayComponent() &&
  //       !toResult.start.isOnlyWeekdayComponent()) {
  //     toResult.start.getCertainComponents().forEach((key) {
  //       if (!fromResult.start.isCertain(key)) {
  //         fromResult.start.imply(key, toResult.start.get(key));
  //       }
  //     });
  //     fromResult.start.getCertainComponents().forEach((key) {
  //       if (!toResult.start.isCertain(key)) {
  //         toResult.start.imply(key, fromResult.start.get(key));
  //       }
  //     });
  //   }
  //   if (fromResult.start.date().getTime() > toResult.start.date().getTime()) {
  //     var fromMoment = fromResult.start.dayjs();
  //     var toMoment = toResult.start.dayjs();
  //     if (toResult.start.isOnlyWeekdayComponent() &&
  //         toMoment.add(7, "days").isAfter(fromMoment)) {
  //       toMoment = toMoment.add(7, "days");
  //       toResult.start.imply("day", toMoment.date());
  //       toResult.start.imply("month", toMoment.month() + 1);
  //       toResult.start.imply("year", toMoment.year());
  //     } else if (fromResult.start.isOnlyWeekdayComponent() &&
  //         fromMoment.add(-7, "days").isBefore(toMoment)) {
  //       fromMoment = fromMoment.add(-7, "days");
  //       fromResult.start.imply("day", fromMoment.date());
  //       fromResult.start.imply("month", fromMoment.month() + 1);
  //       fromResult.start.imply("year", fromMoment.year());
  //     } else if (toResult.start.isDateWithUnknownYear() &&
  //         toMoment.add(1, "years").isAfter(fromMoment)) {
  //       toMoment = toMoment.add(1, "years");
  //       toResult.start.imply("year", toMoment.year());
  //     } else if (fromResult.start.isDateWithUnknownYear() &&
  //         fromMoment.add(-1, "years").isBefore(toMoment)) {
  //       fromMoment = fromMoment.add(-1, "years");
  //       fromResult.start.imply("year", fromMoment.year());
  //     } else {
  //       [ toResult, fromResult ] = [ fromResult, toResult];
  //     }
  //   }
  //   final result = fromResult.clone();
  //   result.start = fromResult.start;
  //   result.end = toResult.start;
  //   result.index = Math.min(fromResult.index, toResult.index);
  //   if (fromResult.index < toResult.index) {
  //     result.text = fromResult.text + textBetween + toResult.text;
  //   } else {
  //     result.text = toResult.text + textBetween + fromResult.text;
  //   }
  //   return result;
  // }
}
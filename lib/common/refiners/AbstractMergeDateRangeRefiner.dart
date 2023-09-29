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
  ParsingResult mergeResults(String textBetween, ParsingResult currentResult,
      ParsingResult nextResult, ParsingContext context) {
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
    if (currentResult.start.date().millisecondsSinceEpoch >
        nextResult.start.date().millisecondsSinceEpoch) {
      var fromMoment = currentResult.start.date();
      var toMoment = nextResult.start.date();
      if (nextResult.start.isOnlyWeekdayComponent() &&
          toMoment.add(Duration(days: 7)).isAfter(fromMoment)) {
        toMoment = toMoment.add(Duration(days: 7));
        nextResult.start.imply(Component.day, toMoment.day);
        nextResult.start.imply(Component.month, toMoment.month );
        nextResult.start.imply(Component.year, toMoment.year);
      } else if (currentResult.start.isOnlyWeekdayComponent() &&
          fromMoment.subtract(Duration(days: 7)).isBefore(toMoment)) {
        fromMoment = fromMoment.subtract(Duration(days: 7));
        currentResult.start.imply(Component.day, fromMoment.day);
        currentResult.start.imply(Component.month, fromMoment.month);
        currentResult.start.imply(Component.year, fromMoment.year);
      } else if (nextResult.start.isDateWithUnknownYear() &&
          toMoment.copyWith(year: toMoment.year + 1).isAfter(fromMoment)) {
        toMoment = toMoment.copyWith(year: toMoment.year + 1);
        nextResult.start.imply(Component.year, toMoment.year);
      } else if (currentResult.start.isDateWithUnknownYear() &&
          toMoment.copyWith(year: toMoment.year - 1).isBefore(toMoment)) {
        fromMoment = toMoment.copyWith(year: toMoment.year - 1);
        currentResult.start.imply(Component.year, fromMoment.year);
      } else {
        final temp = nextResult;
        nextResult = currentResult;
        currentResult = temp;
      }
    }
    final result = currentResult.clone();
    result.start = currentResult.start;
    result.end = nextResult.start;
    result.index = currentResult.index < nextResult.index
        ? currentResult.index
        : nextResult.index;
    if (currentResult.index < nextResult.index) {
      result.text = currentResult.text + textBetween + nextResult.text;
    } else {
      result.text = nextResult.text + textBetween + currentResult.text;
    }
    return result;
  }

  @override
  bool shouldMergeResults(String textBetween, ParsingResult currentResult,
      ParsingResult nextResult, ParsingContext context) {
    return currentResult.end == null &&
        nextResult.end == null &&
        (patternBetween().exec(textBetween)?.matches.isNotEmpty ?? false);
  }
}

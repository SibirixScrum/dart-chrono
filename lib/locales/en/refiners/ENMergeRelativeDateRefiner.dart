import "package:chrono/chrono.dart";
import "package:chrono/locales/en/constants.dart";
import "package:chrono/ported/RegExpMatchArray.dart";
import "package:chrono/types.dart";
import "package:chrono/utils/timeunits.dart";

import "../../../common/abstractRefiners.dart" show MergingRefiner;
import "../../../results.dart"
    show ParsingComponents, ParsingResult, ReferenceWithTimezone;

bool hasImpliedEarlierReferenceDate(ParsingResult result) {
  return result.text
      .match(new RegExp(r'\s+(before|from)$', caseSensitive: false));
}

bool hasImpliedLaterReferenceDate(ParsingResult result) {
  return result.text
      .match(new RegExp(r'\s+(after|since)$', caseSensitive: false));
}

/**
 * Merges an absolute date with a relative date.
 * - 2 weeks before 2020-02-13
 * - 2 days after next Friday
 */
class ENMergeRelativeDateRefiner extends MergingRefiner {
  RegExp patternBetween() {
    return new RegExp(r'^\s*$', caseSensitive: false);
  }

  @override
  ParsingResult mergeResults(String textBetween, ParsingResult currentResult,
      ParsingResult nextResult, ParsingContext context) {
    var timeUnits = parseTimeUnits(currentResult.text);
    if (hasImpliedEarlierReferenceDate(currentResult)) {
      timeUnits = reverseTimeUnits(timeUnits);
    }
    final components = ParsingComponents.createRelativeFromReference(
        new ReferenceWithTimezone(nextResult.start.date()), timeUnits);
    return new ParsingResult(
        nextResult.reference,
        currentResult.index,
        '''${currentResult.text}${textBetween}${nextResult.text}''',
        components);
  }

  @override
  bool shouldMergeResults(String textBetween, ParsingResult currentResult,
      ParsingResult nextResult, ParsingContext context) {
    // Dates need to be next to each other to get merged
    if (!textBetween.match(this.patternBetween())) {
      return false;
    }
    // Check if any relative tokens were swallowed by the first date.

    // E.g. [<relative_date1> from] [<date2>]
    if (!hasImpliedEarlierReferenceDate(currentResult) &&
        !hasImpliedLaterReferenceDate(currentResult)) {
      return false;
    }
    // make sure that <date2> implies an absolute date
    return nextResult.start.get(Component.day) != null &&
        nextResult.start.get(Component.month) != null &&
        nextResult.start.get(Component.year) != null;
  }

// bool shouldMergeResults(String textBetween, ParsingResult currentResult,
//     ParsingResult nextResult) {
//   // Dates need to be next to each other to get merged
//   if (!textBetween.match(this.patternBetween())) {
//     return false;
//   }
//   // Check if any relative tokens were swallowed by the first date.
//
//   // E.g. [<relative_date1> from] [<date2>]
//   if (!hasImpliedEarlierReferenceDate(currentResult) &&
//       !hasImpliedLaterReferenceDate(currentResult)) {
//     return false;
//   }
//   // make sure that <date2> implies an absolute date
//   return !!nextResult.start.get("day") &&
//       !!nextResult.start.get("month") &&
//       !!nextResult.start.get("year");
// }
//
// ParsingResult mergeResults(String textBetween, ParsingResult currentResult,
//     ParsingResult nextResult) {
//   var timeUnits = parseTimeUnits(currentResult.text);
//   if (hasImpliedEarlierReferenceDate(currentResult)) {
//     timeUnits = reverseTimeUnits(timeUnits);
//   }
//   final components = ParsingComponents.createRelativeFromReference(
//       new ReferenceWithTimezone(nextResult.start.date()), timeUnits);
//   return new ParsingResult(
//       nextResult.reference,
//       currentResult.index,
//       '''${ currentResult . text}${ textBetween}${ nextResult . text}''',
//       components);
// }
}

import "../../results.dart" show ParsingComponents, ReferenceWithTimezone;
import "../../types.dart" show Component, Weekday;
import "../../utils/timeunits.dart" show addImpliedTimeUnits;

/**
 * Returns the parsing components at the weekday (considering the modifier). The time and timezone is assume to be
 * similar to the reference.
 *
 *
 *
 */
ParsingComponents createParsingComponentsAtWeekday(
    ReferenceWithTimezone reference, Weekday weekday,
    [dynamic /* | | */ modifier]) {
  final refDate = reference.getDateWithAdjustedTimezone();
  final daysToWeekday = getDaysToWeekday(refDate, weekday, modifier);
  var components = new ParsingComponents(reference, null);
  components = addImpliedTimeUnits(components, {"day": daysToWeekday.toInt()});
  components.assign(Component.weekday, weekday.index);
  return components;
}

/**
 * Returns number of days from refDate to the weekday. The refDate date and timezone information is used.
 *
 *
 *
 */
num getDaysToWeekday(DateTime refDate, Weekday weekday,
    [dynamic /* | | */ modifier]) {
  final refWeekday = refDate.weekday;
  switch (modifier) {
    case "this":
      return getDaysForwardToWeekday(refDate, weekday);
    case "last":
      return getBackwardDaysToWeekday(refDate, weekday);
    case "next":
      // From Sunday, the next Sunday is 7 days later.

      // Otherwise, next Mon is 1 days later, next Tues is 2 days later, and so on..., (return enum value)
      if (refWeekday == Weekday.SUNDAY) {
        return weekday == Weekday.SUNDAY ? 7 : weekday.index;
      }
      // From Saturday, the next Saturday is 7 days later, the next Sunday is 8-days later.

      // Otherwise, next Mon is (1 + 1) days later, next Tues is (1 + 2) days later, and so on...,

      // (return, 2 + [enum value] days)
      if (refWeekday == Weekday.SATURDAY) {
        if (weekday == Weekday.SATURDAY) return 7;
        if (weekday == Weekday.SUNDAY) return 8;
        return 1 + weekday.index;
      }
      // From weekdays, next Mon is the following week's Mon, next Tues the following week's Tues, and so on...

      // If the week's weekday already passed (weekday < refWeekday), we simply count forward to next week

      // (similar to 'this'). Otherwise, count forward to this week, then add another 7 days.
      if (weekday.index + 1 < refWeekday && weekday != Weekday.SUNDAY) {
        return getDaysForwardToWeekday(refDate, weekday);
      } else {
        return getDaysForwardToWeekday(refDate, weekday) + 7;
      }
  }
  return getDaysToWeekdayClosest(refDate, weekday);
}

num getDaysToWeekdayClosest(DateTime refDate, Weekday weekday) {
  final backward = getBackwardDaysToWeekday(refDate, weekday);
  final forward = getDaysForwardToWeekday(refDate, weekday);
  return forward < -backward ? forward : backward;
}

num getDaysForwardToWeekday(DateTime refDate, Weekday weekday) {
  final refWeekday = refDate.weekday;
  var forwardCount = weekday.index - refWeekday;
  if (forwardCount < 0) {
    forwardCount += 7;
  }
  return forwardCount;
}

num getBackwardDaysToWeekday(DateTime refDate, Weekday weekday) {
  final refWeekday = refDate.weekday;
  var backwardCount = weekday.index - refWeekday;
  if (backwardCount >= 0) {
    backwardCount -= 7;
  }
  return backwardCount;
}

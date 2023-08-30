import "../results.dart" show ParsingComponents, ReferenceWithTimezone;
import "../utils/dayjs.dart"
    show
        assignSimilarDate,
        assignSimilarTime,
        implySimilarDate,
        implySimilarTime,
        implyTheNextDay;
import "../types.dart" show Component, Meridiem;

ParsingComponents now(ReferenceWithTimezone reference) {
  final targetDate = dayjs(reference.instant);
  final component = new ParsingComponents(reference, {});
  assignSimilarDate(component, targetDate);
  assignSimilarTime(component, targetDate);
  if (!identical(reference.timezoneOffset, null)) {
    component.assign(Component.timezoneOffset, targetDate.utcOffset());
  }
  return component;
}

ParsingComponents today(ReferenceWithTimezone reference) {
  final targetDate = dayjs(reference.instant);
  final component = new ParsingComponents(reference, {});
  assignSimilarDate(component, targetDate);
  implySimilarTime(component, targetDate);
  return component;
}

/**
 * The previous day. Imply the same time.
 */
ParsingComponents yesterday(ReferenceWithTimezone reference) {
  return theDayBefore(reference, 1);
}

ParsingComponents theDayBefore(ReferenceWithTimezone reference, num numDay) {
  return theDayAfter(reference, -numDay);
}

/**
 * The following day with dayjs.assignTheNextDay()
 */
ParsingComponents tomorrow(ReferenceWithTimezone reference) {
  return theDayAfter(reference, 1);
}

ParsingComponents theDayAfter(ReferenceWithTimezone reference, num nDays) {
  var targetDate = dayjs(reference.instant);
  final component = new ParsingComponents(reference, {});
  targetDate = targetDate.add(nDays, "day");
  assignSimilarDate(component, targetDate);
  implySimilarTime(component, targetDate);
  return component;
}

ParsingComponents tonight(ReferenceWithTimezone reference, [implyHour = 22]) {
  final targetDate = dayjs(reference.instant);
  final component = new ParsingComponents(reference, {});
  component.imply(Component.hour, implyHour);
  component.imply(Component.meridiem, Meridiem.PM.index);
  assignSimilarDate(component, targetDate);
  return component;
}

ParsingComponents lastNight(ReferenceWithTimezone reference, [implyHour = 0]) {
  var targetDate = dayjs(reference.instant);
  final component = new ParsingComponents(reference, {});
  if (targetDate.hour() < 6) {
    targetDate = targetDate.add(-1, "day");
  }
  assignSimilarDate(component, targetDate);
  component.imply(Component.hour, implyHour);
  return component;
}

ParsingComponents evening(ReferenceWithTimezone reference, [implyHour = 20]) {
  final component = new ParsingComponents(reference, {});
  component.imply(Component.meridiem, Meridiem.PM.index);
  component.imply(Component.hour, implyHour);
  return component;
}

ParsingComponents yesterdayEvening(ReferenceWithTimezone reference,
    [implyHour = 20]) {
  var targetDate = dayjs(reference.instant);
  final component = new ParsingComponents(reference, {});
  targetDate = targetDate.add(-1, "day");
  assignSimilarDate(component, targetDate);
  component.imply(Component.hour, implyHour);
  component.imply(Component.meridiem, Meridiem.PM.index);
  return component;
}

ParsingComponents midnight(ReferenceWithTimezone reference) {
  final component = new ParsingComponents(reference, {});
  final targetDate = dayjs(reference.instant);
  if (targetDate.hour() > 2) {
    // Unless it's very early morning (0~2AM), we assume the midnight is the coming midnight.

    // Thus, increasing the day by 1.
    implyTheNextDay(component, targetDate);
  }
  component.assign(Component.hour, 0);
  component.imply(Component.minute, 0);
  component.imply(Component.second, 0);
  component.imply(Component.millisecond, 0);
  return component;
}

ParsingComponents morning(ReferenceWithTimezone reference, [implyHour = 6]) {
  final component = new ParsingComponents(reference, {});
  component.imply(Component.meridiem, Meridiem.AM.index);
  component.imply(Component.hour, implyHour);
  component.imply(Component.minute, 0);
  component.imply(Component.second, 0);
  component.imply(Component.millisecond, 0);
  return component;
}

ParsingComponents afternoon(ReferenceWithTimezone reference, [implyHour = 15]) {
  final component = new ParsingComponents(reference, {});
  component.imply(Component.meridiem, Meridiem.PM.index);
  component.imply(Component.hour, implyHour);
  component.imply(Component.minute, 0);
  component.imply(Component.second, 0);
  component.imply(Component.millisecond, 0);
  return component;
}

ParsingComponents noon(ReferenceWithTimezone reference) {
  final component = new ParsingComponents(reference, {});
  component.imply(Component.meridiem, Meridiem.AM.index);
  component.imply(Component.hour, 12);
  component.imply(Component.minute, 0);
  component.imply(Component.second, 0);
  component.imply(Component.millisecond, 0);
  return component;
}

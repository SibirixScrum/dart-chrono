import "../results.dart" show ParsingComponents;
import "../types.dart" show Component, Meridiem;

assignTheNextDay(ParsingComponents component, dayjs.Dayjs targetDayJs) {
  targetDayJs = targetDayJs.add(1, "day");
  assignSimilarDate(component, targetDayJs);
  implySimilarTime(component, targetDayJs);
}

implyTheNextDay(ParsingComponents component, dayjs.Dayjs targetDayJs) {
  targetDayJs = targetDayJs.add(1, "day");
  implySimilarDate(component, targetDayJs);
  implySimilarTime(component, targetDayJs);
}

assignSimilarDate(ParsingComponents component, dayjs.Dayjs targetDayJs) {
  component.assign(Component.day, targetDayJs.date());
  component.assign(Component.month, targetDayJs.month() + 1);
  component.assign(Component.year, targetDayJs.year());
}

assignSimilarTime(ParsingComponents component, dayjs.Dayjs targetDayJs) {
  component.assign(Component.hour, targetDayJs.hour());
  component.assign(Component.minute, targetDayJs.minute());
  component.assign(Component.second, targetDayJs.second());
  component.assign(Component.millisecond, targetDayJs.millisecond());
  if (component.get(Component.hour) < 12) {
    component.assign(Component.meridiem, Meridiem.AM.index);
  } else {
    component.assign(Component.meridiem, Meridiem.PM.index);
  }
}

implySimilarDate(ParsingComponents component, dayjs.Dayjs targetDayJs) {
  component.imply(Component.day, targetDayJs.date());
  component.imply(Component.month, targetDayJs.month() + 1);
  component.imply(Component.year, targetDayJs.year());
}

implySimilarTime(ParsingComponents component, dayjs.Dayjs targetDayJs) {
  component.imply(Component.hour, targetDayJs.hour());
  component.imply(Component.minute, targetDayJs.minute());
  component.imply(Component.second, targetDayJs.second());
  component.imply(Component.millisecond, targetDayJs.millisecond());
}

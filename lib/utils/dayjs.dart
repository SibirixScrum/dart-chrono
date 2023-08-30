import "../results.dart" show ParsingComponents;
import "../types.dart" show Meridiem;

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
  component.assign("day", targetDayJs.date());
  component.assign("month", targetDayJs.month() + 1);
  component.assign("year", targetDayJs.year());
}

assignSimilarTime(ParsingComponents component, dayjs.Dayjs targetDayJs) {
  component.assign("hour", targetDayJs.hour());
  component.assign("minute", targetDayJs.minute());
  component.assign("second", targetDayJs.second());
  component.assign("millisecond", targetDayJs.millisecond());
  if (component.get("hour") < 12) {
    component.assign("meridiem", Meridiem.AM);
  } else {
    component.assign("meridiem", Meridiem.PM);
  }
}

implySimilarDate(ParsingComponents component, dayjs.Dayjs targetDayJs) {
  component.imply("day", targetDayJs.date());
  component.imply("month", targetDayJs.month() + 1);
  component.imply("year", targetDayJs.year());
}

implySimilarTime(ParsingComponents component, dayjs.Dayjs targetDayJs) {
  component.imply("hour", targetDayJs.hour());
  component.imply("minute", targetDayJs.minute());
  component.imply("second", targetDayJs.second());
  component.imply("millisecond", targetDayJs.millisecond());
}

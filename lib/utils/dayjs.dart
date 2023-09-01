import "../results.dart" show ParsingComponents;
import "../types.dart" show Component, Meridiem;

assignTheNextDay(ParsingComponents component, DateTime targetDayJs) {
  targetDayJs = targetDayJs.add(Duration(days: 1));
  assignSimilarDate(component, targetDayJs);
  implySimilarTime(component, targetDayJs);
}

implyTheNextDay(ParsingComponents component, DateTime targetDayJs) {
  targetDayJs = targetDayJs.add(Duration(days: 1));
  implySimilarDate(component, targetDayJs);
  implySimilarTime(component, targetDayJs);
}

assignSimilarDate(ParsingComponents component, DateTime targetDayJs) {
  component.assign(Component.day, targetDayJs.day);
  component.assign(Component.month, targetDayJs.month + 1);
  component.assign(Component.year, targetDayJs.year);
}

assignSimilarTime(ParsingComponents component, DateTime targetDayJs) {
  component.assign(Component.hour, targetDayJs.hour);
  component.assign(Component.minute, targetDayJs.minute);
  component.assign(Component.second, targetDayJs.second);
  component.assign(Component.millisecond, targetDayJs.millisecond);
  if (component.get(Component.hour)!.toInt() < 12) {
    component.assign(Component.meridiem, Meridiem.AM.index);
  } else {
    component.assign(Component.meridiem, Meridiem.PM.index);
  }
}

implySimilarDate(ParsingComponents component, DateTime targetDayJs) {
  component.imply(Component.day, targetDayJs.day);
  component.imply(Component.month, targetDayJs.month + 1);
  component.imply(Component.year, targetDayJs.year);
}

implySimilarTime(ParsingComponents component, DateTime targetDayJs) {
  component.imply(Component.hour, targetDayJs.hour);
  component.imply(Component.minute, targetDayJs.minute);
  component.imply(Component.second, targetDayJs.second);
  component.imply(Component.millisecond, targetDayJs.millisecond);
}

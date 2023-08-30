import "package:dayjs.dart" show OpUnitType, QUnitType;


import "../results.dart" show ParsingComponents;

/// key is OpUnitType | QUnitType | null
typedef TimeUnits = Map<dynamic, num>;

TimeUnits reverseTimeUnits(TimeUnits timeUnits) {
  final reversed = {};
  for (final key in timeUnits.keys) {
    // noinspection JSUnfilteredForInLoop
    reversed[key] = -(timeUnits[key])!;
  }
  return reversed as TimeUnits;
}

ParsingComponents addImpliedTimeUnits(
    ParsingComponents components, TimeUnits timeUnits) {
  final output = components.clone();
  var date = components.dayjs();
  for (final key in timeUnits.keys) {
    // noinspection JSUnfilteredForInLoop,TypeScriptValidateTypes
    date = date.add(
      timeUnits[key],
    );
  }
  if (timeUnits.keys.contains("day") ||
      timeUnits.keys.contains("d") ||
      timeUnits.keys.contains("week") ||
      timeUnits.keys.contains("month") ||
      timeUnits.keys.contains("year")) {
    output.imply("day", date.date());
    output.imply("month", date.month() + 1);
    output.imply("year", date.year());
  }
  if (timeUnits.keys.contains("second") ||
      timeUnits.keys.contains("minute") ||
      timeUnits.keys.contains("hour")) {
    output.imply("second", date.second());
    output.imply("minute", date.minute());
    output.imply("hour", date.hour());
  }
  return output;
}

import "package:chrono/types.dart";
import "../results.dart" show ParsingComponents;

/// key is OpUnitType | QUnitType | null
typedef TimeUnits = Map<String, num>;

TimeUnits reverseTimeUnits(TimeUnits timeUnits) {
  final Map<String,num> reversed = {};
  for (final key in timeUnits.keys) {
    // noinspection JSUnfilteredForInLoop
    reversed[key] = -(timeUnits[key])!;
  }
  return reversed;
}

ParsingComponents addImpliedTimeUnits(
    ParsingComponents components, TimeUnits timeUnits) {
  final output = components.clone();
  var date = components.date();
  date = date.copyWith(
    year: date.year + (timeUnits["year"]?.toInt() ?? 0),
    month: date.month + (timeUnits["month"]?.toInt() ?? 0),
  );
  date = date.add(Duration(
    days: (timeUnits["day"]?.toInt() ?? 0),
    hours: (timeUnits["hour"]?.toInt() ?? 0),
    minutes: (timeUnits["minute"]?.toInt() ?? 0),
    seconds: (timeUnits["second"]?.toInt() ?? 0),
    milliseconds: (timeUnits["millisecond"]?.toInt() ?? 0),
  ));
  // for (final key in timeUnits.keys) {
  //   // noinspection JSUnfilteredForInLoop,TypeScriptValidateTypes
  //   date = date.add(
  //     timeUnits[key],
  //   );
  // }
  if (timeUnits.keys.contains("day") ||
      timeUnits.keys.contains("d") ||
      timeUnits.keys.contains("week") ||
      timeUnits.keys.contains("month") ||
      timeUnits.keys.contains("year")) {
    output.imply(Component.day, date.day);
    output.imply(Component.month, date.month );
    output.imply(Component.year, date.year);
  }
  if (timeUnits.keys.contains("second") ||
      timeUnits.keys.contains("minute") ||
      timeUnits.keys.contains("hour")) {
    output.imply(Component.second, date.second);
    output.imply(Component.minute, date.minute);
    output.imply(Component.hour, date.hour);
  }
  return output;
}

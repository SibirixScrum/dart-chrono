import "package:chrono/ported/DateTime.dart";

import "timezone.dart" show toTimezoneOffset;
import "types.dart"
    show Component, ParsedComponents, ParsedResult, ParsingReference;
import "utils/dayjs.dart"
    show assignSimilarDate, assignSimilarTime, implySimilarTime;

// dayjs.extend //todo не знаю, че это
// (quarterOfYear );
class Undefined{
  const Undefined();
}

class ReferenceWithTimezone {
  late DateTime instant;

  dynamic /*num? || Undefined*/ timezoneOffset;

  ReferenceWithTimezone([dynamic /* ParsingReference | Date */ input]) {
    input = input ?? new DateTime.now();
    if (input is DateTime) {
      instant = input;
      timezoneOffset = Undefined(); //used as undefined. because checks reference.timezoneOffset !== null is typescript is true if it is indefined
    } else if (input is ParsingReference){
      instant = input.instant ?? DateTime.now();
      timezoneOffset = toTimezoneOffset(input.timezone is Undefined ? input.instant?.timeZoneOffset.inMinutes : input.timezone, instant);
    }
  }

  /**
   * Returns a JS date (system timezone) with the { year, month, day, hour, minute, second } equal to the reference.
   * The output's instant is NOT the reference's instant when the reference's and system's timezone are different.
   */
  getDateWithAdjustedTimezone() {
    return DateTime.fromMillisecondsSinceEpoch(instant.millisecondsSinceEpoch +
        getSystemTimezoneAdjustmentMinute(instant) * 60000);
  }

  /**
   * Returns the number minutes difference between the JS date's timezone and the reference timezone.
   *
   *
   */
  int getSystemTimezoneAdjustmentMinute(
      [DateTime? date, num? overrideTimezoneOffset]) {
    if (date == null || date.millisecondsSinceEpoch < 0) {
// Javascript date timezone calculation got effect when the time epoch < 0

// e.g. new Date('Tue Feb 02 1300 00:00:00 GMT+0900 (JST)') => Tue Feb 02 1300 00:18:59 GMT+0918 (JST)
      date = DateTime.now();
    }
    final currentTimezoneOffset = date.timeZoneOffset.inMinutes;
    final targetTimezoneOffset =
        overrideTimezoneOffset ?? (timezoneOffset is! num ? currentTimezoneOffset : timezoneOffset);
    return (currentTimezoneOffset - targetTimezoneOffset).toInt();
  }
  @override
  String toString(){
    return "$instant, offset: $timezoneOffset";
  }

}

class ParsingComponents implements ParsedComponents {
  late Map<Component, num> knownValues;

  late Map<Component, num> impliedValues;

  ReferenceWithTimezone reference;

  ParsingComponents(this.reference, Map<Component, num>? knownComponents) {
    knownValues = {};
    impliedValues = {};
    if (knownComponents != null) {
      for (final key in knownComponents.keys) {
        knownValues[key] = knownComponents[key]!;
      }
    }
    final refDayJs = reference.instant;
    imply(Component.day, refDayJs.day);
    imply(Component.month, refDayJs.month);
    imply(Component.year, refDayJs.year);
    imply(Component.hour, 12);
    imply(Component.minute, 0);
    imply(Component.second, 0);
    imply(Component.millisecond, 0);
  }

  num? get(Component component) {
    if (knownValues.keys.contains(component)) {
      return knownValues[component];
    }
    if (impliedValues.keys.contains(component)) {
      return impliedValues[component];
    }
    return null;
  }

  bool isCertain(Component component) {
    return knownValues.keys.contains(component);
  }

  List<Component> getCertainComponents() {
    return knownValues.keys.toList();
  }

  ParsingComponents imply(Component component, num value) {
    if (knownValues.keys.contains(component)) {
      return this;
    }
    impliedValues[component] = value;
    return this;
  }

  ParsingComponents assign(Component component, num value) {
    knownValues[component] = value;
    impliedValues.remove(component);
    return this;
  }

  delete(Component component) {
    knownValues.remove(component);
    ;
    impliedValues.remove(component);
    ;
  }

  ParsingComponents clone() {
    final component = new ParsingComponents(reference, null);
    component.knownValues = {};
    component.impliedValues = {};
    for (final key in knownValues.keys) {
      component.knownValues[key] = knownValues[key]!;
    }
    for (final key in impliedValues.keys) {
      component.impliedValues[key] = impliedValues[key]!;
    }
    return component;
  }

  bool isOnlyDate() {
    return !isCertain(Component.hour) &&
        !isCertain(Component.minute) &&
        !isCertain(Component.second);
  }

  bool isOnlyTime() {
    return !isCertain(Component.weekday) &&
        !isCertain(Component.day) &&
        !isCertain(Component.month);
  }

  bool isOnlyWeekdayComponent() {
    return isCertain(Component.weekday) &&
        !isCertain(Component.day) &&
        !isCertain(Component.month);
  }

  bool isDateWithUnknownYear() {
    return isCertain(Component.month) && !isCertain(Component.year);
  }

  bool isValidDate() {
    final date = dateWithoutTimezoneAdjustment();
    if (date.year != get(Component.year)) return false;
    if (date.month != get(Component.month)!.toInt()) return false;
    if (date.day != get(Component.day)) return false;
    if (get(Component.hour) != null &&
        date.hour != get(Component.hour)) return false;
    if (get(Component.minute) != null &&
        date.minute != get(Component.minute)) return false;
    return true;
  }

  toString() {
    return '''[ParsingComponents {knownValues: ${knownValues}, impliedValues: ${impliedValues}}, reference: ${reference}]''';
  }

  // dayjs() {
  //   return dayjs(this.date());
  // }

  DateTime date() {
    final date = dateWithoutTimezoneAdjustment();
    final timezoneAdjustment = reference.getSystemTimezoneAdjustmentMinute(
        date, get(Component.timezoneOffset));
    return new DateTime.fromMillisecondsSinceEpoch(
        date.millisecondsSinceEpoch + timezoneAdjustment * 60000);
  }

  DateTime dateWithoutTimezoneAdjustment() {
    final now = DateTime.now();
    final date = new DateTime(
        get(Component.year)?.toInt() ?? now.year,
        get(Component.month) != null
            ? get(Component.month)!.toInt()
            : now.month,
        get(Component.day)?.toInt() ?? now.day,
        get(Component.hour)?.toInt() ?? now.hour,
        get(Component.minute)?.toInt() ?? now.minute,
        get(Component.second)?.toInt() ?? now.second,
        get(Component.millisecond)?.toInt() ?? now.millisecond);
    // date.setFullYear(this.get(Component.year));
    return date;
  }

  static List<String> allFragmentKeys = [
    "year",
    "quarter",
    "month",
    "week",
    "day",
    "d",
    "hour",
    "minute",
    "second",
    "millisecond"
  ];

  static Map<String, int> processFloatTimeunits(Map<String, num> fragments) {
    for (final key in allFragmentKeys) {
      if (!fragments.containsKey(key)) {
        continue;
      }
      final difference = fragments[key]! - fragments[key]!.toInt();
      if (difference != 0) {
        fragments[key] = fragments[key]!.toInt();
        switch (key) {
          case "year":
            fragments["month"] =
                (fragments["month"] ?? 0) + (difference * 12).toInt();
            break;
          case "quarter":
            fragments["month"] = (fragments["month"] ?? 0) + (difference * 3);
            break;
          case "month":
            fragments["day"] =
                (fragments["day"] ?? 0) + (difference * 30).toInt();
            break;
          case "day":
            fragments["hour"] =
                (fragments["hour"] ?? 0) + (difference * 24).toInt();
            break;
          case "d":
            fragments["hour"] =
                (fragments["hour"] ?? 0) + (difference * 24).toInt();
            break;
          case "hour":
            fragments["minute"] =
                (fragments["minute"] ?? 0) + (difference * 60).toInt();
            break;
          case "minute":
            fragments["second"] =
                (fragments["second"] ?? 0) + (difference * 60).toInt();
            break;
          case "second":
            fragments["millisecond"] =
              (fragments["millisecond"] ?? 0) + (difference * 1000).toInt();
            break;
        }
      }
    }
    return fragments.map((key, value) => MapEntry(key, value.toInt()));
  }

  static ParsingComponents createRelativeFromReference(
      ReferenceWithTimezone reference, Map<String, num> fragments) {
    var date = reference.instant;
    // for (final key in fragments.keys) {
    final intFragments = processFloatTimeunits(fragments);
    date = date.copyWith(
      year: date.year + (intFragments["year"] ?? 0),
      month: date.month + (intFragments["month"] ?? 0),
    );
    date = date.addQuarter(intFragments["quarter"] ?? 0);
    date = date.add(Duration(
      days: (intFragments["d"] ?? 0) +
          (intFragments["day"] ?? 0) +
          ((intFragments["week"] ?? 0) * 7),
      hours: (intFragments["hour"] ?? 0),
      minutes: (intFragments["minute"] ?? 0),
      seconds: (intFragments["second"] ?? 0),
      milliseconds: (intFragments["millisecond"] ?? 0),
    ));
    // date = date.add(fragments[key].toInt(),key);
    // }
    final components = new ParsingComponents(reference, null);
    if (intFragments["hour"] != null ||
        intFragments["minute"] != null ||
        intFragments["second"] != null) {
      assignSimilarTime(components, date);
      assignSimilarDate(components, date);
      if (reference.timezoneOffset !=null) {
        components.assign(Component.timezoneOffset,
            reference.instant.timeZoneOffset.inMinutes);
      }
    } else {
      implySimilarTime(components, date);
      if (reference.timezoneOffset !=null) {
        components.imply(Component.timezoneOffset,
            reference.instant.timeZoneOffset.inMinutes);
      }
      if (intFragments["d"] != null) {
        components.assign(Component.day, date.day);
        components.assign(Component.month, date.month);
        components.assign(Component.year, date.year);
      } else {
        if (intFragments["week"] != null) {
          components.imply(Component.weekday, date.weekday);
        }
        components.imply(Component.day, date.day);
        if (intFragments["month"] != null) {
          components.assign(Component.month, date.month);
          components.assign(Component.year, date.year);
        } else {
          components.imply(Component.month, date.month);
          if (intFragments["year"] != null) {
            components.assign(Component.year, date.year);
          } else {
            components.imply(Component.year, date.year);
          }
        }
      }
    }
    return components;
  }
}

class ParsingResult implements ParsedResult {
  late DateTime refDate;

  int index;

  String text;

  ReferenceWithTimezone reference;

  late ParsingComponents start;

  ParsingComponents? end;

  ParsingResult(this.reference, this.index, this.text,
      [ParsingComponents? start, ParsingComponents? end]) {
    reference = reference;
    refDate = reference.instant;
    index = index;
    text = text;
    this.start = start ?? new ParsingComponents(reference, null);
    this.end = end;
  }

  clone() {
    final result = new ParsingResult(reference, index, text);
    result.start = start.clone();
    result.end = end != null ? end!.clone() : null;
    return result;
  }

  DateTime date() {
    return start.date();
  }

  toString() {
    return '''[ParsingResult {index: ${index}, text: \'${text}\', ...}]''';
  }
}

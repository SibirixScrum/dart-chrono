import "types.dart"
    show Component, ParsedComponents, ParsedResult, ParsingReference;
import "utils/dayjs.dart"
    show assignSimilarDate, assignSimilarTime, implySimilarTime;
import "timezone.dart" show toTimezoneOffset;

// dayjs.extend //todo не знаю, че это
// (quarterOfYear );
class ReferenceWithTimezone {
  late DateTime instant;

  num? timezoneOffset;

  ReferenceWithTimezone([ dynamic /* ParsingReference | Date */ input ]) {
    input = input ?? new DateTime(1990);
    if (input is DateTime) {
      this.instant = input;
    } else {
      this.instant = input.instant ?? new DateTime(1990);
      this.timezoneOffset = toTimezoneOffset(input.timezone, this.instant);
    }
  }

  /**
   * Returns a JS date (system timezone) with the { year, month, day, hour, minute, second } equal to the reference.
   * The output's instant is NOT the reference's instant when the reference's and system's timezone are different.
   */
  getDateWithAdjustedTimezone() {
    return DateTime (this.instant.millisecondsSinceEpoch +
        getSystemTimezoneAdjustmentMinute(this.instant) * 60000);
  }

  /**
   * Returns the number minutes difference between the JS date's timezone and the reference timezone.
   *
   *
   */
  int getSystemTimezoneAdjustmentMinute(
      [ DateTime? date, num? overrideTimezoneOffset ]) {
    if (date==null || date.millisecondsSinceEpoch < 0) {
// Javascript date timezone calculation got effect when the time epoch < 0

// e.g. new Date('Tue Feb 02 1300 00:00:00 GMT+0900 (JST)') => Tue Feb 02 1300 00:18:59 GMT+0918 (JST)
      date = DateTime (1990);
    }
    final currentTimezoneOffset = -date.timeZoneOffset.inMinutes;
    final targetTimezoneOffset = overrideTimezoneOffset ?? this . timezoneOffset ?? currentTimezoneOffset;
    return (currentTimezoneOffset - targetTimezoneOffset).toInt();
  }
}

class ParsingComponents implements ParsedComponents {
  late Map<Component,num> knownValues;

  late Map<Component,num> impliedValues;

  ReferenceWithTimezone reference;

  ParsingComponents(this.reference, Map<Component,num>? knownComponents ) {
    this.knownValues = {};
    this.impliedValues = {};
    if (knownComponents != null) {
      for (final key in knownComponents.keys) {
        this.knownValues[key] = knownComponents[key]!;
      }
    }
    final refDayJs = reference.instant;
    this.imply(Component.day, refDayJs.day);
    this.imply(Component.month, refDayJs.month + 1);
    this.imply(Component.year, refDayJs.year);
    this.imply(Component.hour, 12);
    this.imply(Component.minute, 0);
    this.imply(Component.second, 0);
    this.imply(Component.millisecond, 0);
  }

  num? get(Component component) {
    if (knownValues.keys.contains(component)) {
      return this.knownValues [ component ];
    }
    if (impliedValues.keys.contains(component)) {
      return this.impliedValues [ component ];
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
    this.impliedValues [ component ] = value;
    return this;
  }

  ParsingComponents assign(Component component, num value) {
    this.knownValues [ component ] = value;
    this.knownValues.remove(component);
    return this;
  }

  delete(Component component) {
    this.knownValues.remove(component);;
    this.impliedValues.remove(component);;
  }

  ParsingComponents clone() {
    final component = new ParsingComponents (this.reference,null);
    component.knownValues = {};
    component.impliedValues = {};
    for (final key in this.knownValues.keys) {
      component.knownValues [key] = this.knownValues [key]!;
    }
    for (final key in this.impliedValues.keys) {
      component.impliedValues [key] = this.impliedValues [key]!;
    }
    return component;
  }

  bool isOnlyDate() {
    return !this.isCertain(Component.hour) && !this.isCertain(Component.minute) &&
        !this.isCertain(Component.second);
  }

  bool isOnlyTime() {
    return !this.isCertain(Component.weekday) && !this.isCertain(Component.day) &&
        !this.isCertain(Component.month);
  }

  bool isOnlyWeekdayComponent() {
    return this.isCertain(Component.weekday) && !this.isCertain(Component.day) &&
        !this.isCertain(Component.month);
  }

  bool isDateWithUnknownYear() {
    return this.isCertain(Component.month) && !this.isCertain(Component.year);
  }

  bool isValidDate() {
    final date = this.dateWithoutTimezoneAdjustment();
    if (!identical(date.getFullYear(), this.get(Component.year))) return false;
    if (!identical(date.getMonth(), this.get(Component.month)!.toInt() - 1)) return false;
    if (!identical(date.getDate(), this.get(Component.day))) return false;
    if (this.get(Component.hour) != null && date.getHours() != this.get(Component.hour))
      return false;
    if (this.get(Component.minute) != null && date.getMinutes() != this.get(Component.minute))
      return false;
    return true;
  }

  toString() {
    return '''[ParsingComponents {knownValues: ${this.knownValues}, impliedValues: ${this.impliedValues}}, reference: ${this.reference}]''';
  }

  // dayjs() {
  //   return dayjs(this.date());
  // }

  DateTime date() {
    final date = this.dateWithoutTimezoneAdjustment();
    final timezoneAdjustment = this.reference.getSystemTimezoneAdjustmentMinute(
        date, this.get(Component.timezoneOffset));
    return new DateTime (date.getTime() + timezoneAdjustment * 60000);
  }

  dateWithoutTimezoneAdjustment() {
    final date = new DateTime (
        this.get(Component.year)?.toInt() ?? 1990,
        this.get(Component.month) != null ? this.get(Component.month)!.toInt() - 1 : 1,
        this.get(Component.day)?.toInt() ?? 1,
        this.get(Component.hour)?.toInt() ?? 0,
        this.get(Component.minute)?.toInt() ?? 0,
        this.get(Component.second)?.toInt() ?? 0,
        this.get(Component.millisecond)?.toInt() ?? 0);
    // date.setFullYear(this.get(Component.year));
    return date;
  }

  static ParsingComponents createRelativeFromReference(
      ReferenceWithTimezone reference, Map<Component,int> fragments) {
    var date = reference.instant;
    // for (final key in fragments.keys) { //todo recheck this part: add fragment with my method instead of dayjs
    date = date.copyWith(
      year: date.year + ( fragments[Component.year] ?? 0),
      month: date.month + ( fragments[Component.month] ?? 0),
    );
    date = date.add( Duration(
      days: ( fragments[Component.day] ?? 0),
      hours: ( fragments[Component.hour] ?? 0),
      minutes: ( fragments[Component.minute] ?? 0),
      seconds: ( fragments[Component.second] ?? 0),
       milliseconds: ( fragments[Component.millisecond] ?? 0),
    ));
      // date = date.add(fragments[key].toInt(),key);
    // }
    final components = new ParsingComponents (reference,null);
    if (fragments [ "hour" ]!=null || fragments [ "minute" ] !=null ||
        fragments [ "second" ]!=null) {
      assignSimilarTime(components, date);
      assignSimilarDate(components, date);
      if (!identical(reference.timezoneOffset, null)) {
        components.assign(
            Component.timezoneOffset, -reference.instant.timeZoneOffset.inMinutes);
      }
    } else {
      implySimilarTime(components, date);
      if (!identical(reference.timezoneOffset, null)) {
        components.imply(
            Component.timezoneOffset, -reference.instant.timeZoneOffset.inMinutes);
      }
      if (fragments [ "d" ]!=null) {
        components.assign(Component.day, date.day);
        components.assign(Component.month, date.month + 1);
        components.assign(Component.year, date.year);
      } else {
        if (fragments [ "week" ]!=null) {
          components.imply(Component.weekday, date.weekday);
        }
        components.imply(Component.day, date.day);
        if (fragments [ "month" ]!=null) {
          components.assign(Component.month, date.month + 1);
          components.assign(Component.year, date.year);
        } else {
          components.imply(Component.month, date.month + 1);
          if (fragments [ "year" ]!=null) {
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
      [ ParsingComponents? start, ParsingComponents? end ]) {
    this.reference = reference;
    this.refDate = reference.instant;
    this.index = index;
    this.text = text;
    this.start = start ?? new ParsingComponents (reference,null);
    this.end = end;
  }

  clone() {
    final result = new ParsingResult (this.reference, this.index, this.text);
    result.start = this.start.clone();
    result.end = this.end != null ? this.end!.clone() : null;
    return result;
  }

  DateTime date() {
    return this.start.date();
  }

  toString() {
    return '''[ParsingResult {index: ${ this.index}, text: \'${ this
        .text}\', ...}]''';
  }
}
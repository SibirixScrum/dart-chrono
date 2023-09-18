

import 'package:chrono/results.dart';

class ParsingOption {
  /**
   * To parse only forward dates (the results should be after the reference date).
   * This effects date/time implication (e.g. weekday or time mentioning)
   */
  bool? forwardDate;

  /**
   * Additional timezone keywords for the parsers to recognize.
   * Any value provided will override the default handling of that value.
   */
  TimezoneAbbrMap? timezones;

  /**
   * Internal debug event handler.
   * DebugHandler | DebugConsume
   * @internal
   */
  dynamic /* DebugHandler | DebugConsume */ debug;

  ParsingOption({this.forwardDate, this.timezones, this.debug});
}

/**
 * Some timezone abbreviations are ambiguous in that they refer to different offsets
 * depending on the time of year — daylight savings time (DST), or non-DST. This interface
 * allows defining such timezones
 */
class AmbiguousTimezoneMap {
  num timezoneOffsetDuringDst;
  num timezoneOffsetNonDst;

  /**
   * Return the start date of DST for the given year.
   * timezone.ts contains helper methods for common such rules.
   */
  DateTime Function(num year) dstStart;

  /**
   * Return the end date of DST for the given year.
   * timezone.ts contains helper methods for common such rules.
   */
  DateTime Function(num year) dstEnd;

  AmbiguousTimezoneMap(
      {required this.timezoneOffsetDuringDst,
      required this.timezoneOffsetNonDst,
      required this.dstStart,
      required this.dstEnd});
}

/**
 * A map describing how timezone abbreviations should map to time offsets.
 * Supports both unambigous mappings abbreviation => offset,
 * and ambiguous mappings, where the offset will depend on whether the
 * time in question is during daylight savings time or not.
 */
class ParsingReference {
  /**
   * Reference date. The instant (JavaScript Date object) when the input is written or mention.
   * This effect date/time implication (e.g. weekday or time mentioning).
   * (default = now)
   */
  DateTime? instant;

  ParsingReference(this.instant,[this.timezone  = const Undefined()]);

  /**
   * Reference timezone. The timezone where the input is written or mention.
   * Date/time implication will account the difference between input timezone and the current system timezone.
   * (default = current timezone)
   */
  dynamic /* String | num */ timezone;
}


/**
 * Parsed result or final output.
 * Each result object represents a date/time (or date/time-range) mentioning in the input.
 */
abstract class ParsedResult {
  DateTime get refDate;

  num get index;

  String get text;

  ParsedComponents get start;

  ParsedComponents? get end;

  /**
   * Create a javascript date object (from the result.start).
   */
  DateTime date({List<Component>? strictOnComponent});
}

/**
 * A collection of parsed date/time components (e.g. day, hour, minute, ..., etc).
 *
 * Each parsed component has three different levels of certainty.
 * - *Certain* (or *Known*): The component is directly mentioned and parsed.
 * - *Implied*: The component is not directly mentioned, but implied by other parsed information.
 * - *Unknown*: Completely no mention of the component.
 */
abstract class ParsedComponents {
  /**
   * Check the component certainly if the component is *Certain* (or *Known*)
   */
  bool isCertain(Component component);

  /**
   * Get the component value for either *Certain* or *Implied* value.
   */
  dynamic /* num | null */ get(Component component);

  /**
   *
   */
  DateTime date({List<Component>? strictOnComponent});
}

enum Component {
  //todo мб тут не енум
  year,
  month,
  // week,
  day,
  weekday,
  hour,
  minute,
  second,
  millisecond,
  meridiem,
  timezoneOffset,
}

enum Meridiem { AM, PM }

enum Weekday { SUNDAY, MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY }

enum Month {
  JANUARY,
  FEBRUARY,
  MARCH,
  APRIL,
  MAY,
  JUNE,
  JULY,
  AUGUST,
  SEPTEMBER,
  OCTOBER,
  NOVEMBER,
  DECEMBER;

  Month plus(int amount) {
    return Month.values[(Month.values.indexOf(this) + amount) % 12];
  }
}

///value is number | AmbiguousTimezoneMap
typedef TimezoneAbbrMap = Map<String, dynamic>;

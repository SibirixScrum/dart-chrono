import 'package:chrono/common/calculation/weekdays.dart';
import 'package:chrono/results.dart';
import 'package:chrono/types.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Test - This Weekday Calculation", () {
    {
      final reference =
          new ReferenceWithTimezone(DateTime.parse("2022-08-20T12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.MONDAY, "this");
      expect(output.date(),DateTime.parse("2022-08-22T12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(DateTime.parse("2022-08-21T12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.FRIDAY, "this");
      expect(output.date(),DateTime.parse("2022-08-26T12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(DateTime.parse("2022-08-02T12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.SUNDAY, "this");
      expect(output.date(),DateTime.parse("2022-08-07T12:00:00"));
    }
  });
  test("Test - Last Weekday Calculation", () {
    {
      final reference =
          new ReferenceWithTimezone(DateTime.parse("2022-08-20T12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.FRIDAY, "last");
      expect(output.date(),DateTime.parse("2022-08-19T12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(DateTime.parse("2022-08-20T12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.MONDAY, "last");
      expect(output.date(),DateTime.parse("2022-08-15T12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(DateTime.parse("2022-08-20T12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.SUNDAY, "last");
      expect(output.date(),DateTime.parse("2022-08-14T12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(DateTime.parse("2022-08-20T12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.SATURDAY, "last");
      expect(output.date(),DateTime.parse("2022-08-13T12:00:00"));
    }
  });
  test("Test - Next Weekday Calculation", () {
    {
      final reference =
          new ReferenceWithTimezone(DateTime.parse("2022-08-21T12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.MONDAY, "next");
      expect(output.date(),DateTime.parse("2022-08-22T12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(DateTime.parse("2022-08-21T12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.SATURDAY, "next");
      expect(output.date(),DateTime.parse("2022-08-27T12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(DateTime.parse("2022-08-21T12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.SUNDAY, "next");
      expect(output.date(),DateTime.parse("2022-08-28T12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(DateTime.parse("2022-08-20T12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.FRIDAY, "next");
      expect(output.date(),DateTime.parse("2022-08-26T12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(DateTime.parse("2022-08-20T12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.SATURDAY, "next");
      expect(output.date(),DateTime.parse("2022-08-27T12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(DateTime.parse("2022-08-20T12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.SUNDAY, "next");
      expect(output.date(),DateTime.parse("2022-08-28T12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone (DateTime.parse("2022-08-02T12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.MONDAY, "next");
      expect(output.date(),DateTime.parse("2022-08-08T12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone (DateTime.parse("2022-08-02T12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.FRIDAY, "next");
      expect(output.date(),DateTime.parse("2022-08-12T12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone (DateTime.parse("2022-08-02T12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.SUNDAY, "next");
      expect(output.date(),DateTime.parse("2022-08-14T12:00:00"));
    }
  });
  test("Test - Closest Weekday Calculation", () {
    {
      final refDate = DateTime.parse("2022-08-20T12:00:00");
      expect(getDaysToWeekday(refDate, Weekday.MONDAY),2);
    }
    {
      final refDate = DateTime.parse("2022-08-20T12:00:00");
      expect(getDaysToWeekday(refDate, Weekday.TUESDAY),3);
    }
    {
      final refDate = DateTime.parse("2022-08-20T12:00:00");
      expect(getDaysToWeekday(refDate, Weekday.FRIDAY),-1);
    }
    {
      final refDate = DateTime.parse("2022-08-20T12:00:00");
      expect(getDaysToWeekday(refDate, Weekday.THURSDAY),-2);
    }
    {
      final refDate = DateTime.parse("2022-08-20T12:00:00");
      expect(getDaysToWeekday(refDate, Weekday.WEDNESDAY),-3);
    }
  });
}

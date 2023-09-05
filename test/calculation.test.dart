import 'package:chrono/common/calculation/weekdays.dart';
import 'package:chrono/results.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Test - This Weekday Calculation", () {
    {
      final reference =
          new ReferenceWithTimezone(new DateTime("Sat, 20 Aug 2022 12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.MONDAY, "this");
      expect(output.date())
          .toStrictEqual(new DateTime("Mon, Aug 22 2022 12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(new DateTime("Sun, 21 Aug 2022 12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.FRIDAY, "this");
      expect(output.date())
          .toStrictEqual(new DateTime("Fri, Aug 26 2022 12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(new DateTime("Tue, Aug 2 2022 12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.SUNDAY, "this");
      expect(output.date()).toStrictEqual(new DateTime("Sun, Aug 7 2022 12:00:00"));
    }
  });
  test("Test - Last Weekday Calculation", () {
    {
      final reference =
          new ReferenceWithTimezone(new DateTime("Sat, 20 Aug 2022 12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.FRIDAY, "last");
      expect(output.date())
          .toStrictEqual(new DateTime("Fri, Aug 19 2022 12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(new DateTime("Sat, 20 Aug 2022 12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.MONDAY, "last");
      expect(output.date())
          .toStrictEqual(new DateTime("Mon, Aug 15 2022 12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(new DateTime("Sat, 20 Aug 2022 12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.SUNDAY, "last");
      expect(output.date())
          .toStrictEqual(new DateTime("Sun, Aug 14 2022 12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(new DateTime("Sat, 20 Aug 2022 12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.SATURDAY, "last");
      expect(output.date())
          .toStrictEqual(new DateTime("Sat, Aug 13 2022 12:00:00"));
    }
  });
  test("Test - Next Weekday Calculation", () {
    {
      final reference =
          new ReferenceWithTimezone(new DateTime("Sun, Aug 21 2022 12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.MONDAY, "next");
      expect(output.date())
          .toStrictEqual(new DateTime("Mon, Aug 22 2022 12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(new DateTime("Sun, Aug 21 2022 12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.SATURDAY, "next");
      expect(output.date())
          .toStrictEqual(new DateTime("Sat, Aug 27 2022 12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(new DateTime("Sun, Aug 21 2022 12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.SUNDAY, "next");
      expect(output.date())
          .toStrictEqual(new DateTime("Sun, Aug 28 2022 12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(new DateTime("Sat, Aug 20 2022 12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.FRIDAY, "next");
      expect(output.date())
          .toStrictEqual(new DateTime("Fri, Aug 26 2022 12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(new DateTime("Sat, Aug 20 2022 12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.SATURDAY, "next");
      expect(output.date())
          .toStrictEqual(new DateTime("Sat, Aug 27 2022 12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(new DateTime("Sat, Aug 20 2022 12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.SUNDAY, "next");
      expect(output.date())
          .toStrictEqual(new DateTime("Sun, Aug 28 2022 12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(new DateTime("Tue, Aug 2 2022 12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.MONDAY, "next");
      expect(output.date()).toStrictEqual(new DateTime("Mon, Aug 8 2022 12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(new DateTime("Tue, Aug 2 2022 12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.FRIDAY, "next");
      expect(output.date())
          .toStrictEqual(new DateTime("Fri, Aug 12 2022 12:00:00"));
    }
    {
      final reference =
          new ReferenceWithTimezone(new DateTime("Tue, Aug 2 2022 12:00:00"));
      final output =
          createParsingComponentsAtWeekday(reference, Weekday.SUNDAY, "next");
      expect(output.date())
          .toStrictEqual(new DateTime("Sun, Aug 14 2022 12:00:00"));
    }
  });
  test("Test - Closest Weekday Calculation", () {
    {
      final refDate = new DateTime("Sat, 20 Aug 2022 12:00:00");
      expect(getDaysToWeekday(refDate, Weekday.MONDAY),2);
    }
    {
      final refDate = new DateTime("Sat, 20 Aug 2022 12:00:00");
      expect(getDaysToWeekday(refDate, Weekday.TUESDAY),3);
    }
    {
      final refDate = new DateTime("Sat, 20 Aug 2022 12:00:00");
      expect(getDaysToWeekday(refDate, Weekday.FRIDAY),-1);
    }
    {
      final refDate = new DateTime("Sat, 20 Aug 2022 12:00:00");
      expect(getDaysToWeekday(refDate, Weekday.THURSDAY),-2);
    }
    {
      final refDate = new DateTime("Sat, 20 Aug 2022 12:00:00");
      expect(getDaysToWeekday(refDate, Weekday.WEDNESDAY),-3);
    }
  });
}

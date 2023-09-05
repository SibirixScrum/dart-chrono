import "package:chrono/results.dart";
import "package:flutter_test/flutter_test.dart";



void main() {
  test("Test - Create & manipulate date results", () {
    final reference = new ReferenceWithTimezone(new DateTime());
    final components =
        new ParsingComponents(reference, year: 2014, month: 11, day: 24);
    expect(components.get("year"),2014);
    expect(components.get("month"),11);
    expect(components.get("day"),24);
    expect(components.date()!=null,isTrue);
    // null
    expect(components.get("weekday")!=null,isFalse);
    expect(components.isCertain("weekday"),false);
    // "imply"
    components.imply("weekday", 1);
    expect(components.get("weekday"),1);
    expect(components.isCertain("weekday"),false);
    // "assign" overrides "imply"
    components.assign("weekday", 2);
    expect(components.get("weekday"),2);
    expect(components.isCertain("weekday"),true);
    // "imply" doesn't overrides "assign"
    components.imply("year", 2013);
    expect(components.get("year"),2014);
    // "assign" overrides "assign"
    components.assign("year", 2013);
    expect(components.get("year"),2013);
  });
  test("Test - Calendar checking with implied components", () {
    final reference = new ReferenceWithTimezone(new DateTime());
    {
      final components = new ParsingComponents(reference, {
        "day": 13,
        "month": 3,
        "year": 2021,
        "hour": 14,
        "minute": 22,
        "second": 14,
        "millisecond": 0
      });
      components.imply("timezoneOffset", -300);
      expect(components.isValidDateTime(),true);
    }
  });
  test("Test - Calendar Checking", () {
    final reference = new ReferenceWithTimezone(new DateTime());
    {
      final components =
          new ParsingComponents(reference, year: 2014, month: 11, day: 24);
      expect(components.isValidDateTime(),true);
    }
    {
      final components = new ParsingComponents(reference,
          year: 2014, month: 11, day: 24, hour: 12);
      expect(components.isValidDateTime(),true);
    }
    {
      final components = new ParsingComponents(reference,
          year: 2014, month: 11, day: 24, hour: 12, minute: 30);
      expect(components.isValidDateTime(),true);
    }
    {
      final components = new ParsingComponents(reference,
          year: 2014, month: 11, day: 24, hour: 12, minute: 30, second: 30);
      expect(components.isValidDateTime(),true);
    }
    {
      final components =
          new ParsingComponents(reference, year: 2014, month: 13, day: 24);
      expect(components.isValidDateTime(),false);
    }
    {
      final components =
          new ParsingComponents(reference, year: 2014, month: 11, day: 32);
      expect(components.isValidDateTime(),false);
    }
    {
      final components = new ParsingComponents(reference,
          year: 2014, month: 11, day: 24, hour: 24);
      expect(components.isValidDateTime(),false);
    }
    {
      final components = new ParsingComponents(reference,
          year: 2014, month: 11, day: 24, hour: 12, minute: 60);
      expect(components.isValidDateTime(),false);
    }
    {
      final components = new ParsingComponents(reference,
          year: 2014, month: 11, day: 24, hour: 12, minute: 30, second: 60);
      expect(components.isValidDateTime(),false);
    }
  });
}

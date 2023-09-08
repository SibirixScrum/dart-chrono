import "package:chrono/results.dart";
import "package:chrono/types.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  test("Test - Create & manipulate date results", () {
    final reference = new ReferenceWithTimezone(DateTime.now());
    final components = ParsingComponents(reference,
        {Component.year: 2014, Component.month: 11, Component.day: 24});
    expect(components.get(Component.year), 2014);
    expect(components.get(Component.month), 11);
    expect(components.get(Component.day), 24);
    expect(components.date() != null, isTrue);
    // null
    expect(components.get(Component.weekday) != null, isFalse);
    expect(components.isCertain(Component.weekday), false);
    // "imply"
    components.imply(Component.weekday, 1);
    expect(components.get(Component.weekday), 1);
    expect(components.isCertain(Component.weekday), false);
    // "assign" overrides "imply"
    components.assign(Component.weekday, 2);
    expect(components.get(Component.weekday), 2);
    expect(components.isCertain(Component.weekday), true);
    // "imply" doesn't overrides "assign"
    components.imply(Component.year, 2013);
    expect(components.get(Component.year), 2014);
    // "assign" overrides "assign"
    components.assign(Component.year, 2013);
    expect(components.get(Component.year), 2013);
  });
  test("Test - Calendar checking with implied components", () {
    final reference = new ReferenceWithTimezone(DateTime.now());
    {
      final components = new ParsingComponents(reference, {
        Component.day: 13,
        Component.month: 3,
        Component.year: 2021,
        Component.hour: 14,
        Component.minute: 22,
        Component.second: 14,
        Component.millisecond: 0
      });
      components.imply(Component.timezoneOffset, -300);
      expect(components.isValidDate(), true);
    }
  });
  test("Test - Calendar Checking", () {
    final reference = new ReferenceWithTimezone(DateTime.now());
    {
      final components = new ParsingComponents(reference,
          {Component.year: 2014, Component.month: 11, Component.day: 24});
      expect(components.isValidDate(), true);
    }
    {
      final components = new ParsingComponents(reference, {
        Component.year: 2014,
        Component.month: 11,
        Component.day: 24,
        Component.hour: 12
      });
      expect(components.isValidDate(), true);
    }
    {
      final components = new ParsingComponents(reference, {
        Component.year: 2014,
        Component.month: 11,
        Component.day: 24,
        Component.hour: 12,
        Component.minute: 30
      });
      expect(components.isValidDate(), true);
    }
    {
      final components = new ParsingComponents(reference, {
        Component.year: 2014,
        Component.month: 11,
        Component.day: 24,
        Component.hour: 12,
        Component.minute: 30,
        Component.second: 30
      });
      expect(components.isValidDate(), true);
    }
    {
      final components = new ParsingComponents(reference,
          {Component.year: 2014, Component.month: 13, Component.day: 24});
      expect(components.isValidDate(), false);
    }
    {
      final components = new ParsingComponents(reference,
          {Component.year: 2014, Component.month: 11, Component.day: 32});
      expect(components.isValidDate(), false);
    }
    {
      final components = new ParsingComponents(reference, {
        Component.year: 2014,
        Component.month: 11,
        Component.day: 24,
        Component.hour: 24
      });
      expect(components.isValidDate(), false);
    }
    {
      final components = new ParsingComponents(reference, {
        Component.year: 2014,
        Component.month: 11,
        Component.day: 24,
        Component.hour: 12,
        Component.minute: 60
      });
      expect(components.isValidDate(), false);
    }
    {
      final components = new ParsingComponents(reference, {
        Component.year: 2014,
        Component.month: 11,
        Component.day: 24,
        Component.hour: 12,
        Component.minute: 30,
        Component.second: 60
      });
      expect(components.isValidDate(), false);
    }
  });
}

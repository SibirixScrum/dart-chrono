import "chrono.dart" show Configuration, Parser, Refiner;

Configuration includeCommonConfiguration(Configuration configuration,
    [strictMode = false]) {
  configuration.parsers.insert(0,new ISOFormatParser());
  configuration.refiners.insert(0,new MergeWeekdayComponentRefiner());
  configuration.refiners.insert(0,new ExtractTimezoneOffsetRefiner());
  configuration.refiners.insert(0,new OverlapRemovalRefiner());
  // Unlike ExtractTimezoneOffsetRefiner, this refiner relies on knowing both date and time in cases where the tz

  // is ambiguous (in terms of DST/non-DST). It therefore needs to be applied as late as possible in the parsing.
  configuration.refiners.add(new ExtractTimezoneAbbrRefiner());
  configuration.refiners.add(new OverlapRemovalRefiner());
  configuration.refiners.add(new ForwardDateRefiner());
  configuration.refiners.add(new UnlikelyFormatFilter(strictMode));
  return configuration;
}

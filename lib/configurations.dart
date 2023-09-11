import "package:chrono/common/refiners/ExtractTimezoneAbbrRefiner.dart";
import "package:chrono/common/refiners/ExtractTimezoneOffsetRefiner.dart";
import "package:chrono/common/refiners/ForwardDateRefiner.dart";
import "package:chrono/common/refiners/MergeWeekdayComponentRefiner.dart";
import "package:chrono/common/refiners/OverlapRemovalRefiner.dart";
import "package:chrono/common/refiners/UnlikelyFormatFilter.dart";

import "chrono.dart" show Configuration, Parser, Refiner;
import "common/parsers/ISOFormatParser.dart";

Configuration includeCommonConfiguration(Configuration configuration,
    [strictMode = false]) {
  configuration.parsers.insert(0, ISOFormatParser());
  configuration.refiners.insert(0, MergeWeekdayComponentRefiner());
  configuration.refiners.insert(0, ExtractTimezoneOffsetRefiner());
  configuration.refiners.insert(0, OverlapRemovalRefiner());
  // Unlike ExtractTimezoneOffsetRefiner, this refiner relies on knowing both date and time in cases where the tz

  // is ambiguous (in terms of DST/non-DST). It therefore needs to be applied as late as possible in the parsing.
  configuration.refiners.add(ExtractTimezoneAbbrRefiner(null));
  configuration.refiners.add(OverlapRemovalRefiner());
  configuration.refiners.add(ForwardDateRefiner());
  configuration.refiners.add(UnlikelyFormatFilter(strictMode));
  return configuration;
}

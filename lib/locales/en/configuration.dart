import 'package:chrono/chrono.dart';
import 'package:chrono/common/parsers/SlashDateFormatParser.dart';
import 'package:chrono/configurations.dart';
import 'package:chrono/locales/en/parsers/ENCasualDateParser.dart';
import 'package:chrono/locales/en/parsers/ENCasualTimeParser.dart';
import 'package:chrono/locales/en/parsers/ENCasualYearMonthDayParser.dart';
import 'package:chrono/locales/en/parsers/ENMonthNameLittleEndianParser.dart';
import 'package:chrono/locales/en/parsers/ENMonthNameMiddleEndianParser.dart';
import 'package:chrono/locales/en/parsers/ENMonthNameParser.dart';
import 'package:chrono/locales/en/parsers/ENRelativeDateFormatParser.dart';
import 'package:chrono/locales/en/parsers/ENSlashMonthFormatParser.dart';
import 'package:chrono/locales/en/parsers/ENTimeExpressionParser.dart';
import 'package:chrono/locales/en/parsers/ENTimeUnitAgoFormatParser.dart';
import 'package:chrono/locales/en/parsers/ENTimeUnitCasualRelativeFormatParser.dart';
import 'package:chrono/locales/en/parsers/ENTimeUnitLaterFormatParser.dart';
import 'package:chrono/locales/en/parsers/ENTimeUnitWithinFormatParser.dart';
import 'package:chrono/locales/en/parsers/ENWeekdayParser.dart';
import 'package:chrono/locales/en/refiners/ENMergeDateRangeRefiner.dart';
import 'package:chrono/locales/en/refiners/ENMergeDateTimeRefiner.dart';
import 'package:chrono/locales/en/refiners/ENMergeRelativeDateRefiner.dart';

class ENDefaultConfiguration {
  /**
   * Create a default *casual* {@Link Configuration} for English chrono.
   * It calls {@Link createConfiguration} and includes additional parsers.
   */
  static Configuration createCasualConfiguration([littleEndian = false]) {
    final option = createConfiguration(false, littleEndian);
    option.parsers.insert(0, new ENCasualDateParser());
    option.parsers.insert(0, new ENCasualTimeParser());
    option.parsers.insert(0, new ENMonthNameParser());
    option.parsers.insert(0, new ENRelativeDateFormatParser());
    option.parsers.insert(0, new ENTimeUnitCasualRelativeFormatParser());
    return option;
  }

  /**
   * Create a default {@Link Configuration} for English chrono
   *
   *
   *
   */
  static Configuration createConfiguration([strictMode = true, littleEndian = false]) {
    final options = includeCommonConfiguration(
        Configuration([
          new SlashDateFormatParser(littleEndian),
          new ENTimeUnitWithinFormatParser(strictMode),
          new ENMonthNameLittleEndianParser(),
          new ENMonthNameMiddleEndianParser(),
          new ENWeekdayParser(),
          new ENCasualYearMonthDayParser(),
          new ENSlashMonthFormatParser(),
          new ENTimeExpressionParser(strictMode),
          new ENTimeUnitAgoFormatParser(strictMode),
          new ENTimeUnitLaterFormatParser(strictMode)
        ], [
          new ENMergeRelativeDateRefiner(),
          new ENMergeDateTimeRefiner()
        ]),
        strictMode);
    // Re-apply the date time refiner again after the timezone refinement and exclusion in common refiners.
    options.refiners.add(new ENMergeDateTimeRefiner());
    // Keep the date range refiner at the end (after all other refinements).
    options.refiners.add(new ENMergeDateRangeRefiner());
    return options;
  }
}

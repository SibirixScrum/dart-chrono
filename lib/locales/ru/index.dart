/**
 * Chrono components for Russian support (*parsers*, *refiners*, and *configuration*)
 *
 *
 */
import "package:chrono/common/parsers/SlashDateFormatParser.dart";
import "package:chrono/locales/ru/parsers/RUCasualDateParser.dart";
import "package:chrono/locales/ru/parsers/RUCasualTimeParser.dart";
import "package:chrono/locales/ru/parsers/RUMonthNameLittleEndianParser.dart";
import "package:chrono/locales/ru/parsers/RUMonthNameParser.dart";
import "package:chrono/locales/ru/parsers/RURelativeDateFormatParser.dart";
import "package:chrono/locales/ru/parsers/RUTimeExpressionParser.dart";
import "package:chrono/locales/ru/parsers/RUTimeUnitAgoFormatParser.dart";
import "package:chrono/locales/ru/parsers/RUTimeUnitCasualRelativeFormatParser.dart";
import "package:chrono/locales/ru/parsers/RUTimeUnitWithinFormatParser.dart";
import "package:chrono/locales/ru/parsers/RUWeekdayParser.dart";
import "package:chrono/locales/ru/refiners/RUMergeDateRangeRefiner.dart";
import "package:chrono/locales/ru/refiners/RUMergeDateTimeRefiner.dart";

import "../../chrono.dart" show Chrono, Configuration, Parser, Refiner;
import "../../configurations.dart" show includeCommonConfiguration;
import "../../types.dart"
    show
        Component,
        ParsedResult,
        ParsingOption,
        ParsingReference,
        Meridiem,
        Weekday;

/**
 * Chrono object configured for parsing *casual* Russian
 */
final casual = new Chrono(createCasualConfiguration());

/**
 * Chrono object configured for parsing *strict* Russian
 */
final strict = new Chrono(createConfiguration(true));

/**
 * A shortcut for ru.casual.parse()
 */
List<ParsedResult> parse(String text, [DateTime? ref, ParsingOption? option]) {
  return casual.parse(text, ref, option);
}

/**
 * A shortcut for ru.casual.parseDate()
 */
DateTime? parseDate(String text, [DateTime? ref, ParsingOption? option]) {
  return casual.parseDate(text, ref, option);
}

/**
 * Create a default *casual* {@Link Configuration} for Russian chrono.
 * It calls {@Link createConfiguration} and includes additional parsers.
 */
Configuration createCasualConfiguration() {
  final option = createConfiguration(false);
  option.parsers.insert(0, new RUCasualDateParser());
  option.parsers.insert(0, new RUCasualTimeParser());
  option.parsers.insert(0, new RUMonthNameParser());
  option.parsers.insert(0, new RURelativeDateFormatParser());
  option.parsers.insert(0, new RUTimeUnitCasualRelativeFormatParser());
  return option;
}

/**
 * Create a default {@Link Configuration} for Russian chrono
 *
 *
 */
Configuration createConfiguration([strictMode = true]) {
  return includeCommonConfiguration(
      Configuration([
        new SlashDateFormatParser(true),
        new RUTimeUnitWithinFormatParser(),
        new RUMonthNameLittleEndianParser(),
        new RUWeekdayParser(),
        new RUTimeExpressionParser(strictMode),
        new RUTimeUnitAgoFormatParser()
      ], [
        new RUMergeDateTimeRefiner(),
        new RUMergeDateRangeRefiner()
      ]),
      strictMode);
}

import 'package:chrono/chrono.dart';
import 'package:chrono/locales/en/configuration.dart';
import 'package:chrono/types.dart';

/**
 * Chrono object configured for parsing *casual* English
 */
final casual = Chrono (ENDefaultConfiguration.createCasualConfiguration(false));
/**
 * Chrono object configured for parsing *strict* English
 */
final strict = Chrono (ENDefaultConfiguration.createConfiguration(true, false));
/**
 * Chrono object configured for parsing *UK-style* English
 */
final GB = Chrono (ENDefaultConfiguration.createConfiguration(false, true));
/**
 * A shortcut for en.casual.parse()
 */
List <ParsedResult> parse(String text,
    [ DateTime? ref, ParsingOption? option ]) {
 return casual.parse(text, referenceDate: ref, option: option);
}
/**
 * A shortcut for en.casual.parseDate()
 */
DateTime? parseDate(String text, {DateTime? referenceDate, ParsingOption? option}) {
 return casual.parseDate(text, referenceDate, option);
}
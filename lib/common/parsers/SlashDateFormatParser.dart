import "package:chrono/ported/ParseInt.dart";
import "package:chrono/ported/RegExpMatchArray.dart";
import "package:chrono/ported/StringUtils.dart";
import "package:chrono/types.dart";

import "../../calculation/years.dart"
    show findMostLikelyADYear, findYearClosestToRef;
import "../../chrono.dart" show Parser, ParsingContext;
import "../../results.dart" show ParsingResult;

/**
 * Date format with slash "/" (or dot ".") between numbers.
 * For examples:
 * - 7/10
 * - 7/12/2020
 * - 7.12.2020
 */
final PATTERN = new RegExp(
    "([^\\d]|^)" +
        "([0-3]{0,1}[0-9]{1})[\\/\\.\\-]([0-3]{0,1}[0-9]{1})" +
        "(?:[\\/\\.\\-]([0-9]{4}|[0-9]{2}))?" +
        "(\\W|\$)",
    caseSensitive: false);

const OPENING_GROUP = 1;

const ENDING_GROUP = 5;

const FIRST_NUMBERS_GROUP = 2;

const SECOND_NUMBERS_GROUP = 3;

const YEAR_GROUP = 4;

class SlashDateFormatParser implements Parser {
  late int groupNumberMonth;

  late int groupNumberDay;

  SlashDateFormatParser(bool littleEndian) {
    groupNumberMonth =
        littleEndian ? SECOND_NUMBERS_GROUP : FIRST_NUMBERS_GROUP;
    groupNumberDay =
        littleEndian ? FIRST_NUMBERS_GROUP : SECOND_NUMBERS_GROUP;
  }

  @override
  RegExp pattern(ParsingContext context) {
    return PATTERN;
  }

  @override
  ParsingResult? extract(ParsingContext context, RegExpMatchArray match) {
    // Because of how pattern is executed on remaining text in `chrono.ts`, the character before the match could

    // still be a number (e.g. X[X/YY/ZZ] or XX[/YY/ZZ] or [XX/YY/]ZZ). We want to check and skip them.
    if (match[OPENING_GROUP].length == 0 &&
        match.index > 0 &&
        match.index < context.text.length) {
      final previousChar = context.text[match.index - 1];
      final numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
      if (numbers.contains(previousChar)) {
        // throw Exception(); // todo null instead of return nothing
        return null;
      }
    }
    final index = match.index + match[OPENING_GROUP].length;

    final text = match.matches[0]!.substringTs(
        match[OPENING_GROUP].length,
        match[0].length -
            match[ENDING_GROUP].length);
    // '1.12', '1.12.12' is more like a version numbers
    if (RegExp(r'^\d\.\d$').firstMatch(text) != null ||
        RegExp(r'^\d\.\d{1,2}\s*$').firstMatch(text) != null) {
      return null;
    }
    // MM/dd -> OK

    // MM.dd -> NG
    if (match[YEAR_GROUP].isEmpty  &&
        match.matches[0] != null &&
        !match.matches[0]!.contains("/")) {
      return null;
    }
    final result = context.createParsingResult(index, text);
    var month = parseIntTs(match.matches[groupNumberMonth]!);
    var day = parseIntTs(match.matches[groupNumberDay]!);
    if (month < 1 || month > 12) {
      if (month > 12) {
        if (day >= 1 && day <= 12 && month <= 31) {
          final temp = month;
          month = day;
          day = temp;
        } else {
          return null;
        }
      }
    }
    if (day < 1 || day > 31) {
      return null;
    }
    result.start.assign(Component.day, day);
    result.start.assign(Component.month, month);
    if (match[YEAR_GROUP].isNotEmpty) {
      final rawYearNumber = parseIntTs(match[YEAR_GROUP]);
      final year = findMostLikelyADYear(rawYearNumber);
      result.start.assign(Component.year, year);
    } else {
      final year = findYearClosestToRef(context.refDate, day, month);
      result.start.imply(Component.year, year);
    }
    return result;
  }
}

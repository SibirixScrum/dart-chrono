import "package:chrono/types.dart";
import "package:flutter/material.dart";

import "../../chrono.dart" show Parser, ParsingContext;
import "../../results.dart" show ParsingResult;
import "../../calculation/years.dart"
    show findMostLikelyADYear, findYearClosestToRef;

/**
 * Date format with slash "/" (or dot ".") between numbers.
 * For examples:
 * - 7/10
 * - 7/12/2020
 * - 7.12.2020
 */
final PATTERN = new RegExp (
    "([^\\d]|^)" + "([0-3]{0,1}[0-9]{1})[\\/\\.\\-]([0-3]{0,1}[0-9]{1})" +
        "(?:[\\/\\.\\-]([0-9]{4}|[0-9]{2}))?" + "(\\W|\$)", "i");

const OPENING_GROUP = 1;

const ENDING_GROUP = 5;

const FIRST_NUMBERS_GROUP = 2;

const SECOND_NUMBERS_GROUP = 3;

const YEAR_GROUP = 4;

class SlashDateFormatParser implements Parser {
  late num groupNumberMonth;

  late num groupNumberDay;

  SlashDateFormatParser(bool littleEndian) {
    this.groupNumberMonth =
    littleEndian ? SECOND_NUMBERS_GROUP : FIRST_NUMBERS_GROUP;
    this.groupNumberDay =
    littleEndian ? FIRST_NUMBERS_GROUP : SECOND_NUMBERS_GROUP;
  }

  @override
  RegExp pattern(ParsingContext context) {
   return PATTERN;
  }

  ParsingResult? extract(ParsingContext context, RegExpMatchArray match) {
    // Because of how pattern is executed on remaining text in `chrono.ts`, the character before the match could

    // still be a number (e.g. X[X/YY/ZZ] or XX[/YY/ZZ] or [XX/YY/]ZZ). We want to check and skip them.
    if (match [ OPENING_GROUP ].length == 0 && match.index > 0 &&
        match.index < context.text.length) {
      final previousChar = context.text [ match.index - 1 ];
      final numbers = ['0','1','2','3','4','5','6','7','8','9'];
      if (numbers.contains(previousChar)) {
       // throw Exception(); // todo null instead of return nothing
         return null;
      }
    }
    final index = match.index + match [ OPENING_GROUP ].length;
    final text = match [ 0 ].substr(match [ OPENING_GROUP ].length,
        match [ 0 ].length - match [ OPENING_GROUP ].length -
            match [ ENDING_GROUP ].length);
    // '1.12', '1.12.12' is more like a version numbers
    if (text.match(new RegExp (r'^\d\.\d$')) ||
        text.match(new RegExp (r'^\d\.\d{1,2}\.\d{1,2}\s*$'))) {
     return null;
    }
    // MM/dd -> OK

    // MM.dd -> NG
    if (!match [ YEAR_GROUP ] && match [ 0 ].indexOf("/") < 0) {
     return null;
    }
    final result = context.createParsingResult(index, text);
    var month = int.parse(match [ this.groupNumberMonth ]);
    var day = int.parse(match [ this.groupNumberDay ]);
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
    if (match [ YEAR_GROUP ]) {
      final rawYearNumber = int.parse(match [ YEAR_GROUP ]);
      final year = findMostLikelyADYear(rawYearNumber);
      result.start.assign(Component.year, year);
    } else {
      final year = findYearClosestToRef(context.refDate, day, month);
      result.start.imply(Component.year, year);
    }
    return result;
  }


}
import "package:chrono/ported/RegExpMatchArray.dart";

import "../../calculation/years.dart" show findMostLikelyADYear;
import "../../utils/pattern.dart" show matchAnyPattern, repeatedTimeunitPattern;
import "../../utils/timeunits.dart" show TimeUnits;

final Map<String, int> WEEKDAY_DICTIONARY = {
  "sunday": 0,
  "sun": 0,
  "sun.": 0,
  "monday": 1,
  "mon": 1,
  "mon.": 1,
  "tuesday": 2,
  "tue": 2,
  "tue.": 2,
  "wednesday": 3,
  "wed": 3,
  "wed.": 3,
  "thursday": 4,
  "thurs": 4,
  "thurs.": 4,
  "thur": 4,
  "thur.": 4,
  "thu": 4,
  "thu.": 4,
  "friday": 5,
  "fri": 5,
  "fri.": 5,
  "saturday": 6,
  "sat": 6,
  "sat.": 6
};

final Map<String, int> FULL_MONTH_NAME_DICTIONARY = {
  "january": 1,
  "february": 2,
  "march": 3,
  "april": 4,
  "may": 5,
  "june": 6,
  "july": 7,
  "august": 8,
  "september": 9,
  "october": 10,
  "november": 11,
  "december": 12
};

final Map<String, int> MONTH_DICTIONARY = {
  "january": 1,
  "february": 2,
  "march": 3,
  "april": 4,
  "may": 5,
  "june": 6,
  "july": 7,
  "august": 8,
  "september": 9,
  "october": 10,
  "november": 11,
  "december": 12,
  "jan": 1,
  "jan.": 1,
  "feb": 2,
  "feb.": 2,
  "mar": 3,
  "mar.": 3,
  "apr": 4,
  "apr.": 4,
  "jun": 6,
  "jun.": 6,
  "jul": 7,
  "jul.": 7,
  "aug": 8,
  "aug.": 8,
  "sep": 9,
  "sep.": 9,
  "sept": 9,
  "sept.": 9,
  "oct": 10,
  "oct.": 10,
  "nov": 11,
  "nov.": 11,
  "dec": 12,
  "dec.": 12,
};

final Map<String, int> INTEGER_WORD_DICTIONARY = {
  "one": 1,
  "two": 2,
  "three": 3,
  "four": 4,
  "five": 5,
  "six": 6,
  "seven": 7,
  "eight": 8,
  "nine": 9,
  "ten": 10,
  "eleven": 11,
  "twelve": 12
};

final Map<String, int> ORDINAL_WORD_DICTIONARY = {
  "first": 1,
  "second": 2,
  "third": 3,
  "fourth": 4,
  "fifth": 5,
  "sixth": 6,
  "seventh": 7,
  "eighth": 8,
  "ninth": 9,
  "tenth": 10,
  "eleventh": 11,
  "twelfth": 12,
  "thirteenth": 13,
  "fourteenth": 14,
  "fifteenth": 15,
  "sixteenth": 16,
  "seventeenth": 17,
  "eighteenth": 18,
  "nineteenth": 19,
  "twentieth": 20,
  "twenty first": 21,
  "twenty-first": 21,
  "twenty second": 22,
  "twenty-second": 22,
  "twenty third": 23,
  "twenty-third": 23,
  "twenty fourth": 24,
  "twenty-fourth": 24,
  "twenty fifth": 25,
  "twenty-fifth": 25,
  "twenty sixth": 26,
  "twenty-sixth": 26,
  "twenty seventh": 27,
  "twenty-seventh": 27,
  "twenty eighth": 28,
  "twenty-eighth": 28,
  "twenty ninth": 29,
  "twenty-ninth": 29,
  "thirtieth": 30,
  "thirty first": 31,
  "thirty-first": 31
};

final Map<String, String> TIME_UNIT_DICTIONARY_NO_ABBR = {
  "second": "second",
  "seconds": "second",
  "minute": "minute",
  "minutes": "minute",
  "hour": "hour",
  "hours": "hour",
  "day": "d",
  "days": "d",
  "week": "week",
  "weeks": "week",
  "month": "month",
  "months": "month",
  "quarter": "quarter",
  "quarters": "quarter",
  "year": "year",
  "years": "year"
};

final Map<String, String> TIME_UNIT_DICTIONARY = {
  "s": "second",
  "sec": "second",
  "second": "second",
  "seconds": "second",
  "m": "minute",
  "min": "minute",
  "mins": "minute",
  "minute": "minute",
  "minutes": "minute",
  "h": "hour",
  "hr": "hour",
  "hrs": "hour",
  "hour": "hour",
  "hours": "hour",
  "d": "d",
  "day": "d",
  "days": "d",
  "w": "w",
  "week": "week",
  "weeks": "week",
  "mo": "month",
  "mon": "month",
  "mos": "month",
  "month": "month",
  "months": "month",
  "qtr": "quarter",
  "quarter": "quarter",
  "quarters": "quarter",
  "y": "year",
  "yr": "year",
  "year": "year",
  "years": "year",
};
//-----------------------------
final NUMBER_PATTERN =
    '''(?:${matchAnyPattern(INTEGER_WORD_DICTIONARY)}|[0-9]+|[0-9]+\\.[0-9]+|half(?:\\s{0,2}an?)?|an?\\b(?:\\s{0,2}few)?|few|several|the|a?\\s{0,2}couple\\s{0,2}(?:of)?)''';

num parseNumberPattern(String match) {
  final num = match.toLowerCase();
  if (INTEGER_WORD_DICTIONARY[num] != null) {
    return INTEGER_WORD_DICTIONARY[num]!;
  } else if (identical(num, "a") || identical(num, "an") || num == "the") {
    return 1;
  } else if (num.match(new RegExp(r'few'))) {
    return 3;
  } else if (num.match(new RegExp(r'half'))) {
    return 0.5;
  } else if (num.match(new RegExp(r'couple'))) {
    return 2;
  } else if (num.match(new RegExp(r'several'))) {
    return 7;
  }
  return double.parse(num);
}

//-----------------------------
final ORDINAL_NUMBER_PATTERN =
    '''(?:${matchAnyPattern(ORDINAL_WORD_DICTIONARY)}|[0-9]{1,2}(?:st|nd|rd|th)?)''';

int parseOrdinalNumberPattern(String match) {
  var num = match.toLowerCase();
  if (ORDINAL_WORD_DICTIONARY[num] != null) {
    return ORDINAL_WORD_DICTIONARY[num]!;
  }
  num =
      num.replaceAll(new RegExp(r'(?:st|nd|rd|th)$', caseSensitive: false), "");
  return int.parse(num);
}

//-----------------------------
final YEAR_PATTERN =
    '''(?:[1-9][0-9]{0,3}\\s{0,2}(?:BE|AD|BC|BCE|CE)|[1-2][0-9]{3}|[5-9][0-9])''';

num parseYear(String match) {
  if (new RegExp(r'BE', caseSensitive: false).hasMatch(match)) {
    // Buddhist Era
    match = match.replaceAll(new RegExp(r'BE', caseSensitive: false), "");
    return int.parse(match) - 543;
  }
  if (new RegExp(r'BCE?', caseSensitive: false).hasMatch(match)) {
    // Before Christ, Before Common Era
    match = match.replaceAll(new RegExp(r'BCE?', caseSensitive: false), "");
    return -int.parse(match);
  }
  if (new RegExp(r'(AD|CE)', caseSensitive: false).hasMatch(match)) {
    // Anno Domini, Common Era
    match = match.replaceAll(new RegExp(r'(AD|CE)', caseSensitive: false), "");
    return int.parse(match);
  }
  final rawYearNumber = int.parse(match);
  return findMostLikelyADYear(rawYearNumber);
}

//-----------------------------
final SINGLE_TIME_UNIT_PATTERN =
    '''(${NUMBER_PATTERN})\\s{0,3}(${matchAnyPattern(TIME_UNIT_DICTIONARY)})''';

final SINGLE_TIME_UNIT_REGEX =
    new RegExp(SINGLE_TIME_UNIT_PATTERN, caseSensitive: false);

final SINGLE_TIME_UNIT_NO_ABBR_PATTERN =
    '''(${NUMBER_PATTERN})\\s{0,3}(${matchAnyPattern(TIME_UNIT_DICTIONARY_NO_ABBR)})''';

final TIME_UNITS_PATTERN = repeatedTimeunitPattern(
    '''(?:(?:about|around)\\s{0,3})?''', SINGLE_TIME_UNIT_PATTERN);

final TIME_UNITS_NO_ABBR_PATTERN = repeatedTimeunitPattern(
    '''(?:(?:about|around)\\s{0,3})?''', SINGLE_TIME_UNIT_NO_ABBR_PATTERN);

TimeUnits parseTimeUnits(timeunitText) {
  final TimeUnits fragments = {};
  var remainingText = timeunitText;
  var match = SINGLE_TIME_UNIT_REGEX.exec(remainingText);
  while (match?.matches != null && match!.matches.isNotEmpty) {
    collectDateTimeFragment(fragments, match);
    remainingText = remainingText.substring(match[0].length).trim();
    match = SINGLE_TIME_UNIT_REGEX.exec(remainingText);
  }
  return fragments;
}

collectDateTimeFragment(fragments, match) {
  final num = parseNumberPattern(match[1]);
  final unit = TIME_UNIT_DICTIONARY[match[2].toLowerCase()];
  fragments[unit] = num;
}

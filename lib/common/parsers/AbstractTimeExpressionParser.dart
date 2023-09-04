import "package:chrono/ported/RegExpMatchArray.dart";

import "../../chrono.dart" show Parser, ParsingContext;
import "../../results.dart"
    show ParsingComponents, ParsingResult, ReferenceWithTimezone;
import "../../types.dart" show Component, Meridiem;

// prettier-ignore
primaryTimePattern(String leftBoundary, String primaryPrefix,
    String primarySuffix, String flags) {
  return new RegExp(
      '''${leftBoundary}''' +
          '''${primaryPrefix}''' +
          '''(\\d{1,4})''' +
          '''(?:''' +
          '''(?:\\.|:|：)''' +
          '''(\\d{1,2})''' +
          '''(?:''' +
          '''(?::|：)''' +
          '''(\\d{2})''' +
          '''(?:\\.(\\d{1,6}))?''' +
          ''')?''' +
          ''')?''' +
          '''(?:\\s*(a\\.m\\.|p\\.m\\.|am?|pm?))?''' +
          '''${primarySuffix}''',
      caseSensitive: flags.contains("i"),
      unicode: flags.contains('u'),
      dotAll: flags.contains('d'),
      multiLine: flags.contains('m'));
}

// prettier-ignore
followingTimePatten(String followingPhase, String followingSuffix) {
  return new RegExp(
      '''^(${followingPhase})''' +
          '''(\\d{1,4})''' +
          '''(?:''' +
          '''(?:\\.|\\:|\\：)''' +
          '''(\\d{1,2})''' +
          '''(?:''' +
          '''(?:\\.|\\:|\\：)''' +
          '''(\\d{1,2})(?:\\.(\\d{1,6}))?''' +
          ''')?''' +
          ''')?''' +
          '''(?:\\s*(a\\.m\\.|p\\.m\\.|am?|pm?))?''' +
          '''${followingSuffix}''',
      caseSensitive: false);
}

const HOUR_GROUP = 2;
const MINUTE_GROUP = 3;
const SECOND_GROUP = 4;
const MILLI_SECOND_GROUP = 5;
const AM_PM_HOUR_GROUP = 6;

abstract class AbstractTimeExpressionParser implements Parser {
  String primaryPrefix();

  String followingPhase();

  late bool strictMode;

  AbstractTimeExpressionParser([strictMode = false]) {
    this.strictMode = strictMode;
  }

  String patternFlags() {
    return "i";
  }

  String primaryPatternLeftBoundary() {
    return '''(^|\\s|T|\\b)''';
  }

  String primarySuffix() {
    return '''(?=\\W|\$)''';
  }

  String followingSuffix() {
    return '''(?=\\W|\$)''';
  }

  RegExp pattern(ParsingContext context) {
    return this.getPrimaryTimePatternThroughCache();
  }

  ParsingResult? extract(ParsingContext context, RegExpMatchArray match) {
    if(!match[AM_PM_HOUR_GROUP].toLowerCase().contains("m")){
      match.matches[AM_PM_HOUR_GROUP] = null;
    }
    final startComponents = this.extractPrimaryTimeComponents(context, match);
    if (startComponents == null) {
      match.index += match[0].length;
      return ParsingResult(ReferenceWithTimezone(null), 0,
          ""); //todo dummy ParsingResult instead of null
    }
    final index = match.index + match[1].length;
    final text = match[0].substring(match[1].length);
    final result = context.createParsingResult(index, text, startComponents);
    match.index += match[0].length;
    final remainingText = context.text.substring(match.index);
    final followingPattern = this.getFollowingTimePatternThroughCache();
    final followingMatch = followingPattern.exec(remainingText);
    // Pattern "456-12", "2022-12" should not be time without proper context
    if (RegExp(r'^\d{3,4}').firstMatch(text) != null &&
        followingMatch != null &&
        RegExp(r'^\s*([+-])\s*\d{2,4}$').firstMatch(followingMatch[0]) !=null) {
      return null;
    }
    if (followingMatch == null ||
        // Pattern "YY.YY -XXXX" is more like timezone offset
        RegExp(r'^\s*([+-])\s*\d{3,4}$').firstMatch(followingMatch[0]) != null
    ) {
      return this.checkAndReturnWithoutFollowingPattern(result);
    }
    result.end =
        this.extractFollowingTimeComponents(context, followingMatch, result);
    if (result.end != null) {
      result.text += followingMatch[0];
    }
    return this.checkAndReturnWithFollowingPattern(result);
  }

  ParsingComponents? extractPrimaryTimeComponents(
      ParsingContext context, RegExpMatchArray match,
      [strict = false]) {
    final components = context.createParsingComponents();
    var minute = 0;
    int? meridiem = null;
    // ----- Hours
    var hour = int.tryParse(match[HOUR_GROUP]);
    if(hour == null){
      return null;
    }
    if (hour > 100) {
      if (this.strictMode || match[MINUTE_GROUP].isNotEmpty) {
        return null;
      }
      minute = hour % 100;
      hour = (hour / 100).floor();
    }
    if (hour > 24) {
      return null;
    }
    // ----- Minutes
    if (match[MINUTE_GROUP].isNotEmpty) {
      if (match[MINUTE_GROUP].length == 1 &&
          match.matches.length > AM_PM_HOUR_GROUP &&
          match.matches[AM_PM_HOUR_GROUP] != null) {
        // Skip single digit minute e.g. "at 1.1 xx"
        return null;
      }
      minute = int.parse(match[MINUTE_GROUP]);
    }
    if (minute >= 60) {
      return null;
    }
    if (hour > 12) {
      meridiem = Meridiem.PM.index;
    }
    // ----- AM & PM
    if (match[AM_PM_HOUR_GROUP].isNotEmpty) {
      if (hour > 12) return null;
      final ampm = match[AM_PM_HOUR_GROUP][0].toLowerCase();
      if (ampm == "a") {
        meridiem = Meridiem.AM.index;
        if (hour == 12) {
          hour = 0;
        }
      }
      if (ampm == "p") {
        meridiem = Meridiem.PM.index;
        if (hour != 12) {
          hour += 12;
        }
      }
    }
    components.assign(Component.hour, hour);
    components.assign(Component.minute, minute);
    if (!identical(meridiem, null)) {
      components.assign(Component.meridiem, meridiem);
    } else {
      if (hour < 12) {
        components.imply(Component.meridiem, Meridiem.AM.index);
      } else {
        components.imply(Component.meridiem, Meridiem.PM.index);
      }
    }
    // ----- Millisecond
    if (match[MILLI_SECOND_GROUP].isNotEmpty) {
      final millisecond = int.parse(match[MILLI_SECOND_GROUP].substring(0, 3));
      if (millisecond >= 1000) return null;
      components.assign(Component.millisecond, millisecond);
    }
    // ----- Second
    if (match[SECOND_GROUP].isNotEmpty) {
      final second = int.parse(match[SECOND_GROUP]);
      if (second >= 60) return null;
      components.assign(Component.second, second);
    }
    return components;
  }

  dynamic /* null | ParsingComponents */ extractFollowingTimeComponents(
      ParsingContext context, RegExpMatchArray match, ParsingResult result) {
    final components = context.createParsingComponents();
    // ----- Millisecond
    if (match[MILLI_SECOND_GROUP].isNotEmpty) {
      final millisecond = int.parse(match[MILLI_SECOND_GROUP].substring(0, 3));
      if (millisecond >= 1000) return null;
      components.assign(Component.millisecond, millisecond);
    }
    // ----- Second
    if (match[SECOND_GROUP].isNotEmpty) {
      final second = int.parse(match[SECOND_GROUP]);
      if (second >= 60) return null;
      components.assign(Component.second, second);
    }
    var hour = int.parse(match[HOUR_GROUP]);
    var minute = 0;
    var meridiem = -1;
    // ----- Minute
    if (match[MINUTE_GROUP].isNotEmpty) {
      minute = int.parse(match[MINUTE_GROUP]);
    } else if (hour > 100) {
      minute = hour % 100;
      hour = (hour / 100).floor();
    }
    if (minute >= 60 || hour > 24) {
      return null;
    }
    if (hour >= 12) {
      meridiem = Meridiem.PM.index;
    }
    // ----- AM & PM
    if (match[AM_PM_HOUR_GROUP].isNotEmpty) {
      if (hour > 12) {
        return null;
      }
      final ampm = match[AM_PM_HOUR_GROUP][0].toLowerCase();
      if (ampm == "a") {
        meridiem = Meridiem.AM.index;
        if (hour == 12) {
          hour = 0;
          if (!components.isCertain(Component.day)) {
            components.imply(
                Component.day, components.get(Component.day)!.toInt() + 1);
          }
        }
      }
      if (ampm == "p") {
        meridiem = Meridiem.PM.index;
        if (hour != 12) hour += 12;
      }
      if (!result.start.isCertain(Component.meridiem)) {
        if (meridiem == Meridiem.AM) {
          result.start.imply(Component.meridiem, Meridiem.AM.index);
          if (result.start.get(Component.hour) == 12) {
            result.start.assign(Component.hour, 0);
          }
        } else {
          result.start.imply(Component.meridiem, Meridiem.PM.index);
          if (result.start.get(Component.hour) != 12) {
            result.start.assign(Component.hour,
                result.start.get(Component.hour)! + 12); //todo added !
          }
        }
      }
    }
    components.assign(Component.hour, hour);
    components.assign(Component.minute, minute);
    if (meridiem >= 0) {
      components.assign(Component.meridiem, meridiem);
    } else {
      final startAtPM = result.start.isCertain(Component.meridiem) &&
          result.start.get(Component.hour) != null &&
          result.start.get(Component.hour)! > 12; //toDO NULL check
      if (startAtPM) {
        if (result.start.get(Component.hour)! - 12 > hour) {
          //todo added !
          // 10pm - 1 (am)
          components.imply(Component.meridiem, Meridiem.AM.index);
        } else if (hour <= 12) {
          components.assign(Component.hour, hour + 12);
          components.assign(Component.meridiem, Meridiem.PM.index);
        }
      } else if (hour > 12) {
        components.imply(Component.meridiem, Meridiem.PM.index);
      } else if (hour <= 12) {
        components.imply(Component.meridiem, Meridiem.AM.index);
      }
    }
    if (components.date().millisecondsSinceEpoch <
        result.start.date().millisecondsSinceEpoch) {
      components.imply(
          Component.day, components.get(Component.day)!.toInt() + 1);
    }
    return components;
  }

  checkAndReturnWithoutFollowingPattern(ParsingResult result) {
    // Single digit (e.g "1") should not be counted as time expression (without proper context)
    if (result.text.match(new RegExp(r'^\d$'))) {
      return null;
    }
    // Three or more digit (e.g. "203", "2014") should not be counted as time expression (without proper context)
    if (result.text.match(new RegExp(r'^\d\d\d+$'))) {
      return null;
    }
    // Instead of "am/pm", it ends with "a" or "p" (e.g "1a", "123p"), this seems unlikely
    if (result.text.match(new RegExp(r'\d[apAP]$'))) {
      return null;
    }
    // If it ends only with numbers or dots
    final endingWithNumbers = RegExp(r'[^\d:.](\d[\d.]+)$').exec(result.text);
        // result.text.match(new RegExp(r'[^\d:.](\d[\d.]+)$'));
    if (endingWithNumbers != null && endingWithNumbers.matches.isNotEmpty) {
      final String endingNumbers = endingWithNumbers[1];
      // In strict mode (e.g. "at 1" or "at 1.2"), this should not be accepted
      if (this.strictMode) {
        return null;
      }
      // If it ends only with dot single digit, e.g. "at 1.2"
      if (endingNumbers.contains(".") &&
          (new RegExp(r'\d(\.\d{2})+$').exec(endingNumbers)?.matches.isEmpty ??
              true)) {
        //todo added isEmpty instead of !
        return null;
      }
      // If it ends only with numbers above 24, e.g. "at 25"
      final endingNumberVal = int.parse(endingNumbers);
      if (endingNumberVal > 24) {
        return null;
      }
    }
    return result;
  }

  checkAndReturnWithFollowingPattern(result) {
    if (result.text.match(new RegExp(r'^\d+-\d+$'))) {
      return null;
    }
    // If it ends only with numbers or dots
    final endingWithNumbers =
        result.text.match(new RegExp(r'[^\d:.](\d[\d.]+)\s*-\s*(\d[\d.]+)$'));
    if (endingWithNumbers) {
      // In strict mode (e.g. "at 1-3" or "at 1.2 - 2.3"), this should not be accepted
      if (this.strictMode) {
        return null;
      }
      final String startingNumbers = endingWithNumbers[1];
      final String endingNumbers = endingWithNumbers[2];
      // If it ends only with dot single digit, e.g. "at 1.2"
      if (endingNumbers.contains(".") &&
          (new RegExp(r'\d(\.\d{2})+$').exec(endingNumbers)?.matches.isEmpty ??
              true)) {
        return null;
      }
      // If it ends only with numbers above 24, e.g. "at 25"
      final endingNumberVal = int.parse(endingNumbers);
      final startingNumberVal = int.parse(startingNumbers);
      if (endingNumberVal > 24 || startingNumberVal > 24) {
        return null;
      }
    }
    return result;
  }

  var cachedPrimaryPrefix = null;
  var cachedPrimarySuffix = null;
  var cachedPrimaryTimePattern = null;

  getPrimaryTimePatternThroughCache() {
    final primaryPrefix = this.primaryPrefix();
    final primarySuffix = this.primarySuffix();
    if (identical(this.cachedPrimaryPrefix, primaryPrefix) &&
        identical(this.cachedPrimarySuffix, primarySuffix)) {
      return this.cachedPrimaryTimePattern;
    }
    this.cachedPrimaryTimePattern = primaryTimePattern(
        this.primaryPatternLeftBoundary(),
        primaryPrefix,
        primarySuffix,
        this.patternFlags());
    this.cachedPrimaryPrefix = primaryPrefix;
    this.cachedPrimarySuffix = primarySuffix;
    return this.cachedPrimaryTimePattern;
  }

  var cachedFollowingPhase = null;
  var cachedFollowingSuffix = null;
  var cachedFollowingTimePatten = null;

  RegExp getFollowingTimePatternThroughCache() {
    final followingPhase = this.followingPhase();
    final followingSuffix = this.followingSuffix();
    if (identical(this.cachedFollowingPhase, followingPhase) &&
        identical(this.cachedFollowingSuffix, followingSuffix)) {
      return this.cachedFollowingTimePatten;
    }
    this.cachedFollowingTimePatten =
        followingTimePatten(followingPhase, followingSuffix);
    this.cachedFollowingPhase = followingPhase;
    this.cachedFollowingSuffix = followingSuffix;
    return this.cachedFollowingTimePatten;
  }
}

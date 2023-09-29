import "package:chrono/ported/RegExpMatchArray.dart";
import "package:chrono/types.dart";

import "../../results.dart" show ParsingResult;
import "../abstractRefiners.dart" show Filter;

class UnlikelyFormatFilter extends Filter {
  bool strictMode;

  UnlikelyFormatFilter(this.strictMode) : super() {
    /* super call moved to initializer */;
  }

  @override
  bool isValid(context, ParsingResult result) {
    if (RegExp(r'^\d*(\.\d*)?$').exec(result.text) != null) {
      context.debug(() {
        print('''Removing unlikely result \'${result.text}\'''');
      });
      return false;
    }
    if (!result.start.isValidDate()) {
      context.debug(() {
        print('''Removing invalid result: $result (${result.start})''');
      });
      return false;
    }
    if (result.end != null && !result.end!.isValidDate()) {
      context.debug(() {
        print('''Removing invalid result: $result (${result.end})''');
      });
      return false;
    }
    if (strictMode) {
      return isStrictModeValid(context, result);
    }
    return true;
  }

  isStrictModeValid(context, ParsingResult result) {
    if (result.start.isOnlyWeekdayComponent()) {
      context.debug(() {
        print(
            '''(Strict) Removing weekday only component: $result (${result.end})''');
      });
      return false;
    }
    if (result.start.isOnlyTime() &&
        (!result.start.isCertain(Component.hour) ||
            !result.start.isCertain(Component.minute))) {
      context.debug(() {
        print(
            '''(Strict) Removing uncertain time component: $result (${result.end})''');
      });
      return false;
    }
    return true;
  }
}

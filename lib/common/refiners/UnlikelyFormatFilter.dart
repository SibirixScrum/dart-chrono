import "package:chrono/types.dart";

import "../abstractRefiners.dart" show Filter;
import "../../results.dart" show ParsingResult;

class UnlikelyFormatFilter extends Filter {
  bool strictMode;
  UnlikelyFormatFilter(this.strictMode) : super() {
    /* super call moved to initializer */;
  }
  bool isValid(context, ParsingResult result) {
    if (new RegExp(r'^\d*(\.\d*)?$').allMatches(result.text.replaceAll(" ", "")).isNotEmpty) {
      context.debug(() {
        print('''Removing unlikely result \'${ result . text}\'''');
      });
      return false;
    }
    if (!result.start.isValidDate()) {
      context.debug(() {
        print(
            '''Removing invalid result: ${ result} (${ result . start})''');
      });
      return false;
    }
    if (result.end != null && !result.end!.isValidDate()) {
      context.debug(() {
        print('''Removing invalid result: ${ result} (${ result . end})''');
      });
      return false;
    }
    if (this.strictMode) {
      return this.isStrictModeValid(context, result);
    }
    return true;
  }

  isStrictModeValid(context, ParsingResult result) {
    if (result.start.isOnlyWeekdayComponent()) {
      context.debug(() {
        print(
            '''(Strict) Removing weekday only component: ${ result} (${ result . end})''');
      });
      return false;
    }
    if (result.start.isOnlyTime() &&
        (!result.start.isCertain(Component.hour) ||
            !result.start.isCertain(Component.minute))) {
      context.debug(() {
        print(
            '''(Strict) Removing uncertain time component: ${ result} (${ result . end})''');
      });
      return false;
    }
    return true;
  }
}

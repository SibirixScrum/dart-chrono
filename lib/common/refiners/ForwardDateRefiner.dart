/*
    Enforce 'forwardDate' option to on the results. When there are missing component,
    e.g. "March 12-13 (without year)" or "Thursday", the refiner will try to adjust the result
    into the future instead of the past.
*/
import "package:chrono/types.dart";

import "../../chrono.dart" show ParsingContext, Refiner;
import "../../results.dart" show ParsingResult;
import "../../utils/dayjs.dart" show implySimilarDate;

class ForwardDateRefiner implements Refiner {
  List<ParsingResult> refine(
      ParsingContext context, List<ParsingResult> results) {
    if (context.option?.forwardDate != true) {
      return results;
    }
    results.forEach((result) {
      var refMoment = context.refDate;
      if (result.start.isOnlyTime() && refMoment.isAfter(result.start.date())) {
        refMoment = refMoment.add(Duration(days: 1));
        implySimilarDate(result.start, refMoment);
        if (result.end != null && result.end!.isOnlyTime()) {
          implySimilarDate(result.end!, refMoment);
          if (result.start.date().isAfter(result.end!.date())) {
            refMoment = refMoment.add(Duration(days: 1));
            implySimilarDate(result.end!, refMoment);
          }
        }
      }
      if (result.start.isOnlyWeekdayComponent() &&
          refMoment.isAfter(result.start.date())) {
        if (refMoment.weekday >= result.start.get(Component.weekday)!.toInt()) {

          // refMoment = refMoment.subtract(Duration(days: result.start.get(Component.weekday)!.toInt() - 1));
          final difference =
              refMoment.weekday % 7 - result.start.get(Component.weekday)!.toInt();
          refMoment = refMoment.add(Duration(days: 7));
          refMoment = refMoment.add(Duration(days: -difference));
          // refMoment = refMoment.add(Duration(
          //     days: difference > 0 ? 7 - difference : 7 + difference.abs()));
          // refMoment = refMoment.copyWith(
          //     day: result.start.get(Component.weekday)!.toInt() +
          //         7); // day(result.start.get(Component.weekday)!.toInt() + 7);
        } else {
          final difference =
              refMoment.weekday % 7 - result.start.get(Component.weekday)!.toInt();
          refMoment = refMoment.add(Duration(days: -difference));
        }
        result.start.imply(Component.day, refMoment.day);
        result.start.imply(Component.month, refMoment.month);
        result.start.imply(Component.year, refMoment.year);
        context.debug(() {
          print('''Forward weekly adjusted for ${result} (${result.start})''');
        });
        if (result.end != null && result.end!.isOnlyWeekdayComponent()) {
          // Adjust date to the coming week
          if (refMoment.weekday > result.end!.get(Component.weekday)!.toInt()) {
            refMoment = refMoment.copyWith(
                day: result.end!.get(Component.weekday)!.toInt() +
                    7); // refMoment.day(result.end!.get(Component.weekday)!.toInt() + 7); //todo added (Component.weekday)!
          } else {
            refMoment = refMoment.copyWith(
                day: (result.end!.get(Component.weekday) as num)
                    .toInt()); //refMoment.day((result.end!.get(Component.weekday) as num));
          }
          result.end!.imply(Component.day, refMoment.day);
          result.end!.imply(Component.month, refMoment.month);
          result.end!.imply(Component.year, refMoment.year);
          context.debug(() {
            print('''Forward weekly adjusted for ${result} (${result.end})''');
          });
        }
      }
      // In case where we know the month, but not which year (e.g. "in December", "25th December"),

      // try move to another year
      if (result.start.isDateWithUnknownYear() &&
          refMoment.isAfter(result.start.date())) {
        for (var i = 0; i < 3 && refMoment.isAfter(result.start.date()); i++) {
          result.start.imply(
              Component.year, result.start.get(Component.year)!.toInt() + 1);
          context.debug(() {
            print(
                '''Forward yearly adjusted for ${result} (${result.start})''');
          });
          if (result.end != null && !result.end!.isCertain(Component.year)) {
            result.end!.imply(
                Component.year, result.end!.get(Component.year)!.toInt() + 1);
            context.debug(() {
              print(
                  '''Forward yearly adjusted for ${result} (${result.end})''');
            });
          }
        }
      }
    });
    return results;
  }
}

/**
 * Find the most likely year, from a raw number. For example:
 * 1997 => 1997
 * 97 => 1997
 * 12 => 2012
 */
num findMostLikelyADYear(num yearNumber) {
  if (yearNumber < 100) {
    if (yearNumber > 50) {
      yearNumber = yearNumber + 1900;
    } else {
      yearNumber = yearNumber + 2000;
    }
  }
  return yearNumber;
}

num findYearClosestToRef(DateTime refDate, num day, num month) {
  //Find the most appropriated year
  final refMoment = refDate;
  var dateMoment = refMoment;
  dateMoment = dateMoment.copyWith(month: month.toInt());
  dateMoment = dateMoment.copyWith(day: day.toInt());
  dateMoment = dateMoment.copyWith(
      year: refMoment.year); // dateMoment.year(refMoment.year());
  final nextYear = dateMoment.copyWith(year: dateMoment.year + 1);
  final lastYear = dateMoment.copyWith(year: dateMoment.year + 1);
  if ((nextYear.millisecondsSinceEpoch - refMoment.millisecondsSinceEpoch)
          .abs() <
      (dateMoment.millisecondsSinceEpoch - refMoment.millisecondsSinceEpoch)
          .abs()) {
    dateMoment = nextYear;
  } else if ((lastYear.millisecondsSinceEpoch -
              refMoment.millisecondsSinceEpoch)
          .abs() <
      (dateMoment.millisecondsSinceEpoch - refMoment.millisecondsSinceEpoch)
          .abs()) {
    dateMoment = lastYear;
  }
  return dateMoment.year;
}

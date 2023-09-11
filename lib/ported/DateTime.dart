extension DateTimeUtil on DateTime {
  DateTime addQuarter(int num) {
    if (num == 0) {
      return this;
    }
    int currentQuarter = (month + 2) ~/ 3;
    DateTime date = copyWith(month: currentQuarter * 3 * num + 1);
    // date = date.copyWith(month: date.month + num * 3);
    return date;
    // this.month = currentQuarter*3;
  }
}

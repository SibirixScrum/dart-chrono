extension DateTimeUtil on DateTime {
  DateTime addQuarter(int num) {
    if (num == 0) {
      return this;
    }
    int currentQuarter = (this.month + 2) ~/ 3;
    DateTime date = this.copyWith(month: currentQuarter * 3 * num + 1);
    // date = date.copyWith(month: date.month + num * 3);
    return date;
    // this.month = currentQuarter*3;
  }
}

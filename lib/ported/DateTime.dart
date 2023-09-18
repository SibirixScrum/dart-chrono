import 'package:chrono/results.dart';

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

  DateTime withLowerFieldsNullified(String field){
    if(!ParsingComponents.allFragmentKeys.contains(field)){
      throw Exception("$field must be one of ${ParsingComponents.allFragmentKeys}");
    }
    switch(field){
      case "year":
        return DateTime(year,1,1,hour,minute,second,millisecond,microsecond);
      case "quarter":
        throw Exception("field cannot be quarter in this function");
      case "month":
        return DateTime(year,month,1,hour,minute,second,millisecond,microsecond);
      case "week":
        throw Exception("field cannot be week in this function");
      case "day":
        return DateTime(year,month,day,0,0,0,0,0);
      case "d":
        return DateTime(year,month,day,0,0,0,0,0);
      case "hour":
        return DateTime(year,month,day,hour,0,0,0,0);
      case "minute":
        return DateTime(year,month,day,hour,minute,0,0,0);
      case "second":
        return DateTime(year,month,day,hour,minute,second,0,0);
    }
    throw Exception("should not reach this line, wtf");
  }
}

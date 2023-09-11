String? or(String? a, String? b) {
  if (a != null && a.isNotEmpty) {
    return a;
  } else if (b != null) {
    return b;
  } else {
    return null;
  }
}

extension StringUtils on String {
  bool isDigitOrSign() {
    if (length > 1) {
      return false;
    } else {
      return RegExp(r'^[0-9-+]+$').hasMatch(this);
    }
  }
  String substringTs(int start,[int? end]){
    // return this.substring(start,end);

    if(end!=null){
      if(start>end) {
        return substringTs(end, start);
      }
      if(start>=length){
        return "";
      }
      if(end>length){
        return substring(start,length);
      }
      return substring(start,end);
    }else{
      return substring(start,end);
    }
  }
}

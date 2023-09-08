
import 'dart:math';

import 'package:chrono/ported/StringUtils.dart';


  int parseIntTs(String str){
    var firstNonDigitIndex = 0;
    final len = str.length;
    while(firstNonDigitIndex<len && str[firstNonDigitIndex].isDigitOrSign() ){
      firstNonDigitIndex++;
    }
    return int.parse(str.substringTs(0, firstNonDigitIndex));
  }

import 'package:chrono/locales/en/index.dart' as en;
import "package:flutter_test/flutter_test.dart";

import '../test_util.dart';

 void main() {
   test("Test - Benchmarking against whitespace backtracking", () {
     final time = measureMilliSec(() {
       final str = "BGR3                                                                                         " +
           "                                                                                        186          " +
           "                                      days                                                           " +
           "                                                                                                     " +
          "                                                                                                     " +
          "           18                                                hours                                   " +
          "                                                                                                     " +
          "                                                                                                     " +
          "                                   37                                                minutes         " +
          "                                                                                                     " +
          "                                                                                                     " +
          "                                                             01                                      " +
          "          seconds";
      final results = en.casual.parse(str);
      expect(results.length, 0);
    });
     expect(time<1000,true);
   });
 }
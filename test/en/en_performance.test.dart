 import "../../src.dart" as chrono ; import "../test_util.dart" show measureMilliSec ;
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
       final results = chrono.parse(str);
       expect(results.length).toBe(0);
     });
     expect(time).toBeLessThan(1000);
   });
 }
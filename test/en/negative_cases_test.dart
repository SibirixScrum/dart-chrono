import 'package:chrono/locales/en/index.dart' as en;
import 'package:chrono/types.dart';
import "package:flutter_test/flutter_test.dart";

import '../test_util.dart';

 void main() {
   test("Test - Skip random non-date patterns", () {
    testUnexpectedResult(en.casual, " 3");
    testUnexpectedResult(en.casual, "       1");
    testUnexpectedResult(en.casual, "  11 ");
    testUnexpectedResult(en.casual, " 0.5 ");
    testUnexpectedResult(en.casual, " 35.49 ");
    testUnexpectedResult(en.casual, "12.53%");
    testUnexpectedResult(en.casual, "6358fe2310> *5.0* / 5 Outstanding");
    testUnexpectedResult(en.casual, "6358fe2310> *1.5* / 5 Outstanding");
    testUnexpectedResult(
        en.casual, "Total: \$1,194.09 [image: View Reservation");
    testUnexpectedResult(en.casual, "at 6.5 kilograms");
    testUnexpectedResult(en.casual, "ah that is unusual", null,
        ParsingOption(forwardDate: true));
  });
  test("Test - URLs % encoded", () {
    testUnexpectedResult(en.casual, "%e7%b7%8a");
    testUnexpectedResult(
        en.casual,
        "https://tenor.com/view/%e3%83%89%e3%82%ad%e3%83%89%e3%82%ad-" +
            "%e7%b7%8a%e5%bc%b5-%e5%a5%bd%e3%81%8d-%e3%83%8f%e3%83%bc%e3%83%88" +
            "-%e5%8f%af%e6%84%9b%e3%81%84-gif-15876325");
  });
  test("Test - Skip hyphenated numbers pattern", () {
    testUnexpectedResult(en.casual, "1-2");
    testUnexpectedResult(en.casual, "1-2-3");
    testUnexpectedResult(en.casual, "4-5-6");
     testUnexpectedResult(en.casual, "20-30-12");
     testUnexpectedResult(en.casual, "2012");
     testUnexpectedResult(en.casual, "2012-14");
     testUnexpectedResult(en.casual, "2012-1400");
     testUnexpectedResult(en.casual, "2200-25");
   });
   test("Test - Skip impossible dates/times", () {
     testUnexpectedResult(en.casual, "February 29, 2022");
     testUnexpectedResult(en.casual, "02/29/2022");
     testUnexpectedResult(en.casual, "June 31, 2022");
     testUnexpectedResult(en.casual, "06/31/2022");
    testUnexpectedResult(en.casual, "14PM");
    testUnexpectedResult(en.casual, "25:12");
    testUnexpectedResult(en.casual, "An appointment on 13/31/2018");
  });
  test("Test - Skip version number pattern", () {
    testUnexpectedResult(en.casual, "Version: 1.1.3");
    testUnexpectedResult(en.casual, "Version: 1.1.30");
    testUnexpectedResult(en.casual, "Version: 1.10.30");
  });
  test("Test - Date with version number pattern", () {
    testSingleCase(en.casual, "1.5.3 - 2015-09-24",
        (ParsedResult result, String text) {
      expect(result.text, "2015-09-24");
    });
    testSingleCase(en.casual, "1.5.30 - 2015-09-24",
        (ParsedResult result, String text) {
      expect(result.text, "2015-09-24");
    });
    testSingleCase(en.casual, "1.50.30 - 2015-09-24",
        (ParsedResult result, String text) {
      expect(result.text, "2015-09-24");
    });
  });
}
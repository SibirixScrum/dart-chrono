import 'package:chrono/locales/en/index.dart' as en;
import 'package:chrono/types.dart';
import "package:flutter_test/flutter_test.dart";

import '../test_util.dart';

 void main() {
   test("Test - Year numbers with BCE/CE Era label", () {
     testSingleCase(en.casual, "10 August 234 BCE", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "10 August 234 BCE");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), -234);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expectToBeDate(result.start , DateTime(-234, 8 , 10, 12));
    });
     testSingleCase(en.casual, "10 August 88 CE", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "10 August 88 CE");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 88);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      final resultDate = result.start.date();
      final expectDate = DateTime(88, 8 , 10, 12);
      // expectDate.setFullYear(88);
      expect(expectDate.millisecondsSinceEpoch,resultDate.millisecondsSinceEpoch);
    });
   });
   test("Test - Year numbers with BC/AD Era label", () {
     testSingleCase(en.casual, "10 August 234 BC", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "10 August 234 BC");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), -234);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expectToBeDate(result.start , DateTime(-234, 8 , 10, 12));
    });
     testSingleCase(en.casual, "10 August 88 AD", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "10 August 88 AD");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 88);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      final resultDate = result.start.date();
      final expectDate = DateTime(88, 8 , 10, 12);
      // expectDate.setFullYear(88);
      expect(expectDate.millisecondsSinceEpoch,
              resultDate.millisecondsSinceEpoch);
    });
   });
   test("Test - Year numbers with Buddhist Era label", () {
     testSingleCase(en.casual, "10 August 2555 BE", DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index, 0);
      expect(result.text, "10 August 2555 BE");
      expect(result.start == null, isFalse);
      expect(result.start.get(Component.year), 2012);
      expect(result.start.get(Component.month), 8);
      expect(result.start.get(Component.day), 10);
      expectToBeDate(result.start , DateTime(2012, 8 , 10, 12));
    });
   });
 }
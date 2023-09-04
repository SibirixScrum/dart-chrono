import 'package:chrono/locales/ru/index.dart' as ru;
import 'package:flutter_test/flutter_test.dart';
import "../test_util.dart" show expectToBeDate, testSingleCase;

void main() {
  test("Test - 'This' expressions", () {
    testSingleCase(ru.casual, "на этой неделе", new DateTime(2017, 11 - 1, 19, 12),
        (result, text) {
      expect(result.index,0);
      expect(result.text,text);
      expectToBeDate(result.start,new DateTime(2017, 11 - 1, 19, 12));
    });
    testSingleCase(ru.casual, "в этом месяце", new DateTime(2017, 11 - 1, 19, 12),
        (result, text) {
      expect(result.index,0);
      expect(result.text,text);
      expectToBeDate(result.start,new DateTime(2017, 11 - 1, 1, 12));
    });
    testSingleCase(ru.casual, "в этом месяце", new DateTime(2017, 11 - 1, 1, 12),
        (result, text) {
      expect(result.index,0);
      expect(result.text,text);
      expectToBeDate(result.start,new DateTime(2017, 11 - 1, 1, 12));
    });
    testSingleCase(ru.casual, "в этом году", new DateTime(2017, 11 - 1, 19, 12),
        (result, text) {
      expect(result.index,0);
      expect(result.text,text);
      expectToBeDate(result.start,new DateTime(2017, 1 - 1, 1, 12));
    });
  });
  test("Test - Past relative expressions", () {
    testSingleCase(
        ru.casual, "на прошлой неделе", new DateTime(2016, 10 - 1, 1, 12),
        (result, text) {
      expect(result.index,0);
      expect(result.text,text);
      expectToBeDate(result.start,new DateTime(2016, 9 - 1, 24, 12));
    });
    testSingleCase(ru.casual, "в прошлом месяце", new DateTime(2016, 10 - 1, 1, 12),
        (result, text) {
      expect(result.index,0);
      expect(result.text,text);
      expectToBeDate(result.start,new DateTime(2016, 9 - 1, 1, 12));
    });
    testSingleCase(ru.casual, "в прошлом году", new DateTime(2016, 10 - 1, 1, 12),
        (result, text) {
      expect(result.index,0);
      expect(result.text,text);
      expectToBeDate(result.start,new DateTime(2015, 10 - 1, 1, 12));
    });
  });
  test("Test - Future relative expressions", () {
    testSingleCase(
        ru.casual, "на следующей неделе", new DateTime(2016, 10 - 1, 1, 12),
        (result, text) {
      expect(result.index,0);
      expect(result.text,text);
      expectToBeDate(result.start,new DateTime(2016, 10 - 1, 8, 12));
    });
    testSingleCase(
        ru.casual, "в следующем месяце", new DateTime(2016, 10 - 1, 1, 12),
        (result, text) {
      expect(result.index,0);
      expect(result.text,text);
      expectToBeDate(result.start,new DateTime(2016, 11 - 1, 1, 12));
    });
    testSingleCase(
        ru.casual, "в следующем квартале", new DateTime(2016, 10 - 1, 1, 12),
        (result, text) {
      expect(result.index,0);
      expect(result.text,text);
      expectToBeDate(result.start,new DateTime(2017, 1 - 1, 1, 12));
    });
    testSingleCase(ru.casual, "в следующем году", new DateTime(2016, 10 - 1, 1, 12),
        (result, text) {
      expect(result.index,0);
      expect(result.text,text);
      expectToBeDate(result.start,new DateTime(2017, 10 - 1, 1, 12));
    });
  });
}

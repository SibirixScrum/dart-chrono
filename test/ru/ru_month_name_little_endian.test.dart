import 'package:chrono/locales/ru/index.dart' as ru;
import 'package:chrono/types.dart';
import 'package:flutter_test/flutter_test.dart';

import "../test_util.dart" show expectToBeDate, testSingleCase, testUnexpectedResult;

void main() {
  test("Test - Single expression", () {
    testSingleCase(ru.casual, "10.08.2012", new DateTime(2012, 7, 10),
         (ParsedResult result, String text) {
      expect(result.index,0);
      expect(result.text,"10.08.2012");
      expectToBeDate(result.start,new DateTime(2012, 8 - 1, 10, 12));
    });
    testSingleCase(ru.casual, "10 августа 2012", new DateTime(2012, 7, 10),
         (ParsedResult result, String text) {
      expect(result.index,0);
      expect(result.text,"10 августа 2012");
      expectToBeDate(result.start,new DateTime(2012, 8 - 1, 10, 12));
    });
    testSingleCase(ru.casual, "третье фев 82", new DateTime(2012, 7, 10),
    (ParsedResult result, String text) {
      expect(result.index,0);
      expect(result.text,"третье фев 82");
      expectToBeDate(result.start,new DateTime(1982, 2 - 1, 3, 12));
    });
    testSingleCase(ru.casual, "Дедлайн 10 августа", new DateTime(2012, 7, 10),
        (ParsedResult result, String text) {
      expect(result.index,8);
      expect(result.text,"10 августа");
      expectToBeDate(result.start,new DateTime(2012, 8 - 1, 10, 12));
    });
    testSingleCase(
        ru.casual, "Дедлайн Четверг, 10 января", new DateTime(2012, 7, 10),
         (ParsedResult result, String text) {
      expect(result.index,8);
      expect(result.text,"Четверг, 10 января");
      expectToBeDate(result.start,new DateTime(2013, 1 - 1, 10, 12));
    });
  });
  test("Test - Single expression with separators", () {
    testSingleCase(ru.casual, "10-августа 2012", new DateTime(2012, 7, 8),
        (result, text) {
      expect(result.text,text);
      expectToBeDate(result,new DateTime(2012, 8 - 1, 10, 12, 0));
    });
    testSingleCase(ru.casual, "10-августа-2012", new DateTime(2012, 7, 8),
        (result, text) {
      expect(result.text,text);
      expectToBeDate(result,new DateTime(2012, 8 - 1, 10, 12, 0));
    });
    testSingleCase(ru.casual, "10/августа 2012", new DateTime(2012, 7, 8),
        (result, text) {
      expect(result.text,text);
      expectToBeDate(result,new DateTime(2012, 8 - 1, 10, 12, 0));
    });
    testSingleCase(ru.casual, "10/августа/2012", new DateTime(2012, 7, 8),
        (result, text) {
      expect(result.text,text);
      expectToBeDate(result,new DateTime(2012, 8 - 1, 10, 12, 0));
    });
  });
  test("Test - Range expression", () {
    testSingleCase(ru.casual, "10 - 22 августа 2012", new DateTime(2012, 7, 10),
         (ParsedResult result, String text) {
      expect(result.index,0);
      expect(result.text,"10 - 22 августа 2012");
      expectToBeDate(result.start,new DateTime(2012, 8 - 1, 10, 12));
      expectToBeDate(result.end!,new DateTime(2012, 8 - 1, 22, 12));
    });
    testSingleCase(
        ru.casual, "с 10 по 22 августа 2012", new DateTime(2012, 7, 10),
         (ParsedResult result, String text) {
      expect(result.index,0);
      expect(result.text,"с 10 по 22 августа 2012");
      expectToBeDate(result.start,new DateTime(2012, 8 - 1, 10, 12));
      expectToBeDate(result.end!,new DateTime(2012, 8 - 1, 22, 12));
    });
    testSingleCase(
        ru.casual, "10 августа - 12 сентября", new DateTime(2012, 7, 10),
         (ParsedResult result, String text) {
      expect(result.index,0);
      expect(result.text,"10 августа - 12 сентября");
      expect(result.start,new DateTime(2012, 8 - 1, 10, 12));
      expectToBeDate(result.end!,new DateTime(2012, 9 - 1, 12, 12));
    });
    testSingleCase(
        ru.casual, "10 августа - 12 сентября 2013", new DateTime(2012, 7, 10),
         (ParsedResult result, String text) {
      expect(result.index,0);
      expect(result.text,"10 августа - 12 сентября 2013");
      expect(result.start,new DateTime(2013, 8 - 1, 10, 12));
      expectToBeDate(result.end!,new DateTime(2013, 9 - 1, 12, 12));
    });
  });
  test("Test - Combined expression", () {
    testSingleCase(ru.casual, "5 мая 12:00", new DateTime(2012, 7, 10),
         (ParsedResult result, String text) {
      expect(result.index,0);
      expect(result.text,"5 мая 12:00");
      expectToBeDate(result.start,new DateTime(2012, 5 - 1, 5, 12, 0));
    });
  });
  test("Test - Ordinal Words", () {
    testSingleCase(ru.casual, "двадцать пятое мая", new DateTime(2012, 1, 10),
            (ParsedResult result, String text) {
      expect(result.index,0);
      expect(result.text,"двадцать пятое мая");
      expectToBeDate(result.start,new DateTime(2012, 5 - 1, 25, 12, 0));
    });
    testSingleCase(
        ru.casual, "двадцать пятое мая 2020 года", new DateTime(2012, 1, 10),
         (ParsedResult result, String text) {
      expect(result.index,0);
      expect(result.text,"двадцать пятое мая 2020 года");
      expectToBeDate(result.start,new DateTime(2020, 5 - 1, 25, 12, 0));
    });
  });
  test("Test - little endian date followed by time", () {
    testSingleCase(
        ru.casual, "24го октября, 9:00", new DateTime(2017, 7 - 1, 7, 15),
         (ParsedResult result, String text) {
      expect(result.index,0);
      expect(result.text,"24го октября, 9:00");
      expectToBeDate(result.start,new DateTime(2017, 10 - 1, 24, 9));
    });
  });
  test("Test - year 90's parsing", () {
    testSingleCase(ru.casual, "03 авг 96", new DateTime(2012, 7, 10), (ParsedResult result, String text) {
      expect(result.index,0);
      expect(result.text,"03 авг 96");
      expectToBeDate(result.start,new DateTime(1996, 8 - 1, 3, 12));
    });
  });
  test("Test - Forward Option", () {
    testSingleCase(ru.casual, "22-23 фев в 7", new DateTime(2016, 3 - 1, 15),
        {"forwardDate": true}, (result, _) {
      expect(result.index,0);
      expect(result.text,"22-23 фев в 7");
      expectToBeDate(result.start,new DateTime(2017, 2 - 1, 22, 7));
      expectToBeDate(result.end!,new DateTime(2017, 2 - 1, 23, 7));
    });
  });
  test("Test - Impossible Dates (Strict Mode)", () {
    testUnexpectedResult(
        ru.strict, "32 августа 2014", new DateTime(2012, 7, 10));
    testUnexpectedResult(
        ru.strict, "29 февраля 2014", new DateTime(2012, 7, 10));
    testUnexpectedResult(ru.strict, "32 августа", new DateTime(2012, 7, 10));
    testUnexpectedResult(ru.strict, "29 февраля", new DateTime(2013, 7, 10));
  });
}

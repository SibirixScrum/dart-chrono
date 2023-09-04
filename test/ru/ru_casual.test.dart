import 'package:chrono/locales/ru/index.dart' as ru;
import 'package:chrono/types.dart';
import 'package:flutter_test/flutter_test.dart';

import "../test_util.dart" show expectToBeDate, testSingleCase, testUnexpectedResult;

void main() {
  test("Test - Single Expression", () {
    testSingleCase(ru.casual, "Дедлайн сегодня", new DateTime(2012, 7, 10, 17, 10),
        (result,_) {
      expect(result.index,8);
      expect(result.text,"сегодня");
      expectToBeDate(result.start,new DateTime(2012, 7, 10, 17, 10));
    });
    testSingleCase(ru.casual, "Дедлайн завтра", new DateTime(2012, 7, 10, 17, 10),
         (ParsedResult result, String text) {
      expect(result.index,8);
      expect(result.text,"завтра");
      expectToBeDate(result.start,new DateTime(2012, 7, 11, 17, 10));
    });
    testSingleCase(
        ru.casual, "Дедлайн послезавтра", new DateTime(2012, 7, 10, 17, 10),
         (ParsedResult result, String text) {
      expect(result.index,8);
      expect(result.text,"послезавтра");
      expectToBeDate(result.start,new DateTime(2012, 7, 12, 17, 10));
    });
    testSingleCase(
        ru.casual, "Дедлайн послепослезавтра", new DateTime(2012, 7, 10, 17, 10),
         (ParsedResult result, String text) {
      expect(result.index,8);
      expect(result.text,"послепослезавтра");
      expectToBeDate(result.start,new DateTime(2012, 7, 13, 17, 10));
    });
    testSingleCase(ru.casual, "Дедлайн вчера", new DateTime(2012, 7, 10, 17, 10),
         (ParsedResult result, String text) {
      expect(result.index,8);
      expect(result.text,"вчера");
      expectToBeDate(result.start,new DateTime(2012, 7, 9, 17, 10));
    });
    testSingleCase(
        ru.casual, "Дедлайн позавчера", new DateTime(2012, 7, 10, 17, 10),
        (ParsedResult result, String text) {
      expect(result.index,8);
      expect(result.text,"позавчера");
      expectToBeDate(result.start,new DateTime(2012, 7, 8, 17, 10));
    });
    testSingleCase(
        ru.casual, "Дедлайн позапозавчера", new DateTime(2012, 7, 10, 17, 10),
        (ParsedResult result, String text) {
      expect(result.index,8);
      expect(result.text,"позапозавчера");
      expectToBeDate(result.start,new DateTime(2012, 7, 7, 17, 10));
    });
    testSingleCase(
        ru.casual, "Дедлайн сейчас", new DateTime(2012, 7, 10, 8, 9, 10, 11),
         (ParsedResult result, String text) {
      expect(result.index,8);
      expect(result.text,"сейчас");
      expect(result.start,result.refDate);
      expectToBeDate(result.start,new DateTime(2012, 7, 10, 8, 9, 10, 11));
    });
    testSingleCase(
        ru.casual, "Дедлайн утром", new DateTime(2012, 7, 10, 8, 9, 10, 11),
         (ParsedResult result, String text) {
      expect(result.index,8);
      expect(result.text,"утром");
      expectToBeDate(result.start,new DateTime(2012, 7, 10, 6, 0, 0, 0));
    });
    testSingleCase(
        ru.casual, "Дедлайн этим утром", new DateTime(2012, 7, 10, 8, 9, 10, 11),
         (ParsedResult result, String text) {
      expect(result.index,8);
      expect(result.text,"этим утром");
      expectToBeDate(result.start,new DateTime(2012, 7, 10, 6, 0, 0, 0));
    });
    testSingleCase(
        ru.casual, "Дедлайн в полдень", new DateTime(2012, 7, 10, 8, 9, 10, 11),
         (ParsedResult result, String text) {
      expect(result.index,8);
      expect(result.text,"в полдень");
      expectToBeDate(result.start,new DateTime(2012, 7, 10, 12, 0, 0, 0));
    });
    testSingleCase(ru.casual, "Дедлайн прошлым вечером",
        new DateTime(2012, 7, 10, 8, 9, 10, 11), (ParsedResult result, String text) {
      expect(result.index,8);
      expect(result.text,"прошлым вечером");
      expectToBeDate(result.start,new DateTime(2012, 7, 9, 20, 0, 0, 0));
    });
    testSingleCase(
        ru.casual, "Дедлайн вечером", new DateTime(2012, 7, 10, 8, 9, 10, 11),
         (ParsedResult result, String text) {
      expect(result.index,8);
      expect(result.text,"вечером");
      expectToBeDate(result.start,new DateTime(2012, 7, 10, 20, 0, 0, 0));
    });
    testSingleCase(
        ru.casual, "Дедлайн прошлой ночью", new DateTime(2012, 7, 10, 8, 9, 10, 11),
         (ParsedResult result, String text) {
      expect(result.index,8);
      expect(result.text,"прошлой ночью");
      expectToBeDate(result.start,new DateTime(2012, 7, 10, 0, 0, 0, 0));
    });
    testSingleCase(
        ru.casual, "Дедлайн прошлой ночью", new DateTime(2012, 7, 10, 2, 9, 10, 11),
         (ParsedResult result, String text) {
      expect(result.index,8);
      expect(result.text,"прошлой ночью");
      expectToBeDate(result.start,new DateTime(2012, 7, 9, 0, 0, 0, 0));
    });
    testSingleCase(
        ru.casual, "Дедлайн сегодня ночью", new DateTime(2012, 7, 10, 2, 9, 10, 11),
         (ParsedResult result, String text) {
      expect(result.index,8);
      expect(result.text,"сегодня ночью");
      expectToBeDate(result.start,new DateTime(2012, 7, 10, 0, 0, 0, 0));
    });
    testSingleCase(
        ru.casual, "Дедлайн этой ночью", new DateTime(2012, 7, 10, 2, 9, 10, 11),
         (ParsedResult result, String text) {
      expect(result.index,8);
      expect(result.text,"этой ночью");
      expectToBeDate(result.start,new DateTime(2012, 7, 10, 0, 0, 0, 0));
    });
    testSingleCase(
        ru.casual, "Дедлайн ночью", new DateTime(2012, 7, 10, 2, 9, 10, 11),
         (ParsedResult result, String text) {
      expect(result.index,8);
      expect(result.text,"ночью");
      expectToBeDate(result.start,new DateTime(2012, 7, 10, 0, 0, 0, 0));
    });
    testSingleCase(
        ru.casual, "Дедлайн в полночь", new DateTime(2012, 7, 10, 2, 9, 10, 11),
         (ParsedResult result, String text) {
      expect(result.index,8);
      expect(result.text,"в полночь");
     expectToBeDate(result.start,new DateTime(2012, 7, 10, 0, 0, 0, 0));
    });
  });
  test("Test - Combined Expression", () {
    testSingleCase(
        ru.casual, "Дедлайн вчера вечером", new DateTime(2012, 7, 10, 12),
         (ParsedResult result, String text) {
      expect(result.index,8);
      expect(result.text,"вчера вечером");
      expectToBeDate(result.start,new DateTime(2012, 7, 9, 20));
    });
    testSingleCase(ru.casual, "Дедлайн завтра утром", new DateTime(2012, 8, 10, 14),
         (ParsedResult result, String text) {
      expect(result.index,8);
      expect(result.text,"завтра утром");
      expectToBeDate(result.start,new DateTime(2012, 8, 11, 6));
    });
  });
  test("Test - Casual date range", () {
    testSingleCase(ru.casual, "Событие с сегодня и до послезавтра",
        new DateTime(2012, 7, 4, 12), (ParsedResult result,String _) {
      expect(result.index,8);
      expect(result.text,"с сегодня и до послезавтра");
      expectToBeDate(result.start,new DateTime(2012, 7, 4, 12));
      expectToBeDate(result.end!,new DateTime(2012, 7, 6, 12));
    });
    testSingleCase(
        ru.casual, "Событие сегодня-завтра", new DateTime(2012, 7, 10, 12),
        (ParsedResult result,String _) {
      expect(result.index,8);
      expect(result.text,"сегодня-завтра");
      expectToBeDate(result.start,new DateTime(2012, 7, 10, 12));
      expectToBeDate(result.end!,new DateTime(2012, 7, 11, 12));
    });
  });
  test("Test - Random negative text", () {
    testUnexpectedResult(ru.casual, "несегодня");
    testUnexpectedResult(ru.casual, "зявтра");
    testUnexpectedResult(ru.casual, "вчеера");
    testUnexpectedResult(ru.casual, "январ");
  });
}

import 'package:chrono/locales/ru/index.dart' as ru;
import 'package:chrono/ported/CustomValues.dart';
import 'package:chrono/types.dart';
import 'package:flutter_test/flutter_test.dart';

import "../test_util.dart"
    show expectToBeDate, testSingleCase, testUnexpectedResult;

void main() {
  test("Test - Single Expression", () {
    testSingleCase(
        ru.casual, "Дедлайн сегодня", new DateTime(2012, 7, 10, 17, 10),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "сегодня");
      expectToBeDate(result.start, new DateTime(2012, 7, 10, 17, 10));
    });
    testSingleCase(
        ru.casual, "Дедлайн завтра", new DateTime(2012, 7, 10, 17, 10),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "завтра");
      expectToBeDate(result.start, new DateTime(2012, 7, 11, 17, 10));
    });
    testSingleCase(
        ru.casual, "Дедлайн послезавтра", new DateTime(2012, 7, 10, 17, 10),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "послезавтра");
      expectToBeDate(result.start, new DateTime(2012, 7, 12, 17, 10));
    });
    testSingleCase(ru.casual, "Дедлайн послепослезавтра",
        new DateTime(2012, 7, 10, 17, 10), (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "послепослезавтра");
      expectToBeDate(result.start, new DateTime(2012, 7, 13, 17, 10));
    });
    testSingleCase(
        ru.casual, "Дедлайн вчера", new DateTime(2012, 7, 10, 17, 10),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "вчера");
      expectToBeDate(result.start, new DateTime(2012, 7, 9, 17, 10));
    });
    testSingleCase(
        ru.casual, "Дедлайн позавчера", new DateTime(2012, 7, 10, 17, 10),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "позавчера");
      expectToBeDate(result.start, new DateTime(2012, 7, 8, 17, 10));
    });
    testSingleCase(
        ru.casual, "Дедлайн позапозавчера", new DateTime(2012, 7, 10, 17, 10),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "позапозавчера");
      expectToBeDate(result.start, new DateTime(2012, 7, 7, 17, 10));
    });
    testSingleCase(
        ru.casual, "Дедлайн сейчас", new DateTime(2012, 7, 10, 8, 9, 10, 11),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "сейчас");
      expect(result.start.date(), result.refDate);
      expectToBeDate(result.start, new DateTime(2012, 7, 10, 8, 9, 10, 11));
    });
    testSingleCase(
        ru.casual, "Дедлайн утром", new DateTime(2012, 7, 10, 8, 9, 10, 11),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "утром");
      expectToBeDate(result.start, new DateTime(2012, 7, 10, morningHour, 0, 0, 0));
    });
    testSingleCase(ru.casual, "Дедлайн этим утром",
        new DateTime(2012, 7, 10, 8, 9, 10, 11),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "этим утром");
      expectToBeDate(result.start, new DateTime(2012, 7, 10, morningHour, 0, 0, 0));
    });
    testSingleCase(
        ru.casual, "Дедлайн в полдень", new DateTime(2012, 7, 10, 8, 9, 10, 11),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "в полдень");
      expectToBeDate(result.start, new DateTime(2012, 7, 10, 12, 0, 0, 0));
    });
    testSingleCase(ru.casual, "Дедлайн прошлым вечером",
        new DateTime(2012, 7, 10, 8, 9, 10, 11),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "прошлым вечером");
      expectToBeDate(result.start, new DateTime(2012, 7, 9, eveningHour, 0, 0, 0));
    });
    testSingleCase(
        ru.casual, "Дедлайн вечером", new DateTime(2012, 7, 10, 8, 9, 10, 11),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "вечером");
      expectToBeDate(result.start, new DateTime(2012, 7, 10, eveningHour, 0, 0, 0));
    });
    testSingleCase(ru.casual, "Дедлайн прошлой ночью",
        new DateTime(2012, 7, 10, 8, 9, 10, 11),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "прошлой ночью");
      expectToBeDate(result.start, new DateTime(2012, 7, 10, 0, 0, 0, 0));
    });
    testSingleCase(ru.casual, "Дедлайн прошлой ночью",
        new DateTime(2012, 7, 10, 2, 9, 10, 11),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "прошлой ночью");
      expectToBeDate(result.start, new DateTime(2012, 7, 9, 0, 0, 0, 0));
    });
    testSingleCase(ru.casual, "Дедлайн сегодня ночью",
        new DateTime(2012, 7, 10, 2, 9, 10, 11),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "сегодня ночью");
      expectToBeDate(result.start, new DateTime(2012, 7, 10, 0, 0, 0, 0));
    });
    testSingleCase(ru.casual, "Дедлайн этой ночью",
        new DateTime(2012, 7, 10, 2, 9, 10, 11),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "этой ночью");
      expectToBeDate(result.start, new DateTime(2012, 7, 10, 0, 0, 0, 0));
    });
    testSingleCase(
        ru.casual, "Дедлайн ночью", new DateTime(2012, 7, 10, 2, 9, 10, 11),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "ночью");
      expectToBeDate(result.start, new DateTime(2012, 7, 10, 0, 0, 0, 0));
    });
    testSingleCase(
        ru.casual, "Дедлайн в полночь", new DateTime(2012, 7, 10, 2, 9, 10, 11),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "в полночь");
      expectToBeDate(result.start, new DateTime(2012, 7, 10, 0, 0, 0, 0));
    });
  });
  test("Test - Combined Expression", () {
    testSingleCase(
        ru.casual, "Дедлайн вчера вечером", new DateTime(2012, 7, 10, 12),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "вчера вечером");
      expectToBeDate(result.start, new DateTime(2012, 7, 9, eveningHour));
    });
    testSingleCase(
        ru.casual, "Дедлайн завтра утром", new DateTime(2012, 8, 10, 14),
        (ParsedResult result, String text) {
      expect(result.index, 8);
      expect(result.text, "завтра утром");
      expectToBeDate(result.start, new DateTime(2012, 8, 11, morningHour));
    });
  });
  test("Test - Casual date range", () {
    testSingleCase(ru.casual, "Событие с сегодня и до послезавтра",
        new DateTime(2012, 7, 4, 12), (ParsedResult result, String _) {
      expect(result.index, 8);
      expect(result.text, "с сегодня и до послезавтра");
      expectToBeDate(result.start, new DateTime(2012, 7, 4, 12));
      expectToBeDate(result.end!, new DateTime(2012, 7, 6, 12));
    });
    testSingleCase(
        ru.casual, "Событие сегодня-завтра", new DateTime(2012, 7, 10, 12),
        (ParsedResult result, String _) {
      expect(result.index, 8);
      expect(result.text, "сегодня-завтра");
      expectToBeDate(result.start, new DateTime(2012, 7, 10, 12));
      expectToBeDate(result.end!, new DateTime(2012, 7, 11, 12));
    });
    testSingleCase(
        ru.casual, "с утра пн до вечера вт", new DateTime(2023,9,19),
            ParsingOption(forwardDate: true),
            (ParsedResult result, String _) {
          expect(result.index, 2);
          expect(result.text, "утра пн до вечера вт");
          expectToBeDate(result.start, new DateTime(2023,9,25,9));
          expectToBeDate(result.end!, new DateTime(2023,9,26,18));
        });
    testSingleCase(
        ru.casual, "с утра пн до вечера вт", new DateTime(2023,9,19),
            (ParsedResult result, String _) {
          expect(result.index, 2);
          expect(result.text, "утра пн до вечера вт");
          expectToBeDate(result.start, new DateTime(2023,9,18,9));
          expectToBeDate(result.end!, new DateTime(2023,9,19,18));
        });
  });
  test("Test - casual date range", () {
    testSingleCase(ru.casual, "с вечера до утра", DateTime(2023, 9, 19,14),
        ParsingOption(forwardDate: true),
            (ParsedResult result, String text) {
          expect(result.index, 2);
          expect(result.text, "вечера до утра");
          expectToBeDate(result.start, DateTime(2023, 9, 19, 18));
          expectToBeDate(result.end!, DateTime(2023, 9, 20, 9));
        });
    testSingleCase(ru.casual, "с вечера пн до утра вт", DateTime(2023, 9, 19,14),
        ParsingOption(forwardDate: true),
            (ParsedResult result, String text) {
          expect(result.index, 2);
          expect(result.text, "вечера пн до утра вт");
          expectToBeDate(result.start, DateTime(2023, 9, 25, 18));
          expectToBeDate(result.end!, DateTime(2023, 9, 26, 9));
        });
    testSingleCase(ru.casual, "с 18 вечера до 9 утра", DateTime(2023, 9, 19,14),
        ParsingOption(forwardDate: true),
            (ParsedResult result, String text) {
          expect(result.index, 0);
          expect(result.text, "с 18 вечера до 9 утра");
          expectToBeDate(result.start, DateTime(2023, 9, 19, 18));
          expectToBeDate(result.end!, DateTime(2023, 9, 20, 9));
        });
    testSingleCase(ru.casual, "с утра до ночи", DateTime(2023, 9, 19,14),
        ParsingOption(forwardDate: true),
            (ParsedResult result, String text) {
          expect(result.index, 2);
          expect(result.text, "утра до ночи");
          expectToBeDate(result.start, DateTime(2023, 9, 20, 9));
          expectToBeDate(result.end!, DateTime(2023, 9, 21, 0));
        });
    testSingleCase(ru.casual, "с утра пн до ночи ср", DateTime(2023, 9, 19,14),
        ParsingOption(forwardDate: true),
            (ParsedResult result, String text) {
          expect(result.index, 2);
          expect(result.text, "утра пн до ночи ср");
          expectToBeDate(result.start, DateTime(2023, 9, 25, 9));
          expectToBeDate(result.end!, DateTime(2023, 9, 27, 0));
        });
    testSingleCase(ru.casual, "с вечера до ночи", DateTime(2023, 9, 19,14),
        ParsingOption(forwardDate: true),
            (ParsedResult result, String text) {
          expect(result.index, 2);
          expect(result.text, "вечера до ночи");
          expectToBeDate(result.start, DateTime(2023, 9, 19, 18));
          expectToBeDate(result.end!, DateTime(2023, 9, 20, 0));
        });
    testSingleCase(ru.casual, "с вечера вт до ночи чт", DateTime(2023, 9, 19,14),
        ParsingOption(forwardDate: true),
            (ParsedResult result, String text) {
          expect(result.index, 2);
          expect(result.text, "вечера вт до ночи чт");
          expectToBeDate(result.start, DateTime(2023, 9, 19, 18));
          expectToBeDate(result.end!, DateTime(2023, 9, 21, 0));
        });
    testSingleCase(ru.casual, "с 19 вечера до 2 ночи", DateTime(2023, 9, 19,14),
        ParsingOption(forwardDate: true),
            (ParsedResult result, String text) {
          expect(result.index, 0);
          expect(result.text, "с 19 вечера до 2 ночи");
          expectToBeDate(result.start, DateTime(2023, 9, 19, 19));
          expectToBeDate(result.end!, DateTime(2023, 9, 20, 2));
        });
    testSingleCase(ru.casual, "с ночи до утра", DateTime(2023, 9, 19,14),
        ParsingOption(forwardDate: true),
            (ParsedResult result, String text) {
          expect(result.index, 2);
          expect(result.text, "ночи до утра");
          expectToBeDate(result.start, DateTime(2023, 9, 20, 0));
          expectToBeDate(result.end!, DateTime(2023, 9, 20, 9));
        });
  });
  test("Test - Random negative text", () {
    testUnexpectedResult(ru.casual, "несегодня");
    testUnexpectedResult(ru.casual, "зявтра");
    testUnexpectedResult(ru.casual, "вчеера");
    testUnexpectedResult(ru.casual, "январ");
  });
}

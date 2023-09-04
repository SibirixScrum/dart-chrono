import 'package:chrono/locales/ru/index.dart' as ru;

import "../test_util.dart" show testSingleCase, testUnexpectedResult;

void main() {
  test("Test - Single Expression", () {
    testSingleCase(ru.casual, "Дедлайн сегодня", new Date(2012, 7, 10, 17, 10),
        (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("сегодня");
      expect(result.start).toBeDate(new Date(2012, 7, 10, 17, 10));
    });
    testSingleCase(ru.casual, "Дедлайн завтра", new Date(2012, 7, 10, 17, 10),
        (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("завтра");
      expect(result.start).toBeDate(new Date(2012, 7, 11, 17, 10));
    });
    testSingleCase(
        ru.casual, "Дедлайн послезавтра", new Date(2012, 7, 10, 17, 10),
        (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("послезавтра");
      expect(result.start).toBeDate(new Date(2012, 7, 12, 17, 10));
    });
    testSingleCase(
        ru.casual, "Дедлайн послепослезавтра", new Date(2012, 7, 10, 17, 10),
        (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("послепослезавтра");
      expect(result.start).toBeDate(new Date(2012, 7, 13, 17, 10));
    });
    testSingleCase(ru.casual, "Дедлайн вчера", new Date(2012, 7, 10, 17, 10),
        (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("вчера");
      expect(result.start).toBeDate(new Date(2012, 7, 9, 17, 10));
    });
    testSingleCase(
        ru.casual, "Дедлайн позавчера", new Date(2012, 7, 10, 17, 10),
        (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("позавчера");
      expect(result.start).toBeDate(new Date(2012, 7, 8, 17, 10));
    });
    testSingleCase(
        ru.casual, "Дедлайн позапозавчера", new Date(2012, 7, 10, 17, 10),
        (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("позапозавчера");
      expect(result.start).toBeDate(new Date(2012, 7, 7, 17, 10));
    });
    testSingleCase(
        ru.casual, "Дедлайн сейчас", new Date(2012, 7, 10, 8, 9, 10, 11),
        (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("сейчас");
      expect(result.start).toBeDate(result.refDate);
      expect(result.start).toBeDate(new Date(2012, 7, 10, 8, 9, 10, 11));
    });
    testSingleCase(
        ru.casual, "Дедлайн утром", new Date(2012, 7, 10, 8, 9, 10, 11),
        (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("утром");
      expect(result.start).toBeDate(new Date(2012, 7, 10, 6, 0, 0, 0));
    });
    testSingleCase(
        ru.casual, "Дедлайн этим утром", new Date(2012, 7, 10, 8, 9, 10, 11),
        (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("этим утром");
      expect(result.start).toBeDate(new Date(2012, 7, 10, 6, 0, 0, 0));
    });
    testSingleCase(
        ru.casual, "Дедлайн в полдень", new Date(2012, 7, 10, 8, 9, 10, 11),
        (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("в полдень");
      expect(result.start).toBeDate(new Date(2012, 7, 10, 12, 0, 0, 0));
    });
    testSingleCase(ru.casual, "Дедлайн прошлым вечером",
        new Date(2012, 7, 10, 8, 9, 10, 11), (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("прошлым вечером");
      expect(result.start).toBeDate(new Date(2012, 7, 9, 20, 0, 0, 0));
    });
    testSingleCase(
        ru.casual, "Дедлайн вечером", new Date(2012, 7, 10, 8, 9, 10, 11),
        (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("вечером");
      expect(result.start).toBeDate(new Date(2012, 7, 10, 20, 0, 0, 0));
    });
    testSingleCase(
        ru.casual, "Дедлайн прошлой ночью", new Date(2012, 7, 10, 8, 9, 10, 11),
        (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("прошлой ночью");
      expect(result.start).toBeDate(new Date(2012, 7, 10, 0, 0, 0, 0));
    });
    testSingleCase(
        ru.casual, "Дедлайн прошлой ночью", new Date(2012, 7, 10, 2, 9, 10, 11),
        (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("прошлой ночью");
      expect(result.start).toBeDate(new Date(2012, 7, 9, 0, 0, 0, 0));
    });
    testSingleCase(
        ru.casual, "Дедлайн сегодня ночью", new Date(2012, 7, 10, 2, 9, 10, 11),
        (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("сегодня ночью");
      expect(result.start).toBeDate(new Date(2012, 7, 10, 0, 0, 0, 0));
    });
    testSingleCase(
        ru.casual, "Дедлайн этой ночью", new Date(2012, 7, 10, 2, 9, 10, 11),
        (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("этой ночью");
      expect(result.start).toBeDate(new Date(2012, 7, 10, 0, 0, 0, 0));
    });
    testSingleCase(
        ru.casual, "Дедлайн ночью", new Date(2012, 7, 10, 2, 9, 10, 11),
        (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("ночью");
      expect(result.start).toBeDate(new Date(2012, 7, 10, 0, 0, 0, 0));
    });
    testSingleCase(
        ru.casual, "Дедлайн в полночь", new Date(2012, 7, 10, 2, 9, 10, 11),
        (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("в полночь");
      expect(result.start).toBeDate(new Date(2012, 7, 10, 0, 0, 0, 0));
    });
  });
  test("Test - Combined Expression", () {
    testSingleCase(
        ru.casual, "Дедлайн вчера вечером", new Date(2012, 7, 10, 12),
        (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("вчера вечером");
      expect(result.start).toBeDate(new Date(2012, 7, 9, 20));
    });
    testSingleCase(ru.casual, "Дедлайн завтра утром", new Date(2012, 8, 10, 14),
        (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("завтра утром");
      expect(result.start).toBeDate(new Date(2012, 8, 11, 6));
    });
  });
  test("Test - Casual date range", () {
    testSingleCase(ru.casual, "Событие с сегодня и до послезавтра",
        new Date(2012, 7, 4, 12), (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("с сегодня и до послезавтра");
      expect(result.start).toBeDate(new Date(2012, 7, 4, 12));
      expect(result.end).toBeDate(new Date(2012, 7, 6, 12));
    });
    testSingleCase(
        ru.casual, "Событие сегодня-завтра", new Date(2012, 7, 10, 12),
        (result) {
      expect(result.index).toBe(8);
      expect(result.text).toBe("сегодня-завтра");
      expect(result.start).toBeDate(new Date(2012, 7, 10, 12));
      expect(result.end).toBeDate(new Date(2012, 7, 11, 12));
    });
  });
  test("Test - Random negative text", () {
    testUnexpectedResult(ru.casual, "несегодня");
    testUnexpectedResult(ru.casual, "зявтра");
    testUnexpectedResult(ru.casual, "вчеера");
    testUnexpectedResult(ru.casual, "январ");
  });
}

import 'package:chrono/locales/en/index.dart' as en;
import 'package:chrono/types.dart';
import "package:flutter_test/flutter_test.dart";

import '../test_util.dart';

 void main() {
   test("Test - Single Expression", () {
     testSingleCase(en.casual, "Let's finish this before this 2013-2-7.",
        DateTime(2012, 7, 8), (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2013);
      expect(result.start.get("month"), 2);
      expect(result.start.get("day"), 7);
      final resultDate = result.start.date();
      final expectDate = DateTime(2013, 1, 7, 12);
      expect(expectDate.getTime()).toBeCloseTo(resultDate.getTime());
    });
     testSingleCase(en.casual, "1994-11-05T08:15:30-05:30", DateTime(2012, 7, 8),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 1994);
      expect(result.start.get("month"), 11);
      expect(result.start.get("day"), 5);
      expect(result.start.get("hour"), 8);
      expect(result.start.get("minute"), 15);
      expect(result.start.get("second"), 30);
      expect(result.start.get("timezoneOffset"), -330);
      expect(result.text, "1994-11-05T08:15:30-05:30");
      expect(result.start).toBeDate(DateTime(784043130000));
    });
     testSingleCase(en.casual, "1994-11-05T13:15:30", DateTime(2012, 7, 8),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 1994);
      expect(result.start.get("month"), 11);
      expect(result.start.get("day"), 5);
      expect(result.start.get("hour"), 13);
      expect(result.start.get("minute"), 15);
      expect(result.start.get("second"), 30);
      expect(result.start.get("timezoneOffset"), 0);
      expect(result.text, "1994-11-05T13:15:30");
      expect(result.start).toBeDate(DateTime(784041330000));
    });
     testSingleCase(en.casual, "2015-07-31T12:00:00", DateTime(2012, 7, 8),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2015);
      expect(result.start.get("month"), 7);
      expect(result.start.get("day"), 31);
      expect(result.start.get("hour"), 12);
      expect(result.start.get("minute"), 0);
      expect(result.start.get("second"), 0);
      expect(result.start.get("timezoneOffset"), 0);
      expect(result.text, "2015-07-31T12:00:00");
      expect(result.start).toBeDate(DateTime(1438344000000));
    });
     testSingleCase(en.casual, "1994-11-05T13:15:30Z", DateTime(2012, 7, 8),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 1994);
      expect(result.start.get("month"), 11);
      expect(result.start.get("day"), 5);
      expect(result.start.get("hour"), 13);
      expect(result.start.get("minute"), 15);
      expect(result.start.get("second"), 30);
      expect(result.start.get("timezoneOffset"), 0);
      expect(result.text, "1994-11-05T13:15:30Z");
      expect(result.start).toBeDate(DateTime(784041330000));
    });
     testSingleCase(en.casual, "1994-11-05T13:15:30Z", DateTime(2012, 7, 8),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 1994);
      expect(result.start.get("month"), 11);
      expect(result.start.get("day"), 5);
      expect(result.start.get("hour"), 13);
      expect(result.start.get("minute"), 15);
      expect(result.start.get("second"), 30);
      expect(result.start.get("timezoneOffset"), 0);
      expect(result.text, "1994-11-05T13:15:30Z");
      expect(result.start).toBeDate(DateTime(784041330000));
    });
     testSingleCase(en.casual, "- 1994-11-05T13:15:30Z", DateTime(2012, 7, 8),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 1994);
      expect(result.start.get("month"), 11);
      expect(result.start.get("day"), 5);
      expect(result.start.get("hour"), 13);
      expect(result.start.get("minute"), 15);
      expect(result.start.get("second"), 30);
      expect(result.start.get("timezoneOffset"), 0);
      expect(result.index, 2);
      expect(result.text, "1994-11-05T13:15:30Z");
      expect(result.start).toBeDate(DateTime(784041330000));
    });
     testSingleCase(
        en.casual.strict, "2016-05-07T23:45:00.487+01:00", DateTime(2012, 7, 8),
        (ParsedResult result, String text) {
      expect(result.start == null, isFalse);
      expect(result.start.get("year"), 2016);
      expect(result.start.get("month"), 5);
      expect(result.start.get("day"), 7);
      expect(result.start.get("hour"), 23);
      expect(result.start.get("minute"), 45);
      expect(result.start.get("second"), 0);
      expect(result.start.get("timezoneOffset"), 60);
      expect(result.text, "2016-05-07T23:45:00.487+01:00");
      expect(result.start).toBeDate(DateTime(1462661100487));
    });
   });
 }
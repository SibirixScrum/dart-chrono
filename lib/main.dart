import 'package:chrono/chrono.dart';
import 'package:chrono/locales/ru/index.dart' as ru;
import 'package:chrono/locales/en/index.dart' as en;
import 'package:chrono/ported/ParseInt.dart';
import 'package:chrono/ported/RegExpMatchArray.dart';
import 'package:chrono/types.dart';

void main() async {
  final now = DateTime.now().millisecondsSinceEpoch;

  final result = Chrono.en.casual.parse('An appointment on Sep 12-13',referenceDate: DateTime(2025,9,20),option: ParsingOption(forwardDate: true));
  // Fri Sep 12 2014 12:00:00 GMT-0500 (CDT)
  print(result[0].start.date());
  print(result[0].end?.date());
}

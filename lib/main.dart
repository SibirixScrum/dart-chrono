import 'package:chrono/chrono.dart';
import 'package:chrono/locales/ru/index.dart' as ru;
import 'package:chrono/locales/en/index.dart' as en;
import 'package:chrono/ported/RegExpMatchArray.dart';
import 'package:chrono/types.dart';

void main() async {
  // print(Weekday.FRIDAY.index);
  final Chrono chrono = Chrono();
  // final regexp = RegExp(
  //     "([^\p{L}\p{N}_]|^)((?:в)\s*)?((?:сентябрь|сентября|сентябре|февраль|февраля|феврале|августа|августе|октябрь|октября|октябре|декабрь|декабря|декабре|январь|января|январе|апрель|апреля|апреле|август|ноябрь|ноября|ноябре|марта|марте|март|июнь|июня|июне|июль|июля|июле|янв\.|фев\.|мар\.|апр\.|авг\.|сен\.|окт\.|ноя\.|дек\.|май|мая|мае|янв|фев|мар|апр|авг|сен|окт|ноя|дек))\s*(?:[,-]?\s*((?:[1-9][0-9]{0,3}(?:\s+(?:году|года|год|г|г.))?\s*(?:н.э.|до н.э.|н. э.|до н. э.)|[1-2][0-9]{3}(?:\s+(?:году|года|год|г|г.))?|[5-9][0-9](?:\s+(?:году|года|год|г|г.))?))?)?(?=[^\s\w]|\s+[^0-9]|\s+\$|\$)",
  // caseSensitive: false);
  // final matches = regexp.allMatches("Сентябрь 2012");
  // final List<String?> list = List.generate(0, (index) => "");
  // print("len = ${matches.length}");
  // matches.forEach((element) {
  //   final groups =
  //       element.groups(List.generate(element.groupCount + 1, (index) => index));
  //   print("groups = $groups");
  //   list.addAll(groups);
  // });
  //
  // print(list);
  // final c = "2014 12 28".replaceAll(" ", "").match(RegExp(r'^\d*(\.\d*)?$'));
  //
  // final d = RegExp(r'^\d*(\.\d*)?$').exec("2014 12 28");




  final b = en.parse( "From December to May", DateTime(2023, 4 , 9));
  // print(new DateTime(2017, 11, 19, 12).weekday);

  // final a = chrono.parse("18.02.2024");
  print("\n${b.length} \n${b[0].refDate} \n${b[0].end} \n${b[0].start} \n${b[0].text}");
  // runApp(const MyApp());
}
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
//   @override
//   void initState() {
//     WidgetsBinding.instance.addObserver(this);
//
//     final a = chrono.parse("18.02.2024");
//     print(a);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

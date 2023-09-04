import 'package:chrono/chrono.dart';
import 'package:chrono/locales/ru/index.dart' as ru;
import 'package:flutter/material.dart';


void main() async {
  // print(Weekday.FRIDAY.index);
  final Chrono chrono = Chrono();
  // final regexp = RegExp(
  //     "([^\p{L}\p{N}_]|^)(?:с|со)?\s*(сегодня|вчера|завтра|послезавтра"
  //         "|послепослезавтра|позапозавчера|позавчера)(?=[^\p{L}\p{N}_]|\$)");
  // final matches = regexp.allMatches("дедлайн сегодня");
  // final List<String?> list = List.generate(0, (index) => "");
  // print("len = ${matches.length}");
  // matches.forEach((element) {
  //   final groups = element.groups(
  //       List.generate(element.groupCount+1, (index) => index));
  //   print("groups = $groups");
  //   list.addAll(groups);
  // });
  //
  //
  // print(list);

  final b = ru.parse("дедлайн сейчас",new DateTime(2012, 7, 10, 8, 9, 10, 11));

  // final a = chrono.parse("18.02.2024");
  print("${b.length} ${b[0].refDate} ${b[0].end} ${b[0].start} ${b[0].text}");
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

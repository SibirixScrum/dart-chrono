import 'package:chrono/chrono.dart';
import 'package:chrono/locales/ru/index.dart' as ru;
import 'package:flutter/material.dart';


void main() async {
  // print(Weekday.FRIDAY.index);
  final Chrono chrono = Chrono();
  final b = ru.parse("18.02.2024");
  // final a = chrono.parse("18.02.2024");
  print(b);
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

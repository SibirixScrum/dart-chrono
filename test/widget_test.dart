// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:chrono/ported/RegExpMatchArray.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:chrono/main.dart';

void main() {
  final a = RegExp(
      '(\\d{1,4})' +
          '(?:' +
          '(?:\\.|:|：)' +
          '(\\d{1,2})' +
          '(?:' +
          '(?::|：)' +
          '(\\d{2})' +
          '(?:\\.(\\d{1,6}))?' +
          ')?' +
          ')?' +
          '(?:\\s*(a\\.m\\.|p\\.m\\.|am?|pm?))?',
      caseSensitive: false
  );

  var b = "adf 18:25 asf asdf".matchTs(a);

  print(b);
}

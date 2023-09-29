class RegExpMatchArray {
  late List<String?> matches;

  var index = 0;
  final String input;

  RegExpMatchArray(this.matches, this.input, this.index);

  String operator [](int index) {
    return matches.length > index ? (matches[index] ?? "") : "";
  }
}

extension RegExpUtil on RegExp {
  RegExpMatchArray? exec(String str) {

    final matches = allMatches(str);

    if (matches.isEmpty) {
      return null;
    }
    final index = matches.first.start;
    return RegExpMatchArray(
        matches
            .toList()
            .expand((element) => element.groups(
                List.generate(element.groupCount + 1, (index) => index)))
            .toList(),
        str,
        index);
  }
}

extension StringMatch on String {
  bool match(RegExp exp) {
    return exp.hasMatch(this);
  }
}

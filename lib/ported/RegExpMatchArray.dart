class RegExpMatchArray {
  late List<String?> matches;

  var index = 0;
  final String input;

  RegExpMatchArray(List<String?> matches, this.input, this.index) {
    this.matches = matches /*+ List.generate(6, (index) => null)*/;
  }

  String operator [](int index) {
    return matches.length > index ? (matches[index] ?? "") : "";
  }
}

extension RegExpUtil on RegExp {
  RegExpMatchArray? exec(String str) {
    // if(!this.hasMatch(str)){
    //   return null;
    // }
    final firstMatch = this.firstMatch(str);
    if (firstMatch == null) {
      return null;
    } else {
      final index = firstMatch.start;
      final matches = allMatches(str);
      // print(matches.map((e) => e.groups(groupIndices)));
      return RegExpMatchArray(
          matches
              .toList()
              // .map((e) => e[0])
              .expand((element) => element
                  .groups(List.generate(element.groupCount+1, (index) => index)))
              .toList(),
          str,
          index);
    }
  }
}

extension RegExpUtil2 on String {
  bool match(RegExp exp) {
    return exp.hasMatch(this);
  }
}

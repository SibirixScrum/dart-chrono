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

    final matches = allMatches(str);

    if (matches.isEmpty) {
      return null;
    }
    final index = matches.first.start;
    // print(matches.map((e) => e.groups(groupIndices)));
    return RegExpMatchArray(
        matches.first.groups(List.generate(matches.first.groupCount+1, (index) => index))
            // .map((e) => e[0])
         /*   .expand((element) => element.groups(
                List.generate(element.groupCount + 1, (index) => index)))
            .toList()*/,
        str,
        index);
  }
}

extension RegExpUtil2 on String {
  bool match(RegExp exp) {
    return exp.hasMatch(this);
  }
}

class RegExpMatchArray{
  final List<String?> matches;
  var index = 0;
  final String input;
  RegExpMatchArray(this.matches,this.input,this.index);
  String operator [](int index){
    return matches[index].toString();
  }
}

extension RegExpUtil on RegExp{
  RegExpMatchArray? exec(String str){
    final firstMatch = this.firstMatch(str);
    if(firstMatch == null){
      return null;
    }else{
      final index = firstMatch.start;
      final matches = allMatches(str);
      return RegExpMatchArray(matches.toList().expand(
              (element) => element.groups(
              List.generate(element.groupCount, (index) => index)
          )
      ).toList(),str,index);
    }
  }
}


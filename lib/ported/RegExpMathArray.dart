


class RegExpMatchArray{
  final List<String> matches;
  var index = 0;
  RegExpMatchArray(this.matches);
  String operator [](int index){
    return matches[index];
  }
}

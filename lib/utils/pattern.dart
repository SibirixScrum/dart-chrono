/// List<String> | Map<String,dynamic> | Map<String,dynamic>
typedef DictionaryLike = dynamic;

String repeatedTimeunitPattern(String prefix, String singleTimeunitPattern) {
  final singleTimeunitPatternNoCapture =
      singleTimeunitPattern.replaceAll(new RegExp(r'\((?!\?)'), "(?:");
  return '''${prefix}${singleTimeunitPatternNoCapture}\\s{0,5}(?:,?\\s{0,5}${singleTimeunitPatternNoCapture}){0,10}''';
}

List<String> extractTerms(DictionaryLike dictionary) {
  late List<String> keys;
  if (dictionary is List) {
    keys = [];
  } else if (dictionary is Map) {
    keys = List.from(dictionary.keys);
  } else if (dictionary is dynamic) {
    // keys = Object.keys(dictionary);
    keys = dictionary.keys;
  }
  return keys;
}

String matchAnyPattern(DictionaryLike dictionary) {
  // TODO: More efficient regex pattern by considering duplicated prefix
  final terms = extractTerms(dictionary);
  terms.sort((a, b) => b.length - a.length);
  final joinedTerms = terms.join("|").replaceAll(new RegExp(r'\.'), "\\.");
  return '''(?:${joinedTerms})''';
}

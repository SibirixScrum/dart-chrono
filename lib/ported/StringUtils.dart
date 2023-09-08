String? or(String? a, String? b) {
  if (a != null) {
    return a;
  } else if (b != null) {
    return b;
  } else {
    return null;
  }
}

extension StringUtils on String {
  bool isDigitOrSign() {
    if (length > 1) {
      return false;
    } else {
      return RegExp(r'^[0-9-+]+$').hasMatch(this);
    }
  }
}

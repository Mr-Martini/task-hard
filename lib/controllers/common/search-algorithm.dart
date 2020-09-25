abstract class SearchAlgorithm {
  static bool _isEmpty(String text) {
    if (text == null || text == '') return true;
    return false;
  }

  static List search(List raw, String text) {
    if (_isEmpty(text)) return raw;

    RegExp regExp = RegExp("$text*", caseSensitive: false);

    return raw.where((element) {
      bool titleHasMatch = false;
      bool noteHasMatch = false;

      if (!_isEmpty(element['title'])) {
        titleHasMatch = regExp.hasMatch(element['title']);
      }
      if (!_isEmpty(element['note'])) {
        noteHasMatch = regExp.hasMatch(element['note']);
      }
      return titleHasMatch || noteHasMatch;
    }).toList();
  }

  static List searchTag(List raw, String text) {
    if (_isEmpty(text)) return raw;

    RegExp regExp = RegExp("$text*", caseSensitive: false);

    return raw.where((element) {
      bool titleHasMatch = false;
      bool noteHasMatch = false;

      if (!_isEmpty(element['name'])) {
        titleHasMatch = regExp.hasMatch(element['name']);
      }
      return titleHasMatch || noteHasMatch;
    }).toList();
  }
}

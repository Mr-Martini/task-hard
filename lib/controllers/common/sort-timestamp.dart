abstract class SortByTimestamp {
  static List sort(List raw) {
    raw.sort(
      (a, b) {
        if (a['lastEdited'] == null) return 1;
        if (b['lastEdited'] == null) return -1;
        return b['lastEdited']
            .millisecondsSinceEpoch
            .compareTo(a['lastEdited'].millisecondsSinceEpoch);
      },
    );
    return raw;
  }
}

abstract class Days {
  static const String _sunday = "SUNDAY";
  static const String _monday = "MONDAY";
  static const String _tuesday = "TUESDAY";
  static const String _wednesday = "WEDNESDAY";
  static const String _friday = "FRIDAY";
  static const String _thursday = "THURSDAY";
  static const String _saturday = "SATURDAY";

  // ignore: non_constant_identifier_names
  static String get SUNDAY => _sunday;
  // ignore: non_constant_identifier_names
  static String get MONDAY => _monday;
  // ignore: non_constant_identifier_names
  static String get TUESDAY => _tuesday;
  // ignore: non_constant_identifier_names
  static String get WEDNESDAY => _wednesday;
  // ignore: non_constant_identifier_names
  static String get THURSDAY => _thursday;
  // ignore: non_constant_identifier_names
  static String get FRIDAY => _friday;
  // ignore: non_constant_identifier_names
  static String get SATURDAY => _saturday;

  static String getValueOf(String day) {
    Map<String, String> days = {
      'Sun': _sunday,
      'dom': _sunday,
      'Mon': _monday,
      'seg': _monday,
      'Tue': _tuesday,
      'ter': _tuesday,
      'Wed': _wednesday,
      'qua': _wednesday,
      'Thu': _thursday,
      'qui': _thursday,
      'Fri': _friday,
      'sex': _friday,
      'Sat': _saturday,
      'sáb': _saturday,
    };
    return days[day];
  }
}

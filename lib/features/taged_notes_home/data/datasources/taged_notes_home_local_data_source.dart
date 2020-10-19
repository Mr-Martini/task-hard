import 'package:hive/hive.dart';

import '../model/taged_notes_home_model.dart';

const String TAGED_NOTES_HOME = 'TAGED_NOTES_HOME';

abstract class TagedNotesHomeLocalDataSource {
  TagedNotesHomeModel getPreference();
  TagedNotesHomeModel setPreference(bool should);
}

class TagedNotesHomeLocalDataSourceImpl
    implements TagedNotesHomeLocalDataSource {
  final Box<dynamic> settingsBox;

  TagedNotesHomeLocalDataSourceImpl(this.settingsBox);

  @override
  TagedNotesHomeModel getPreference() {
    final should = settingsBox.get(TAGED_NOTES_HOME, defaultValue: null);
    if (should != null) {
      return TagedNotesHomeModel.fromBool(should);
    }
    settingsBox.put(TAGED_NOTES_HOME, true);
    return TagedNotesHomeModel.fromBool(true);
  }

  @override
  TagedNotesHomeModel setPreference(bool should) {
    settingsBox.put(TAGED_NOTES_HOME, should);
    return TagedNotesHomeModel.fromBool(should);
  }
}

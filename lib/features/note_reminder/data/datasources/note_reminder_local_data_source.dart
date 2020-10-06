import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../model/note_reminder_model.dart';

abstract class NoteReminderLocalDataSource {
  NoteReminderModel getReminder(String noteKey);
}

class NoteReminderLocalDataSourceImpl implements NoteReminderLocalDataSource {
  final Box<dynamic> box;

  NoteReminderLocalDataSourceImpl({@required this.box});

  @override
  NoteReminderModel getReminder(String noteKey) {
    var note = box.get(noteKey, defaultValue: {});
    return NoteReminderModel.fromMap(note);
  }
}

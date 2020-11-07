import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:task_hard/controllers/reminder-controller/reminder-controller.dart';

import '../../../note/domain/entities/note.dart';
import '../model/archive_notes_model.dart';

abstract class ArchivedNotesLocalDataSource {
  ArchivedNotesModel getArchivedNotes();
  ArchivedNotesModel expireCheckerArchive(Iterable<dynamic> notes);
  ArchivedNotesModel deleteEmptyNotes(List<Note> notes);
}

class ArchivedNotesLocalDataSourceImpl implements ArchivedNotesLocalDataSource {
  final Box<dynamic> archiveBox;

  ArchivedNotesLocalDataSourceImpl({@required this.archiveBox});

  @override
  ArchivedNotesModel getArchivedNotes() {
    final values = archiveBox.values;
    return ArchivedNotesModel.fromIterable(values);
  }

  @override
  ArchivedNotesModel expireCheckerArchive(Iterable notes) {
    for (var note in notes) {
      var aux = note;
      aux['expired'] = true;
      archiveBox.put(note['key'], aux);
    }
    return ArchivedNotesModel.fromIterable(notes);
  }

  @override
  ArchivedNotesModel deleteEmptyNotes(List<Note> notes) {
    for (Note note in notes) {
      archiveBox.delete(note.key);
      ReminderController.cancel(note.reminderKey ?? note.key.hashCode);
    }
    return ArchivedNotesModel.fromIterable(archiveBox.values);
  }
}

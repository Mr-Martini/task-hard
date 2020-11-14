import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../note/data/model/note_model.dart';
import '../../../note/domain/entities/note.dart';
import '../model/deleted_notes_model.dart';

abstract class DeletedNotesLocalDataSource {
  DeletedNotesModel getNotes();
  DeletedNotesModel restoreNotes(List<Note> notes);
}

class DeletedNotesLocalDataSourceImpl implements DeletedNotesLocalDataSource {
  final Box<dynamic> archiveBox;
  final Box<dynamic> deleteBox;
  final Box<dynamic> homeBox;

  DeletedNotesLocalDataSourceImpl({
    @required this.archiveBox,
    @required this.deleteBox,
    @required this.homeBox,
  });

  @override
  DeletedNotesModel getNotes() {
    return DeletedNotesModel.fromIterable(deleteBox.values);
  }

  @override
  DeletedNotesModel restoreNotes(List<Note> notes) {
    for (NoteModel note in notes) {
      homeBox.put(note.key, note.toMap());
      deleteBox.delete(note.key);
    }
    return DeletedNotesModel.fromIterable(deleteBox.values);
  }
}

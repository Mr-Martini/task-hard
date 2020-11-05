import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../model/archive_notes_model.dart';

abstract class ArchivedNotesLocalDataSource {
  ArchivedNotesModel getArchivedNotes();
  ArchivedNotesModel expireCheckerArchive(Iterable<dynamic> notes);
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
}

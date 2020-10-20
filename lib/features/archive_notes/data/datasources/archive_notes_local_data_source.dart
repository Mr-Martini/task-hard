import 'package:hive/hive.dart';
import 'package:task_hard/features/archive_notes/data/model/archive_notes_model.dart';
import 'package:meta/meta.dart';

abstract class ArchivedNotesLocalDataSource {
  ArchivedNotesModel getArchivedNotes();
}


class ArchivedNotesLocalDataSourceImpl implements ArchivedNotesLocalDataSource {

  final Box<dynamic> archiveBox;

  ArchivedNotesLocalDataSourceImpl({@required this.archiveBox});

  @override
  ArchivedNotesModel getArchivedNotes() {
    final values = archiveBox.values;
    return ArchivedNotesModel.fromIterable(values);
  }
  
}
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../model/deleted_notes_model.dart';

abstract class DeletedNotesLocalDataSource {
  DeletedNotesModel getNotes();
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
}

import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../../core/Utils/write_on.dart';
import '../model/note_tags_model.dart';

abstract class NoteTagsLocalDataSource {
  NoteTagsModel getNoteTags(String noteKey, WriteOn box);
}

class NoteTagsLocalDataSourceImpl implements NoteTagsLocalDataSource {
  final Box<dynamic> homeBox;
  final Box<dynamic> archiveBox;
  final Box<dynamic> trashBox;

  NoteTagsLocalDataSourceImpl({
    @required this.homeBox,
    @required this.archiveBox,
    @required this.trashBox,
  });

  @override
  NoteTagsModel getNoteTags(String noteKey, WriteOn box) {
    var note;
    switch (box) {
      case WriteOn.home:
        note = homeBox.get(noteKey, defaultValue: {});
        break;
      case WriteOn.archive:
        note = archiveBox.get(noteKey, defaultValue: {});
        break;
      case WriteOn.deleted:
        note = trashBox.get(noteKey, defaultValue: {});
        break;
      default:
    }
    return NoteTagsModel.fromMap(note);
  }
}

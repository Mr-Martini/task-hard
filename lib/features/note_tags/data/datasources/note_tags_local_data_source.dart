import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../model/note_tags_model.dart';

abstract class NoteTagsLocalDataSource {
  NoteTagsModel getNoteTags(String noteKey);
}

class NoteTagsLocalDataSourceImpl implements NoteTagsLocalDataSource {
  final Box<dynamic> box;

  NoteTagsLocalDataSourceImpl({@required this.box});

  @override
  NoteTagsModel getNoteTags(String noteKey) {
    final note = box.get(noteKey, defaultValue: {});
    return NoteTagsModel.fromMap(note);
  }
}

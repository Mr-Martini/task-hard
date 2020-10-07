import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../model/tags_model.dart';

const String tagsKey = 'tags_key';

abstract class TagsLocalDataSouce {
  TagsModel getTags(String noteKey);
  TagsModel getOnlyTags();
  TagsModel addTagOnNote(String noteKey, String tagName);
  TagsModel removeTagFronNote(String noteKey, String tagName);
}

class TagsLocalDataSouceImpl implements TagsLocalDataSouce {
  final Box<dynamic> box;
  final Box<dynamic> noteBox;

  TagsLocalDataSouceImpl({@required this.box, @required this.noteBox});

  @override
  TagsModel getTags(String noteKey) {
    final tagsFromDB = box.values;
    final note = noteBox.get(noteKey, defaultValue: {});
    return TagsModel.fromIterable(tagsFromDB, note);
  }

  @override
  TagsModel addTagOnNote(String noteKey, String tagName) {
    var note = noteBox.get(noteKey, defaultValue: {});
    List<String> tagsOnNote = List<String>.from(note['tags'] ?? <String>[]);
    if (!tagsOnNote.contains(tagName)) {
      tagsOnNote.add(tagName);
      note['tags'] = List<dynamic>.from(tagsOnNote);
      noteBox.put(noteKey, note);
    }
    var tag = box.get(tagName, defaultValue: null);
    if (tag == null) {
      box.put(tagName, tagName);
    }
    final tagsFromDB = box.values;
    return TagsModel.fromIterable(tagsFromDB, note);
  }

  @override
  TagsModel removeTagFronNote(String noteKey, String tagName) {
    var note = noteBox.get(noteKey, defaultValue: {});
    List<String> tags = List<String>.from(note['tags'] ?? <String>[]);
    tags.remove(tagName);
    note['tags'] = List<dynamic>.from(tags);
    noteBox.put(noteKey, note);
    final tagsFromDB = box.values;
    return TagsModel.fromIterable(tagsFromDB, note);
  }

  @override
  TagsModel getOnlyTags() {
    final tagsFromDB = box.values;
    return TagsModel.fromIterable(tagsFromDB, {});
  }
}

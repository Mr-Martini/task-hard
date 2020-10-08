import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../note/data/model/note_model.dart';
import '../../../note/domain/entities/note.dart';
import '../model/tags_model.dart';

const String tagsKey = 'tags_key';

abstract class TagsLocalDataSouce {
  TagsModel getTags(String noteKey);
  TagsModel getOnlyTags();
  TagsModel getTagForList(List<Note> notes);
  TagsModel addTagOnNote(String noteKey, String tagName);
  TagsModel addTagOnList(List<Note> notes, String tagName);
  TagsModel removeTagFronNote(String noteKey, String tagName);
  TagsModel removeTagFromList(List<Note> notes, String tagName);
}

class TagsLocalDataSouceImpl implements TagsLocalDataSouce {
  final Box<dynamic> box;
  final Box<dynamic> noteBox;

  TagsLocalDataSouceImpl({@required this.box, @required this.noteBox});

  @override
  TagsModel getTags(String noteKey) {
    final tagsFromDB = box.values;
    final note = noteBox.get(noteKey, defaultValue: {});
    return TagsModel.fromIterable(
      tagsFromDB,
      note,
      <Note>[],
    );
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
    return TagsModel.fromIterable(tagsFromDB, note, <Note>[]);
  }

  @override
  TagsModel removeTagFronNote(String noteKey, String tagName) {
    var note = noteBox.get(noteKey, defaultValue: {});
    List<String> tags = List<String>.from(note['tags'] ?? <String>[]);
    tags.remove(tagName);
    note['tags'] = List<dynamic>.from(tags);
    noteBox.put(noteKey, note);
    final tagsFromDB = box.values;
    return TagsModel.fromIterable(tagsFromDB, note, <Note>[]);
  }

  @override
  TagsModel getOnlyTags() {
    final tagsFromDB = box.values;
    return TagsModel.fromIterable(tagsFromDB, {}, <Note>[]);
  }

  @override
  TagsModel addTagOnList(List<Note> notes, String tagName) {
    final tag = box.get(tagName, defaultValue: null);
    if (tag == null) {
      box.put(tagName, tagName);
    }
    List<Note> aux = List<Note>.from(notes);
    for (Note note in notes) {
      var noteFromDB = noteBox.get(note.key, defaultValue: {});
      List<String> tagsOnNote =
          List<String>.from(noteFromDB['tags'] ?? <String>[]);
      if (!tagsOnNote.contains(tagName)) {
        int index = notes.indexOf(note);
        tagsOnNote.add(tagName);
        noteFromDB['tags'] = tagsOnNote;
        aux[index] = NoteModel.fromMap(noteFromDB);
        noteBox.put(note.key, noteFromDB);
      }
    }
    return TagsModel.fromIterable(box.values, {}, aux);
  }

  @override
  TagsModel getTagForList(List<Note> notes) {
    final tags = box.values;
    final selectedNotes = <Note>[];
    for (var note in notes) {
      final map = noteBox.get(note.key, defaultValue: {});
      selectedNotes.add(NoteModel.fromMap(map));
    }
    return TagsModel.fromIterable(tags, {}, selectedNotes);
  }

  @override
  TagsModel removeTagFromList(List<Note> notes, String tagName) {
    final tagsFromDB = box.values;
    List<Note> aux = <Note>[];
    for (Note note in notes) {
      List<String> tags = List<String>.from(note.tags);
      tags.remove(tagName);
      var noteFromDB = noteBox.get(note.key, defaultValue: {});
      noteFromDB['tags'] = List<dynamic>.from(tags);
      aux.add(NoteModel.fromMap(noteFromDB));
      noteBox.put(note.key, noteFromDB);
    }
    return TagsModel.fromIterable(tagsFromDB, {}, aux);
  }
}

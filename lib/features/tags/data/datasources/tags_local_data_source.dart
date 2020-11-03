import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../../core/Utils/write_on.dart';
import '../../../note/data/model/note_model.dart';
import '../../../note/domain/entities/note.dart';
import '../model/tags_model.dart';

const String tagsKey = 'tags_key';

abstract class TagsLocalDataSouce {
  TagsModel getTags(String noteKey, WriteOn box);
  TagsModel getOnlyTags();
  TagsModel getTagForList(List<Note> notes, WriteOn box);
  TagsModel addTagOnNote(String noteKey, String tagName, WriteOn box);
  TagsModel addTagOnList(List<Note> notes, String tagName, WriteOn box);
  TagsModel removeTagFromNote(String noteKey, String tagName, WriteOn box);
  TagsModel removeTagFromList(List<Note> notes, String tagName, WriteOn box);
}

class TagsLocalDataSouceImpl implements TagsLocalDataSouce {
  final Box<dynamic> tagBox;
  final Box<dynamic> noteBox;
  final Box<dynamic> archiveBox;
  final Box<dynamic> deletedBox;

  TagsLocalDataSouceImpl({
    @required this.tagBox,
    @required this.noteBox,
    @required this.archiveBox,
    @required this.deletedBox,
  });

  @override
  TagsModel getTags(String noteKey, WriteOn box) {
    final tagsFromDB = tagBox.values;
    var note;
    switch (box) {
      case WriteOn.home:
        note = noteBox.get(noteKey, defaultValue: {});
        break;
      case WriteOn.archive:
        note = archiveBox.get(noteKey, defaultValue: {});
        break;
      case WriteOn.deleted:
        note = deletedBox.get(noteKey, defaultValue: {});
        break;
      default:
    }
    return TagsModel.fromIterable(
      tagsFromDB,
      note,
      <Note>[],
    );
  }

  @override
  TagsModel addTagOnNote(String noteKey, String tagName, WriteOn box) {
    var note;
    switch (box) {
      case WriteOn.home:
        note = noteBox.get(noteKey, defaultValue: {});
        break;
      case WriteOn.archive:
        note = archiveBox.get(noteKey, defaultValue: {});
        break;
      case WriteOn.deleted:
        note = deletedBox.get(noteKey, defaultValue: {});
        break;
      default:
    }
    List<String> tagsOnNote = List<String>.from(note['tags'] ?? <String>[]);
    if (!tagsOnNote.contains(tagName)) {
      tagsOnNote.add(tagName);
      note['tags'] = List<dynamic>.from(tagsOnNote);
      switch (box) {
        case WriteOn.home:
          noteBox.put(noteKey, note);
          break;
        case WriteOn.archive:
          archiveBox.put(noteKey, note);
          break;
        case WriteOn.deleted:
          deletedBox.put(noteKey, note);
          break;
        default:
      }
    }
    var tag = tagBox.get(tagName, defaultValue: null);
    if (tag == null) {
      tagBox.put(tagName, tagName);
    }
    final tagsFromDB = tagBox.values;
    return TagsModel.fromIterable(tagsFromDB, note, <Note>[]);
  }

  @override
  TagsModel removeTagFromNote(String noteKey, String tagName, WriteOn box) {
    var note;
    switch (box) {
      case WriteOn.home:
        note = noteBox.get(noteKey, defaultValue: {});
        List<String> tags = List<String>.from(note['tags'] ?? <String>[]);
        tags.remove(tagName);
        note['tags'] = List<dynamic>.from(tags);
        noteBox.put(noteKey, note);
        break;
      case WriteOn.archive:
        note = archiveBox.get(noteKey, defaultValue: {});
        List<String> tags = List<String>.from(note['tags'] ?? <String>[]);
        tags.remove(tagName);
        note['tags'] = List<dynamic>.from(tags);
        archiveBox.put(noteKey, note);
        break;
      case WriteOn.deleted:
        note = deletedBox.get(noteKey, defaultValue: {});
        List<String> tags = List<String>.from(note['tags'] ?? <String>[]);
        tags.remove(tagName);
        note['tags'] = List<dynamic>.from(tags);
        deletedBox.put(noteKey, note);
        break;
      default:
    }
    final tagsFromDB = tagBox.values;
    return TagsModel.fromIterable(tagsFromDB, note, <Note>[]);
  }

  @override
  TagsModel getOnlyTags() {
    final tagsFromDB = tagBox.values;
    return TagsModel.fromIterable(tagsFromDB, {}, <Note>[]);
  }

  @override
  TagsModel addTagOnList(List<Note> notes, String tagName, WriteOn box) {
    final tag = tagBox.get(tagName, defaultValue: null);
    if (tag == null) {
      tagBox.put(tagName, tagName);
    }
    List<Note> aux = List<Note>.from(notes);
    for (Note note in notes) {
      switch (box) {
        case WriteOn.home:
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
          break;
        case WriteOn.archive:
          var noteFromDB = archiveBox.get(note.key, defaultValue: {});
          List<String> tagsOnNote =
              List<String>.from(noteFromDB['tags'] ?? <String>[]);
          if (!tagsOnNote.contains(tagName)) {
            int index = notes.indexOf(note);
            tagsOnNote.add(tagName);
            noteFromDB['tags'] = tagsOnNote;
            aux[index] = NoteModel.fromMap(noteFromDB);
            archiveBox.put(note.key, noteFromDB);
          }
          break;
        case WriteOn.deleted:
          var noteFromDB = deletedBox.get(note.key, defaultValue: {});
          List<String> tagsOnNote =
              List<String>.from(noteFromDB['tags'] ?? <String>[]);
          if (!tagsOnNote.contains(tagName)) {
            int index = notes.indexOf(note);
            tagsOnNote.add(tagName);
            noteFromDB['tags'] = tagsOnNote;
            aux[index] = NoteModel.fromMap(noteFromDB);
            deletedBox.put(note.key, noteFromDB);
          }
          break;
        default:
      }
    }
    return TagsModel.fromIterable(tagBox.values, {}, aux);
  }

  @override
  TagsModel getTagForList(List<Note> notes, WriteOn box) {
    final tags = tagBox.values;
    final selectedNotes = <Note>[];
    for (var note in notes) {
      var map;
      switch (box) {
        case WriteOn.home:
          map = noteBox.get(note.key, defaultValue: {});   
          break;
        case WriteOn.archive:
          map = archiveBox.get(note.key, defaultValue: {});   
          break;
        case WriteOn.deleted:
          map = deletedBox.get(note.key, defaultValue: {});   
          break;    
        default:
      }
      selectedNotes.add(NoteModel.fromMap(map));
    }
    return TagsModel.fromIterable(tags, {}, selectedNotes);
  }

  @override
  TagsModel removeTagFromList(List<Note> notes, String tagName, WriteOn box) {
    final tagsFromDB = tagBox.values;
    List<Note> aux = <Note>[];
    for (Note note in notes) {
      switch (box) {
        case WriteOn.home:
          List<String> tags = List<String>.from(note.tags);
          tags.remove(tagName);
          var noteFromDB = noteBox.get(note.key, defaultValue: {});
          noteFromDB['tags'] = List<dynamic>.from(tags);
          aux.add(NoteModel.fromMap(noteFromDB));
          noteBox.put(note.key, noteFromDB);
          break;
        case WriteOn.archive:
          List<String> tags = List<String>.from(note.tags);
          tags.remove(tagName);
          var noteFromDB = archiveBox.get(note.key, defaultValue: {});
          noteFromDB['tags'] = List<dynamic>.from(tags);
          aux.add(NoteModel.fromMap(noteFromDB));
          archiveBox.put(note.key, noteFromDB);
          break;
        case WriteOn.deleted:
          List<String> tags = List<String>.from(note.tags);
          tags.remove(tagName);
          var noteFromDB = deletedBox.get(note.key, defaultValue: {});
          noteFromDB['tags'] = List<dynamic>.from(tags);
          aux.add(NoteModel.fromMap(noteFromDB));
          deletedBox.put(note.key, noteFromDB);
          break;
        default:
      }
    }
    return TagsModel.fromIterable(tagsFromDB, {}, aux);
  }
}

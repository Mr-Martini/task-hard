import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:task_hard/features/home_app_bar/data/model/home_app_bar_model.dart';
import 'package:task_hard/features/note/data/model/note_model.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

abstract class HomeAppBarLocalDataSource {
  HomeAppBarModel addNote(List<Note> selectedNotes);
  HomeAppBarModel changeColor(List<Note> notes, Color color);
  HomeAppBarModel deleteNotes(List<Note> selectedNotes);
  HomeAppBarModel undoDeleteNotes(List<Note> selectedNotes);
}

class HomeAppBarLocalDataSourceImpl implements HomeAppBarLocalDataSource {
  final Box<dynamic> noteBox;

  HomeAppBarLocalDataSourceImpl({@required this.noteBox});

  @override
  HomeAppBarModel addNote(List<Note> selectedNotes) {
    return HomeAppBarModel.fromList(selectedNotes);
  }

  @override
  HomeAppBarModel changeColor(List<Note> notes, Color color) {
    List<Note> newNotes = [];
    for (Note note in notes) {
      String key = note.key;
      var noteFromDB = noteBox.get(key, defaultValue: {});
      noteFromDB['color'] = color.value;
      newNotes.add(NoteModel.fromMap(noteFromDB));
      noteBox.put(key, noteFromDB);
    }
    return HomeAppBarModel.fromList(newNotes);
  }

  @override
  HomeAppBarModel deleteNotes(List<Note> selectedNotes) {
    for (Note note in selectedNotes) {
      noteBox.delete(note.key);
    }
    return HomeAppBarModel.fromList(<Note>[]);
  }

  @override
  HomeAppBarModel undoDeleteNotes(List<Note> selectedNotes) {
    for (NoteModel note in selectedNotes) {
      noteBox.put(note.key, note.toMap());
    }
    return HomeAppBarModel.fromList(selectedNotes);
  }
}

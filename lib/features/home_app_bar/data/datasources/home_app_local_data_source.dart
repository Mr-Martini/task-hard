import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../../../controllers/reminder-controller/reminder-controller.dart';
import '../../../note/data/model/note_model.dart';
import '../../../note/domain/entities/note.dart';
import '../model/home_app_bar_model.dart';

abstract class HomeAppBarLocalDataSource {
  HomeAppBarModel addNote(List<Note> selectedNotes);
  HomeAppBarModel changeColor(List<Note> notes, Color color);
  HomeAppBarModel deleteNotes(List<Note> selectedNotes);
  HomeAppBarModel undoDeleteNotes(List<Note> selectedNotes);
  HomeAppBarModel undoArchiveNotes(List<Note> selectedNotes);
  HomeAppBarModel archiveNotes(List<Note> selectedNotes);
  HomeAppBarModel deleteReminder(List<Note> selectedNotes);
  HomeAppBarModel putReminder(
      List<Note> selectedNotes, DateTime scheduledDate, String repeat);
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
      ReminderController.cancel(note.key.hashCode);
    }
    return HomeAppBarModel.fromList(<Note>[]);
  }

  @override
  HomeAppBarModel undoDeleteNotes(List<Note> selectedNotes) {
    for (NoteModel note in selectedNotes) {
      noteBox.put(note.key, note.toMap());
      ReminderController.scheduleNotification(note.key, note.title, note.note,
          note.key.hashCode, note.reminder, note.repeat);
    }
    return HomeAppBarModel.fromList(selectedNotes);
  }

  @override
  HomeAppBarModel archiveNotes(List<Note> selectedNotes) {
    //TODO: put each note on archived_notes box
    for (Note note in selectedNotes) {
      noteBox.delete(note.key);
    }
    return HomeAppBarModel.fromList(<Note>[]);
  }

  @override
  HomeAppBarModel undoArchiveNotes(List<Note> selectedNotes) {
    for (NoteModel note in selectedNotes) {
      noteBox.put(note.key, note.toMap());
    }
    return HomeAppBarModel.fromList(selectedNotes);
  }

  @override
  HomeAppBarModel putReminder(
      List<Note> selectedNotes, DateTime scheduledDate, String repeat) {
    for (NoteModel note in selectedNotes) {
      var noteAsMap = note.toMap();
      noteAsMap['reminder'] = scheduledDate;
      noteAsMap['expired'] = false;
      noteAsMap['repeat'] = repeat;
      NoteModel noteUpdated = NoteModel.fromMap(noteAsMap);
      noteBox.put(note.key, noteUpdated.toMap());
      ReminderController.scheduleNotification(note.key, note.title, note.note,
          note.reminderKey, scheduledDate, repeat);
    }
    return HomeAppBarModel.fromList(selectedNotes);
  }

  @override
  HomeAppBarModel deleteReminder(List<Note> selectedNotes) {
    for (NoteModel note in selectedNotes) {
      var noteAsMap = note.toMap();
      noteAsMap['reminder'] = null;
      noteAsMap['expired'] = false;
      NoteModel updatedNote = NoteModel.fromMap(noteAsMap);
      noteBox.put(note.key, updatedNote.toMap());
      ReminderController.cancel(note.reminderKey ?? note.key.hashCode);
    }
    return HomeAppBarModel.fromList(selectedNotes);
  }
}

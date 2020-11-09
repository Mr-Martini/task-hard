import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../../../controllers/reminder-controller/reminder-controller.dart';
import '../../../../core/Utils/write_on.dart';
import '../../../note/data/model/note_model.dart';
import '../../../note/domain/entities/note.dart';
import '../model/home_app_bar_model.dart';

abstract class HomeAppBarLocalDataSource {
  HomeAppBarModel addNote(List<Note> selectedNotes);
  HomeAppBarModel changeColor(List<Note> notes, Color color, WriteOn box);
  HomeAppBarModel deleteNotes(List<Note> selectedNotes, WriteOn box);
  HomeAppBarModel undoDeleteNotes(List<Note> selectedNotes, WriteOn box);
  HomeAppBarModel undoArchiveNotes(List<Note> selectedNotes, WriteOn box);
  HomeAppBarModel archiveNotes(List<Note> selectedNotes, WriteOn box);
  HomeAppBarModel deleteReminder(List<Note> selectedNotes, WriteOn box);
  HomeAppBarModel putReminder(
    List<Note> selectedNotes,
    DateTime scheduledDate,
    String repeat,
    WriteOn box,
  );
}

class HomeAppBarLocalDataSourceImpl implements HomeAppBarLocalDataSource {
  final Box<dynamic> noteBox;
  final Box<dynamic> archiveBox;
  final Box<dynamic> deleteBox;

  HomeAppBarLocalDataSourceImpl({
    @required this.noteBox,
    @required this.archiveBox,
    @required this.deleteBox,
  });

  @override
  HomeAppBarModel addNote(List<Note> selectedNotes) {
    return HomeAppBarModel.fromList(selectedNotes);
  }

  @override
  HomeAppBarModel changeColor(List<Note> notes, Color color, WriteOn box) {
    List<Note> newNotes = [];
    for (Note note in notes) {
      String key = note.key;
      switch (box) {
        case WriteOn.home:
          var noteFromDB = noteBox.get(key, defaultValue: {});
          noteFromDB['color'] = color.value;
          newNotes.add(NoteModel.fromMap(noteFromDB));
          noteBox.put(key, noteFromDB);
          break;
        case WriteOn.archive:
          var noteFromDB = archiveBox.get(key, defaultValue: {});
          noteFromDB['color'] = color.value;
          newNotes.add(NoteModel.fromMap(noteFromDB));
          archiveBox.put(key, noteFromDB);
          break;
        case WriteOn.deleted:
          var noteFromDB = deleteBox.get(key, defaultValue: {});
          noteFromDB['color'] = color.value;
          newNotes.add(NoteModel.fromMap(noteFromDB));
          deleteBox.put(key, noteFromDB);
          break;
        default:
      }
    }
    return HomeAppBarModel.fromList(newNotes);
  }

  @override
  HomeAppBarModel deleteNotes(List<Note> selectedNotes, WriteOn box) {
    for (NoteModel note in selectedNotes) {
      switch (box) {
        case WriteOn.home:
          noteBox.delete(note.key);
          deleteBox.put(note.key, note.toMap());
          break;
        case WriteOn.archive:
          archiveBox.delete(note.key);
          deleteBox.put(note.key, note.toMap());
          break;
        case WriteOn.deleted:
          deleteBox.delete(note.key);
          break;
        default:
      }
      ReminderController.cancel(note.key.hashCode);
    }
    return HomeAppBarModel.fromList(<Note>[]);
  }

  @override
  HomeAppBarModel undoDeleteNotes(List<Note> selectedNotes, WriteOn box) {
    for (NoteModel note in selectedNotes) {
      switch (box) {
        case WriteOn.home:
          noteBox.put(note.key, note.toMap());
          deleteBox.delete(note.key);
          break;
        case WriteOn.archive:
          archiveBox.put(note.key, note.toMap());
          deleteBox.delete(note.key);
          break;
        case WriteOn.deleted:
          deleteBox.put(note.key, note.toMap());
          break;
        default:
      }

      ReminderController.scheduleNotification(note.key, note.title, note.note,
          note.key.hashCode, note.reminder, note.repeat);
    }
    return HomeAppBarModel.fromList(selectedNotes);
  }

  @override
  HomeAppBarModel archiveNotes(List<Note> selectedNotes, WriteOn box) {
    for (NoteModel note in selectedNotes) {
      switch (box) {
        case WriteOn.home:
          noteBox.delete(note.key);
          archiveBox.put(note.key, note.toMap());
          break;
        case WriteOn.archive:
          archiveBox.delete(note.key);
          noteBox.put(note.key, note.toMap());
          break;
        case WriteOn.deleted:
          deleteBox.delete(note.key);
          archiveBox.put(note.key, note.toMap());
          break;
        default:
      }
    }
    return HomeAppBarModel.fromList(<Note>[]);
  }

  @override
  HomeAppBarModel undoArchiveNotes(List<Note> selectedNotes, WriteOn box) {
    for (NoteModel note in selectedNotes) {
      switch (box) {
        case WriteOn.home:
          noteBox.put(note.key, note.toMap());
          archiveBox.delete(note.key);
          break;
        case WriteOn.archive:
          archiveBox.put(note.key, note.toMap());
          noteBox.delete(note.key);
          break;
        case WriteOn.deleted:
          archiveBox.delete(note.key);
          deleteBox.put(note.key, note.toMap());
          break;
        default:
      }
    }
    return HomeAppBarModel.fromList(selectedNotes);
  }

  @override
  HomeAppBarModel putReminder(
    List<Note> selectedNotes,
    DateTime scheduledDate,
    String repeat,
    WriteOn box,
  ) {
    switch (box) {
      case WriteOn.home:
        for (NoteModel note in selectedNotes) {
          var noteAsMap = note.toMap();
          noteAsMap['reminder'] = scheduledDate;
          noteAsMap['expired'] = false;
          noteAsMap['repeat'] = repeat;
          NoteModel noteUpdated = NoteModel.fromMap(noteAsMap);
          noteBox.put(note.key, noteUpdated.toMap());
          ReminderController.scheduleNotification(note.key, note.title,
              note.note, note.reminderKey, scheduledDate, repeat);
        }
        break;
      case WriteOn.archive:
        for (NoteModel note in selectedNotes) {
          var noteAsMap = note.toMap();
          noteAsMap['reminder'] = scheduledDate;
          noteAsMap['expired'] = false;
          noteAsMap['repeat'] = repeat;
          NoteModel noteUpdated = NoteModel.fromMap(noteAsMap);
          archiveBox.put(note.key, noteUpdated.toMap());
          ReminderController.scheduleNotification(note.key, note.title,
              note.note, note.reminderKey, scheduledDate, repeat);
        }
        break;
      case WriteOn.deleted:
        for (NoteModel note in selectedNotes) {
          var noteAsMap = note.toMap();
          noteAsMap['reminder'] = scheduledDate;
          noteAsMap['expired'] = false;
          noteAsMap['repeat'] = repeat;
          NoteModel noteUpdated = NoteModel.fromMap(noteAsMap);
          deleteBox.put(note.key, noteUpdated.toMap());
          ReminderController.scheduleNotification(note.key, note.title,
              note.note, note.reminderKey, scheduledDate, repeat);
        }
        break;
      default:
    }
    return HomeAppBarModel.fromList(selectedNotes);
  }

  @override
  HomeAppBarModel deleteReminder(List<Note> selectedNotes, WriteOn box) {
    for (NoteModel note in selectedNotes) {
      var noteAsMap = note.toMap();
      noteAsMap['reminder'] = null;
      noteAsMap['expired'] = false;
      NoteModel updatedNote = NoteModel.fromMap(noteAsMap);
      switch (box) {
        case WriteOn.home:
          noteBox.put(note.key, updatedNote.toMap());
          break;
        case WriteOn.archive:
          archiveBox.put(note.key, updatedNote.toMap());
          break;
        default:
      }
      ReminderController.cancel(note.reminderKey ?? note.key.hashCode);
    }
    return HomeAppBarModel.fromList(selectedNotes);
  }
}

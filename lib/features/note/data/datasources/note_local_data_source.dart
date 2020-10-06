import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:task_hard/controllers/reminder-controller/reminder-controller.dart';
import 'package:uuid/uuid.dart';

import '../model/note_model.dart';

abstract class NoteLocalDataSource {
  NoteModel getNoteByKey(String key);
  NoteModel writeNoteContent(String content, String key);
  NoteModel writeNoteTitle(String title, String key);
  NoteModel writeNoteColor(Color color, String key);
  NoteModel writeNoteReminder(
    DateTime reminder,
    TimeOfDay time,
    String repeat,
    String key,
    String title,
    String message,
  );
  NoteModel deleteNoteReminder(String key);
  NoteModel deleteNote(String key);
  NoteModel archiveNote(String key);
  NoteModel copyNote(String key, String title, String content, Color color);
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final Box<dynamic> noteBox;

  NoteLocalDataSourceImpl({@required this.noteBox});

  @override
  NoteModel getNoteByKey(String key) {
    final map = noteBox.get(key, defaultValue: null);

    if (map != null) {
      return NoteModel.fromMap(map);
    }
    return null;
  }

  @override
  NoteModel writeNoteContent(String content, String key) {
    final note = _addContent(key, content);
    noteBox.put(key, note);

    return NoteModel.fromMap(note);
  }

  @override
  NoteModel writeNoteTitle(String title, String key) {
    final note = _addTitle(key, title);
    noteBox.put(key, note);

    return NoteModel.fromMap(note);
  }

  @override
  NoteModel writeNoteColor(Color color, String key) {
    final note = _addColor(key, color);
    noteBox.put(key, note);

    return NoteModel.fromMap(note);
  }

  @override
  NoteModel writeNoteReminder(
    DateTime reminder,
    TimeOfDay time,
    String repeat,
    String key,
    String title,
    String message,
  ) {
    final note = _addReminder(key, time, repeat, reminder, title, message);
    noteBox.put(key, note);

    return NoteModel.fromMap(note);
  }

  @override
  NoteModel deleteNoteReminder(String key) {
    final note = noteBox.get(key, defaultValue: {});

    note['reminder'] = null;

    noteBox.put(key, note);

    ReminderController.cancel(key.hashCode);

    return NoteModel.fromMap(note);
  }

  @override
  NoteModel deleteNote(String key) {
    final note = noteBox.get(key, defaultValue: {});

    noteBox.delete(key);

    ReminderController.cancel(key.hashCode);

    //TODO: put not on delete_notes box

    return NoteModel.fromMap(note);
  }

  @override
  NoteModel archiveNote(String key) {
    final note = noteBox.get(key, defaultValue: {});

    noteBox.delete(key);

    //TODO: put note on archived_notes box

    return NoteModel.fromMap(note);
  }

  @override
  NoteModel copyNote(String key, String title, String content, Color color) {
    Map<String, dynamic> copy = <String, dynamic>{};
    copy['key'] = key;
    copy['title'] = title;
    copy['note'] = content;
    copy['color'] = color.value;
    copy['lastEdited'] = DateTime.now();

    noteBox.put(key, copy);

    return NoteModel.fromMap(copy);
  }

  dynamic _addContent(String key, String value) {
    var note = noteBox.get(key, defaultValue: {});

    note['note'] = value;
    note['lastEdited'] = DateTime.now();
    note['key'] = key;

    return note;
  }

  dynamic _addTitle(String key, String value) {
    var note = noteBox.get(key, defaultValue: {});

    note['title'] = value;
    note['lastEdited'] = DateTime.now();
    note['key'] = key;

    return note;
  }

  dynamic _addColor(String key, Color color) {
    var note = noteBox.get(key, defaultValue: {});

    note['color'] = color.value;
    note['key'] = key;

    return note;
  }

  dynamic _addReminder(
    String key,
    TimeOfDay time,
    String repeat,
    DateTime reminder,
    String title,
    String message,
  ) {
    var note = noteBox.get(key, defaultValue: {});

    DateTime aux = DateTime(
        reminder.year, reminder.month, reminder.day, time.hour, time.minute);

    ReminderController.scheduleNotification(
      key,
      title,
      message,
      key.hashCode,
      aux,
      repeat,
    );

    note['reminder'] = aux;
    note['repeat'] = repeat;
    note['key'] = key;
    note['expired'] = false;

    return note;
  }
}

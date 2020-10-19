import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../../controllers/reminder-controller/reminder-controller.dart';
import '../../../../core/Utils/write_on.dart';
import '../model/note_model.dart';

abstract class NoteLocalDataSource {
  NoteModel getNoteByKey(String key, WriteOn box);
  NoteModel writeNoteContent(String content, String key, WriteOn box);
  NoteModel writeNoteTitle(String title, String key, WriteOn box);
  NoteModel writeNoteColor(Color color, String key, WriteOn box);
  NoteModel writeNoteReminder(
    DateTime reminder,
    TimeOfDay time,
    String repeat,
    String key,
    String title,
    String message,
    WriteOn box,
  );
  NoteModel deleteNoteReminder(String key, WriteOn box);
  NoteModel deleteNote(String key, WriteOn box);
  NoteModel archiveNote(String key, WriteOn box);
  NoteModel copyNote(
      String key, String title, String content, Color color, WriteOn box);
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final Box<dynamic> homeBox;
  final Box<dynamic> archiveBox;
  final Box<dynamic> deleteBox;

  NoteLocalDataSourceImpl({
    @required this.homeBox,
    @required this.archiveBox,
    @required this.deleteBox,
  });

  @override
  NoteModel getNoteByKey(String key, WriteOn box) {
    var map = {};

    switch (box) {
      case WriteOn.home:
        map = homeBox.get(key, defaultValue: null);
        break;
      case WriteOn.archive:
        map = archiveBox.get(key, defaultValue: null);
        break;
      case WriteOn.deleted:
        map = deleteBox.get(key, defaultValue: null);
        break;  
      default:
    }

    if (map != null) {
      return NoteModel.fromMap(map);
    }
    return null;
  }

  @override
  NoteModel writeNoteContent(String content, String key, WriteOn box) {
    final note = _addContent(key, content, box);
    return note;
  }

  @override
  NoteModel writeNoteTitle(String title, String key, WriteOn box) {
    final note = _addTitle(key, title, box);
    return note;
  }

  @override
  NoteModel writeNoteColor(Color color, String key, WriteOn box) {
    final note = _addColor(key, color, box);
    return note;
  }

  @override
  NoteModel writeNoteReminder(
    DateTime reminder,
    TimeOfDay time,
    String repeat,
    String key,
    String title,
    String message,
    WriteOn box,
  ) {
    final note = _addReminder(key, time, repeat, reminder, title, message, box);

    return note;
  }

  @override
  NoteModel deleteNoteReminder(String key, WriteOn box) {
    var note;

    switch (box) {
      case WriteOn.home:
        note = homeBox.get(key, defaultValue: {});
        note['reminder'] = null;
        note['expired'] = false;
        homeBox.put(key, note);
        break;
      case WriteOn.archive:
        note = archiveBox.get(key, defaultValue: {});
        note['reminder'] = null;
        note['expired'] = false;
        archiveBox.put(key, note);
        break;
      default:
    }

    ReminderController.cancel(key.hashCode);

    return NoteModel.fromMap(note);
  }

  @override
  NoteModel deleteNote(String key, WriteOn box) {
    var note;

    switch (box) {
      case WriteOn.home:
        note = homeBox.get(key, defaultValue: {});
        homeBox.delete(key);
        deleteBox.put(key, note);
        break;
      case WriteOn.archive:
        note = archiveBox.get(key, defaultValue: {});
        archiveBox.delete(key);
        deleteBox.put(key, note);
        break;
      case WriteOn.deleted:
        deleteBox.delete(key);
        break;  
      default:
    }

    ReminderController.cancel(key.hashCode);

    return NoteModel.fromMap(note);
  }

  @override
  NoteModel archiveNote(String key, WriteOn box) {
    var note;

    switch (box) {
      case WriteOn.home:
        note = homeBox.get(key, defaultValue: {});
        homeBox.delete(key);
        break;
      default:
    }

    archiveBox.put(key, note);

    return NoteModel.fromMap(note);
  }

  @override
  NoteModel copyNote(
      String key, String title, String content, Color color, WriteOn box) {
    Map<String, dynamic> copy = <String, dynamic>{};
    copy['key'] = key;
    copy['title'] = title;
    copy['note'] = content;
    copy['color'] = color.value;
    copy['lastEdited'] = DateTime.now();

    switch (box) {
      case WriteOn.home:
        homeBox.put(key, copy);
        break;
      case WriteOn.archive:
        archiveBox.put(key, copy);
        break;
      default:
    }

    return NoteModel.fromMap(copy);
  }

  NoteModel _addContent(String key, String value, WriteOn box) {
    var note;

    switch (box) {
      case WriteOn.home:
        note = homeBox.get(key, defaultValue: {});
        break;
      case WriteOn.archive:
        note = archiveBox.get(key, defaultValue: {});
        break;
      default:
        break;
    }

    note['note'] = value;
    note['lastEdited'] = DateTime.now();
    note['key'] = key;

    ReminderController.scheduleNotification(key, note['title'], note['note'],
        key.hashCode, note['reminder'], note['repeat']);

    switch (box) {
      case WriteOn.home:
        homeBox.put(key, note);
        break;
      case WriteOn.archive:
        archiveBox.put(key, note);
        break;
      default:
        break;
    }

    return NoteModel.fromMap(note);
  }

  NoteModel _addTitle(String key, String value, WriteOn box) {
    var note;

    switch (box) {
      case WriteOn.home:
        note = homeBox.get(key, defaultValue: {});
        break;
      case WriteOn.archive:
        note = archiveBox.get(key, defaultValue: {});
        break;
      default:
        break;
    }

    note['title'] = value;
    note['lastEdited'] = DateTime.now();
    note['key'] = key;

    ReminderController.scheduleNotification(key, note['title'], note['note'],
        key.hashCode, note['reminder'], note['repeat']);

    switch (box) {
      case WriteOn.home:
        homeBox.put(key, note);
        break;
      case WriteOn.archive:
        archiveBox.put(key, note);
        break;
      default:
        break;
    }

    return NoteModel.fromMap(note);
  }

  NoteModel _addColor(String key, Color color, WriteOn box) {
    var note;

    switch (box) {
      case WriteOn.home:
        note = homeBox.get(key, defaultValue: {});
        break;
      case WriteOn.archive:
        note = archiveBox.get(key, defaultValue: {});
        break;
      default:
        break;
    }

    note['color'] = color.value;
    note['key'] = key;

    return NoteModel.fromMap(note);
  }

  NoteModel _addReminder(
    String key,
    TimeOfDay time,
    String repeat,
    DateTime reminder,
    String title,
    String message,
    WriteOn box,
  ) {
    var note;

    switch (box) {
      case WriteOn.home:
        note = homeBox.get(key, defaultValue: {});
        break;
      case WriteOn.archive:
        note = archiveBox.get(key, defaultValue: {});
        break;
      default:
        break;
    }

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

    switch (box) {
      case WriteOn.home:
        homeBox.put(key, note);
        break;
      case WriteOn.archive:
        archiveBox.put(key, note);
        break;
      default:
        break;
    }

    return NoteModel.fromMap(note);
  }
}

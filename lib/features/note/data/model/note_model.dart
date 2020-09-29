import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

class NoteModel extends Equatable implements Note {
  final String key;
  final String title;
  final String note;
  final Color color;
  final DateTime reminder;
  final int reminderKey;
  final List<dynamic> tags;
  final DateTime lastEdited;
  final String repeat;
  final bool expired;

  NoteModel({
    @required this.key,
    @required this.title,
    @required this.note,
    @required this.color,
    @required this.reminder,
    @required this.reminderKey,
    @required this.tags,
    @required this.lastEdited,
    @required this.repeat,
    @required this.expired,
  });

  factory NoteModel.fromMap(dynamic map) {
    return NoteModel(
      key: map['key'],
      title: map['title'],
      note: map['note'],
      color: map['color'] != null ? Color(map['color']) : null,
      reminder: map['reminder'],
      reminderKey: map['reminderKey'],
      tags: map['tags'],
      lastEdited: map['lastEdited'],
      repeat: map['repeat'],
      expired: map['expired'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "key": key,
      "title": title,
      "note": note,
      "color": color?.value,
      "reminder": reminder,
      "reminderKey": reminderKey,
      "tags": tags,
      "lastEdited": lastEdited,
      "repeat": repeat,
      "expired": expired,
    };
  }

  @override
  List<Object> get props => [
        key,
        title,
        note,
        color,
        reminder,
        reminderKey,
        tags,
        lastEdited,
        repeat
      ];
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Note extends Equatable {
  final String key;
  final String title;
  final String note;
  final String repeat;
  final Color color;
  final DateTime reminder;
  final int reminderKey;
  final List<dynamic> tags;
  final DateTime lastEdited;
  final bool expired;

  Note({
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

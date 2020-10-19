import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entity/note_reminder.dart';

class NoteReminderModel extends Equatable implements NoteReminder {
  final DateTime reminder;
  final String repeat;
  final bool expired;

  NoteReminderModel({
    @required this.reminder,
    @required this.repeat,
    @required this.expired,
  });

  @override
  List<Object> get props => [reminder];

  factory NoteReminderModel.fromMap(dynamic map) {
    if (map != null) {
      return NoteReminderModel(
        reminder: map['reminder'],
        repeat: map['repeat'],
        expired: map['expired'] ?? false,
      );
    }
    return NoteReminderModel(
      reminder: null,
      repeat: null,
      expired: false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_hard/controllers/repeat-controller/repeat-controller.dart';
import 'package:task_hard/features/note/data/model/note_model.dart';

void main() {
  final now = DateTime.now();
  group(
    'noteModel',
    () {
      final model = NoteModel(
        key: 'key',
        title: 'title',
        note: 'note',
        color: Color(Colors.pink.value),
        reminder: now,
        reminderKey: 'key'.hashCode,
        tags: [],
        lastEdited: now,
        repeat: Repeat.NO_REPEAT,
        expired: false,
      );

      final map = <String, dynamic>{
        "key": "key",
        "title": "title",
        "note": "note",
        "color": Colors.pink.value,
        "reminder": now,
        "reminderKey": "key".hashCode,
        "tags": [],
        "lastEdited": now,
        "repeat": Repeat.NO_REPEAT,
        "expired": false,

        ///
      };
      test(
        'should return the correct model from map',
        () {
          final result = NoteModel.fromMap(map);

          expect(result, model);
        },
      );

      test(
        'should return the correct json from the model',
        () {
          DateTime now = DateTime.now();

          final expectedMap = <String, dynamic>{
            "key": "key",
            "title": "title",
            "note": "note",
            "color": Colors.pink.value,
            "reminder": now,
            "reminderKey": "key".hashCode,
            "tags": [],
            "lastEdited": now,
            'repeat': Repeat.NO_REPEAT,
            "expired": false,
          };

          final noteModel = NoteModel(
            key: "key",
            title: "title",
            note: "note",
            color: Color(Colors.pink.value),
            reminder: now,
            reminderKey: "key".hashCode,
            tags: [],
            lastEdited: now,
            repeat: Repeat.NO_REPEAT,
            expired: false,
          );

          final result = noteModel.toMap();

          expect(result, expectedMap);
        },
      );
    },
  );
}

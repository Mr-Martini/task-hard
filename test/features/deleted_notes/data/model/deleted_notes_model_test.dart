import 'package:flutter_test/flutter_test.dart';
import 'package:task_hard/controllers/repeat-controller/repeat-controller.dart';
import 'package:task_hard/features/delete_notes/data/model/deleted_notes_model.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

void main() {
  final DateTime now = DateTime.now();
  final Iterable<dynamic> emptyIterable = [];
  final Iterable<dynamic> nullIterable = null;
  final Iterable<dynamic> iterable = [
    {
      'title': 'title',
      'lastEdited': now,
      'key': 'key',
      'note': 'note',
    },
    {
      'title': 'eita',
      'lastEdited': now.add(Duration(hours: 2)),
      'key': 'etia',
      'note': 'eita'
    },
    {
      'title': 'pimba',
      'lastEdited': now.add(Duration(hours: 6)),
      'key': 'pimbada',
      'note': 'pimba'
    },
  ];

  final expectedList = DeletedNotesModel(
    notes: <Note>[
      Note(
        color: null,
        key: 'pimbada',
        title: 'pimba',
        note: 'pimba',
        lastEdited: now.add(Duration(hours: 6)),
        reminder: null,
        reminderKey: null,
        repeat: null,
        expired: null,
        tags: null,
      ),
      Note(
        color: null,
        key: 'etia',
        title: 'eita',
        note: 'eita',
        lastEdited: now.add(Duration(hours: 2)),
        reminder: null,
        reminderKey: null,
        repeat: null,
        expired: null,
        tags: null,
      ),
      Note(
        color: null,
        key: 'key',
        title: 'title',
        note: 'note',
        lastEdited: now,
        reminder: null,
        reminderKey: null,
        repeat: null,
        expired: null,
        tags: null,
      ),
    ],
  );

  test(
    'should return DeletedNotes with empty notes attribute when a empty iterable is provided',
    () {
      final result = DeletedNotesModel.fromIterable(emptyIterable);

      expect(result, DeletedNotesModel(notes: <Note>[]));
    },
  );

  test(
    'should return DeletedNotes with empty notes attribute when a null iterable is provided',
    () {
      final result = DeletedNotesModel.fromIterable(nullIterable);

      expect(result, DeletedNotesModel(notes: <Note>[]));
    },
  );

  test(
    'should return DeletedNotes when a iterable is provided',
    () {
      final result = DeletedNotesModel.fromIterable(iterable);

      expect(result, isA<DeletedNotesModel>());
    },
  );
}

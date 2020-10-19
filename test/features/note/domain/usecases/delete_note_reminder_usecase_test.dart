import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/controllers/repeat-controller/repeat-controller.dart';
import 'package:task_hard/core/Utils/write_on.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/note/domain/repositories/note_repository.dart';
import 'package:task_hard/features/note/domain/usecases/delete_note_reminder_usecase.dart';

class MockRepository extends Mock implements NoteRepository {}

void main() {
  MockRepository repository;
  DeleteNoteReminderUseCase useCase;

  setUp(
    () {
      repository = MockRepository();
      useCase = DeleteNoteReminderUseCase(repository: repository);
    },
  );

  final now = DateTime.now();

  final note = Note(
    key: 'key',
    title: 'title',
    note: 'note',
    color: Colors.pink,
    reminder: null,
    reminderKey: 'key'.hashCode,
    tags: [],
    lastEdited: now,
    repeat: Repeat.NO_REPEAT,
    expired: false,
  );

  test(
    'should return Right<Note> when deleteNoteReminder is called',
    () {
      when(repository.deleteNoteReminder(any, any)).thenReturn(Right(note));

      final result = useCase(DeleteNoteReminderParams(key: 'key', box: WriteOn.home));

      verify(repository.deleteNoteReminder('key', WriteOn.home));

      expect(result, Right(note));
    },
  );
}

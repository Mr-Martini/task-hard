import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/controllers/repeat-controller/repeat-controller.dart';
import 'package:task_hard/core/Utils/write_on.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/note/domain/repositories/note_repository.dart';
import 'package:task_hard/features/note/domain/usecases/write_note_reminder_usecase.dart';

class MockNoteRepository extends Mock implements NoteRepository {}

void main() {
  MockNoteRepository repository;
  WriteNoteReminderUseCase useCase;

  setUp(
    () {
      repository = MockNoteRepository();
      useCase = WriteNoteReminderUseCase(repository: repository);
    },
  );

  final now = DateTime.now();
  final nowTime = TimeOfDay.now();

  final model = Note(
    key: 'dd',
    title: 'fdsgf',
    note: 'dfsgdfgf',
    color: Colors.blue,
    reminder: DateTime.now(),
    reminderKey: 1561,
    tags: [],
    lastEdited: now,
    repeat: Repeat.NO_REPEAT,
    expired: false,
  );
  test(
    'should return [Right<Note>] when writeNoteReminder is called',
    () {
      when(repository.writeNoteReminder(any, any, any, any, any, any, any))
          .thenReturn(Right(model));

      final result = useCase(
        WriteNoteReminderParams(
          reminder: now,
          key: 'key',
          time: nowTime,
          repeat: Repeat.NO_REPEAT,
          title: 'message',
          message: 'message',
          box: WriteOn.home,
        ),
      );

      verify(repository.writeNoteReminder(
          now, nowTime, Repeat.NO_REPEAT, 'key', 'message', 'message', WriteOn.home));
      expect(result, Right(model));
    },
  );
}

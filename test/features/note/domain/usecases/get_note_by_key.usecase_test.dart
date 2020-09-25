import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/controllers/repeat-controller/repeat-controller.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/note/domain/repositories/note_repository.dart';
import 'package:task_hard/features/note/domain/usecases/get_note_by_key_usecase.dart';

class MockNoteRepository extends Mock implements NoteRepository {}

void main() {
  MockNoteRepository repository;
  GetNoteByKeyUseCase useCase;

  setUp(
    () {
      repository = MockNoteRepository();
      useCase = GetNoteByKeyUseCase(repository: repository);
    },
  );

  final now = DateTime.now();

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
    'should return [Right<Note>] when getNoteByKey is called',
    () {
      when(repository.getNoteByKey(any)).thenReturn(Right(model));

      final result = useCase(GetNoteByKeyParams(key: 'dd'));

      verify(repository.getNoteByKey('dd'));
      expect(result, Right(model));
    },
  );
}

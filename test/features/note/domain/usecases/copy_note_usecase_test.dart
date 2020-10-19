import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/core/Utils/write_on.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/note/domain/repositories/note_repository.dart';
import 'package:task_hard/features/note/domain/usecases/copy_note_usecase.dart';

class MockNoteRepository extends Mock implements NoteRepository {}

void main() {
  MockNoteRepository repository;
  CopyNoteUseCase useCase;

  setUp(
    () {
      repository = MockNoteRepository();
      useCase = CopyNoteUseCase(repository: repository);
    },
  );

  final model = Note(
    key: 'key',
    title: 'title',
    note: 'content',
    color: Colors.amber,
    reminder: null,
    reminderKey: null,
    tags: null,
    lastEdited: null,
    repeat: null,
    expired: false,
  );
  test(
    'should return Right<Note> when copy note is created',
    () {
      when(repository.copyNote(any, any, any, any, any)).thenReturn(Right(model));

      final result = useCase(CopyNoteParams(
          key: 'key', title: 'title', content: 'content', color: Colors.amber, box: WriteOn.home));

      verify(repository.copyNote('key', 'title', 'content', Colors.amber, WriteOn.home));
      verifyNoMoreInteractions(repository);
      expect(result, Right(model));
    },
  );
}

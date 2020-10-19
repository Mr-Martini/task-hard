import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/controllers/repeat-controller/repeat-controller.dart';
import 'package:task_hard/core/Utils/write_on.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/note/domain/repositories/note_repository.dart';
import 'package:task_hard/features/note/domain/usecases/write_note_content_usecase.dart';

class MockNoteRepository extends Mock implements NoteRepository {}

void main() {
  MockNoteRepository repository;
  WriteNoteContentUseCase useCase;

  setUp(
    () {
      repository = MockNoteRepository();
      useCase = WriteNoteContentUseCase(repository: repository);
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
    'should return [Right<Note>] when writeNoteContent is called',
    () {
      when(repository.writeNoteContent(any, any, any)).thenReturn(Right(model));

      final result = useCase(WriteContentParams(content: 'dd', key: 'key', box: WriteOn.home));

      verify(repository.writeNoteContent('dd', 'key', WriteOn.home));
      expect(result, Right(model));
    },
  );
}

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/controllers/repeat-controller/repeat-controller.dart';
import 'package:task_hard/features/note/data/model/note_model.dart';
import 'package:task_hard/features/note/domain/repositories/note_repository.dart';
import 'package:task_hard/features/note/domain/usecases/write_note_color_usecase.dart';

class MockRepository extends Mock implements NoteRepository {}

void main() {
  MockRepository repository;
  WriteNoteColorUseCase useCase;

  setUp(
    () {
      repository = MockRepository();
      useCase = WriteNoteColorUseCase(repository: repository);
    },
  );

  final now = DateTime.now();

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
  test(
    'should return Right<NoteModel> when writeNoteColor is caled',
    () {
      when(repository.writeNoteColor(any, any)).thenReturn(Right(model));

      final result =
          useCase(WriteNoteColorParams(color: Colors.pink, key: 'key'));

      verify(repository.writeNoteColor(any, any));

      expect(result, Right(model));
    },
  );
}

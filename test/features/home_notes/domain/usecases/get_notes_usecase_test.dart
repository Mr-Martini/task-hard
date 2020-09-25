import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/controllers/repeat-controller/repeat-controller.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:task_hard/features/home_notes/domain/entities/home_notes.dart';
import 'package:task_hard/features/home_notes/domain/repositories/home_notes_repository.dart';
import 'package:task_hard/features/home_notes/domain/usecases/get_notes_usecase.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

class MockNotesRepository extends Mock implements HomeNotesRepository {}

void main() {
  MockNotesRepository repository;
  GetNotesUseCase useCase;

  setUp(
    () {
      repository = MockNotesRepository();
      useCase = GetNotesUseCase(repository: repository);
    },
  );

  final model = HomeNotes(
    notes: [
      Note(
        color: Colors.blue,
        tags: [],
        note: 'note',
        title: 'title',
        key: 'key',
        reminderKey: 'key'.hashCode,
        reminder: DateTime(2030),
        lastEdited: DateTime.now(),
        repeat: Repeat.NO_REPEAT,
        expired: false,
      ),
    ],
  );
  test(
    'should return Right<HomeNotes> when getNotes is called',
    () {
      when(repository.getNotes()).thenReturn(Right(model));

      final result = useCase(NoParams());

      verify(repository.getNotes());
      expect(result, Right(model));
    },
  );
}

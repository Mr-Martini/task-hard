import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/features/delete_notes/domain/entities/deleted_notes.dart';
import 'package:task_hard/features/delete_notes/domain/repositories/deleted_notes_repository.dart';
import 'package:task_hard/features/delete_notes/domain/usecases/restore_notes_usecase.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

class MockDeletedNotesRepository extends Mock
    implements DeletedNotesRepository {}

void main() {
  MockDeletedNotesRepository repository;
  RestoreNotesUseCase useCase;

  setUp(
    () {
      repository = MockDeletedNotesRepository();
      useCase = RestoreNotesUseCase(repository: repository);
    },
  );

  final List<Note> notes = <Note>[];
  final DeletedNotes deletedNotes = DeletedNotes(notes: notes);
  test(
    'should return Right<DeletedNotes> when restoreNotes is successfully called',
    () {
      when(repository.restoreNotes(notes)).thenReturn(Right(deletedNotes));

      final result = useCase(RestoreNotesParams(notes: notes));

      verify(repository.restoreNotes(notes));
      verifyNoMoreInteractions(repository);
      expect(result, Right(deletedNotes));
    },
  );

  test(
    'should return Left<Failure> when restoreNote is unsuccessfully called',
    () {
      when(repository.restoreNotes(notes)).thenReturn(Left(CacheFailure()));

      final result = useCase(RestoreNotesParams(notes: notes));

      verify(repository.restoreNotes(notes));
      verifyNoMoreInteractions(repository);
      expect(result, Left(CacheFailure()));
    },
  );
}

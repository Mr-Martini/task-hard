import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/features/delete_notes/domain/entities/deleted_notes.dart';
import 'package:task_hard/features/delete_notes/domain/repositories/deleted_notes_repository.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

class MockDeletedNotesRepository extends Mock
    implements DeletedNotesRepository {}

void main() {
  MockDeletedNotesRepository repository;

  setUp(
    () {
      repository = MockDeletedNotesRepository();
    },
  );

  group(
    'repository_methods',
    () {
      final rightModel = DeletedNotes(notes: <Note>[]);
      final leftModel = CacheFailure();
      final notes = <Note>[];

      test(
        'Should return Right<DeletedNotes> when getNotes is successfully called',
        () {
          when(repository.getNotes()).thenReturn(Right(rightModel));

          final result = repository.getNotes();

          verify(repository.getNotes());
          verifyNoMoreInteractions(repository);
          expect(result, Right(rightModel));
        },
      );

      test(
        'Should return Right<DeletedNotes> when getNotes is successfully called',
        () {
          when(repository.getNotes()).thenReturn(Left(leftModel));

          final result = repository.getNotes();

          verify(repository.getNotes());
          verifyNoMoreInteractions(repository);
          expect(result, Left(leftModel));
        },
      );

      
      test(
        'should return Left<Failure> when restoreNotes is unsuccessfully called',
        () {
          when(repository.restoreNotes(notes)).thenReturn(Left(leftModel));

          final result = repository.restoreNotes(notes);

          verify(repository.restoreNotes(notes));
          verifyNoMoreInteractions(repository);
          expect(result, Left(leftModel));
        },
      );
    },
  );
}

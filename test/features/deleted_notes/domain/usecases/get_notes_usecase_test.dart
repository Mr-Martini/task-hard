import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:task_hard/features/delete_notes/domain/entities/deleted_notes.dart';
import 'package:task_hard/features/delete_notes/domain/repositories/deleted_notes_repository.dart';
import 'package:task_hard/features/delete_notes/domain/usecases/get_notes_usecase.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

class MockDeletedNotesRepository extends Mock
    implements DeletedNotesRepository {}

void main() {
  MockDeletedNotesRepository repository;
  GetDeletedNotesUseCase useCase;

  setUp(
    () {
      repository = MockDeletedNotesRepository();
      useCase = GetDeletedNotesUseCase(repository: repository);
    },
  );

  final rightModel = DeletedNotes(notes: <Note>[]);
  final leftModel = CacheFailure();
  test(
    'should return Right<DeletedNotes> when getNotes is successfully called',
    () {
      when(repository.getNotes()).thenReturn(Right(rightModel));

      final result = useCase(NoParams());

      verify(repository.getNotes());
      verifyNoMoreInteractions(repository);
      expect(result, Right(rightModel));
    },
  );

  test(
    'should return Left<Failure> when getNotes is unsuccessfully called',
    () {
      when(repository.getNotes()).thenReturn(Left(leftModel));

      final result = useCase(NoParams());

      verify(repository.getNotes());
      verifyNoMoreInteractions(repository);
      expect(result, Left(leftModel));
    },
  );
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/home_notes/domain/entities/home_notes.dart';
import 'package:task_hard/features/home_notes/domain/repositories/home_notes_repository.dart';
import 'package:task_hard/features/home_notes/domain/usecases/expire_checker_usecase.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

class MockHomeNoteRepository extends Mock implements HomeNotesRepository {}

void main() {
  MockHomeNoteRepository repository;
  ExpireCheckerUseCase useCase;

  setUp(
    () {
      repository = MockHomeNoteRepository();
      useCase = ExpireCheckerUseCase(repository: repository);
    },
  );

  final model = HomeNotes(
    notes: <Note>[],
  );

  final Iterable<dynamic> iterable = [{}];

  test(
    'should return Right<HomeNotes> when expireChecker is called',
    () {
      when(repository.expireChecker(any)).thenReturn(Right(model));

      final result = useCase(ExpireCheckerParams(notes: iterable));

      verify(repository.expireChecker(iterable));
      verifyNoMoreInteractions(repository);
      expect(result, Right(model));
    },
  );
}

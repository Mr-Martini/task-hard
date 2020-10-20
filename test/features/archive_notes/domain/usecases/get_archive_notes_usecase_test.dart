import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:task_hard/features/archive_notes/domain/entities/archive_notes.dart';
import 'package:task_hard/features/archive_notes/domain/repositories/archive_notes_repository.dart';
import 'package:task_hard/features/archive_notes/domain/usecases/get_archive_notes_usecase.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

class MockArchiveRepository extends Mock implements ArchiveNotesRepository {}

void main() {
  MockArchiveRepository repository;
  GetArchiveNotesUseCase useCase;

  setUp(
    () {
      repository = MockArchiveRepository();
      useCase = GetArchiveNotesUseCase(repository: repository);
    },
  );

  final model = ArchivedNotes(notes: <Note>[]);

  test(
    'should return Right<ArchivedNotes> when useCase is called',
    () {
      when(repository.getArchiveNotes()).thenReturn(Right(model));

      final result = useCase(NoParams());

      expect(result, Right(model));
      verify(repository.getArchiveNotes());
      verifyNoMoreInteractions(repository);
    },
  );
}

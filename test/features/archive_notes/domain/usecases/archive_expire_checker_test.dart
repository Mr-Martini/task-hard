import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/archive_notes/domain/entities/archive_notes.dart';
import 'package:task_hard/features/archive_notes/domain/repositories/archive_notes_repository.dart';
import 'package:task_hard/features/archive_notes/domain/usecases/archive_expire_checker.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

class MockArchiveRepository extends Mock implements ArchiveNotesRepository {}

void main() {
  MockArchiveRepository repository;
  ExpireCheckerArchiveUseCase useCase;

  setUp(
    () {
      repository = MockArchiveRepository();
      useCase = ExpireCheckerArchiveUseCase(repository: repository);
    },
  );

  final ArchivedNotes notes = ArchivedNotes(notes: <Note>[]);

  final Iterable<dynamic> iterable = [{}];
  test(
    'should return Right<ArchivedNotes> when useCase is called',
    () {
      when(repository.expireCheckerArchive(any)).thenReturn(Right(notes));

      final result = useCase(ExpireCheckerArchiveParams(notes: iterable));

      verify(repository.expireCheckerArchive(iterable));
      verifyNoMoreInteractions(repository);
      expect(result, Right(notes));
    },
  );
}

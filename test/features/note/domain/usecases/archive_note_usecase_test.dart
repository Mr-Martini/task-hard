import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/core/Utils/write_on.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/note/domain/repositories/note_repository.dart';
import 'package:task_hard/features/note/domain/usecases/archive_note_usecase.dart';

class MockNoteRepositoy extends Mock implements NoteRepository {}

void main() {
  MockNoteRepositoy repository;
  ArchiveNoteUseCase useCase;

  setUp(
    () {
      repository = MockNoteRepositoy();
      useCase = ArchiveNoteUseCase(repository: repository);
    },
  );

  final model = Note(
    key: 'key',
    title: null,
    note: null,
    color: null,
    reminder: null,
    reminderKey: null,
    tags: null,
    lastEdited: null,
    repeat: null,
    expired: false,
  );
  test(
    'should return Right<Note> when archive note is called',
    () {
      when(repository.archiveNote(any, any)).thenReturn(Right(model));

      final result = useCase(ArchiveNoteParams(key: 'key', box: WriteOn.home));

      verify(repository.archiveNote('key', WriteOn.home));
      verifyNoMoreInteractions(repository);
      expect(result, Right(model));
    },
  );
}

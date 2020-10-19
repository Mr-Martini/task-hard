import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/core/Utils/write_on.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/note/domain/repositories/note_repository.dart';
import 'package:task_hard/features/note/domain/usecases/delete_note.dart';

class MockNoteRepository extends Mock implements NoteRepository {}

void main() {
  MockNoteRepository repository;
  DeleteNoteUseCase useCase;

  setUp(
    () {
      repository = MockNoteRepository();
      useCase = DeleteNoteUseCase(repository: repository);
    },
  );

  test(
    'should return Right<Note> when delete note is called',
    () {
      final model = Note(
        key: null,
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

      when(repository.deleteNote(any, any)).thenReturn(Right(model));

      final result = useCase(DeleteNoteParams(key: 'key', box: WriteOn.home));

      verify(repository.deleteNote('key', WriteOn.home));
      verifyNoMoreInteractions(repository);
      expect(result, Right(model));
    },
  );
}

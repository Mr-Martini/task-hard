import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/controllers/repeat-controller/repeat-controller.dart';
import 'package:task_hard/features/home_notes/data/model/home_notes_model.dart';
import 'package:task_hard/features/home_notes/domain/repositories/home_notes_repository.dart';
import 'package:task_hard/features/home_notes/domain/usecases/listen_notes_usecase.dart';
import 'package:task_hard/features/note/data/model/note_model.dart';

class MockRepository extends Mock implements HomeNotesRepository {}

void main() {
  MockRepository repository;
  ListenNotesUseCase useCase;

  setUp(
    () {
      repository = MockRepository();
      useCase = ListenNotesUseCase(repository: repository);
    },
  );

  final now = DateTime.now();

  Iterable notes = [
    {
      "title": "title",
      "note": "note",
      "color": null,
      "reminder": now,
      "reminderKey": "key".hashCode,
      "key": "key",
      "lastEdited": now,
      "tags": [],
      "repeat": Repeat.NO_REPEAT,
      "expired": false,
    },
  ];

  final model = HomeNotesModel(
    notes: [
      NoteModel(
        key: 'key',
        title: 'title',
        note: 'note',
        color: null,
        reminder: now,
        reminderKey: 'key'.hashCode,
        tags: [],
        lastEdited: now,
        repeat: Repeat.NO_REPEAT,
        expired: false,
      ),
    ],
  );
  test(
    'should return Right<HomeNotes> when listen is called',
    () {
      when(repository.listen(any)).thenReturn(Right(model));

      final result = useCase(ListenNotesParams(notes: notes));

      verify(repository.listen(notes));

      expect(result, Right(model));
    },
  );
}

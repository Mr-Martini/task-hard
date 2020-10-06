import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/controllers/repeat-controller/repeat-controller.dart';
import 'package:task_hard/features/note_reminder/domain/entity/note_reminder.dart';
import 'package:task_hard/features/note_reminder/domain/repositories/note_reminder_repository.dart';
import 'package:task_hard/features/note_reminder/domain/usecases/get_reminder_usecase.dart';

class MockNoteReminderRepository extends Mock
    implements NoteReminderRepository {}

void main() {
  MockNoteReminderRepository repository;
  GetNoteReminderUseCase useCase;

  setUp(
    () {
      repository = MockNoteReminderRepository();
      useCase = GetNoteReminderUseCase(repository: repository);
    },
  );

  final model = NoteReminder(
    reminder: DateTime.now(),
    expired: false,
    repeat: Repeat.NO_REPEAT,
  );
  test(
    'should return Right<NoteReminder> when getReminder is called',
    () {
      when(repository.getReminder(any)).thenReturn(Right(model));

      final result = useCase(GetNoteReminderParams(noteKey: 'noteKey'));

      verify(repository.getReminder('noteKey'));
      verifyNoMoreInteractions(repository);
      expect(result, Right(model));
    },
  );
}

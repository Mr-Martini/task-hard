import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/home_app_bar/domain/entities/home_app_bar_entity.dart';
import 'package:task_hard/features/home_app_bar/domain/repositories/home_app_bar_repository.dart';
import 'package:task_hard/features/home_app_bar/domain/usecases/delete_reminder_usecase.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

class MockAppBarRepository extends Mock implements HomeAppBarRepository {}

void main() {
  MockAppBarRepository repository;
  DeleteAppBarNoteReminderUseCase useCase;

  setUp(
    () {
      repository = MockAppBarRepository();
      useCase = DeleteAppBarNoteReminderUseCase(repository: repository);
    },
  );

  final model = HomeAppBarEntity(selectedNotes: <Note>[]);
  test(
    'should return Right<HomeAppBarEntity>',
    () {
      when(repository.deleteReminder(any)).thenReturn(Right(model));

      final result = useCase(
        DeleteAppBarNoteReminderParams(
          selectedNotes: <Note>[],
        ),
      );

      verify(repository.deleteReminder(<Note>[]));
      verifyNoMoreInteractions(repository);
      expect(result, Right(model));
    },
  );
}

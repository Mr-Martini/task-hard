import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/controllers/repeat-controller/repeat-controller.dart';
import 'package:task_hard/features/home_app_bar/domain/entities/home_app_bar_entity.dart';
import 'package:task_hard/features/home_app_bar/domain/repositories/home_app_bar_repository.dart';
import 'package:task_hard/features/home_app_bar/domain/usecases/put_reminder_usecase.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

class MockAppBarRepository extends Mock implements HomeAppBarRepository {}

void main() {
  MockAppBarRepository repository;
  PutReminderAppBarUseCase useCase;

  setUp(
    () {
      repository = MockAppBarRepository();
      useCase = PutReminderAppBarUseCase(repository: repository);
    },
  );

  final scheduledDate = DateTime.now();
  final repeat = Repeat.NO_REPEAT;
  final model = HomeAppBarEntity(selectedNotes: <Note>[]);
  test(
    'should return Right<HomeAppBarEntity> when PutReminderAppBarUseCase is called',
    () {
      when(repository.putReminder(any, any, any)).thenReturn(Right(model));

      final result = useCase(
        PutReminderAppBarParams(
          selectedNotes: <Note>[],
          scheduledDate: scheduledDate,
          repeat: repeat,
        ),
      );

      verify(repository.putReminder(<Note>[], scheduledDate, repeat));
      verifyNoMoreInteractions(repository);
      expect(result, Right(model));
    },
  );
}

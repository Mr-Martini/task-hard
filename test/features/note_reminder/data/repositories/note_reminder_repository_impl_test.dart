import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/controllers/repeat-controller/repeat-controller.dart';
import 'package:task_hard/core/Utils/write_on.dart';
import 'package:task_hard/features/note_reminder/data/datasources/note_reminder_local_data_source.dart';
import 'package:task_hard/features/note_reminder/data/model/note_reminder_model.dart';
import 'package:task_hard/features/note_reminder/data/repositories/note_reminder_repository_impl.dart';

class MockLocalDataSource extends Mock implements NoteReminderLocalDataSource {}

void main() {
  MockLocalDataSource dataSource;
  NoteReminderRepositoryImpl impl;

  setUp(
    () {
      dataSource = MockLocalDataSource();
      impl = NoteReminderRepositoryImpl(dataSource: dataSource);
    },
  );

  final model = NoteReminderModel(
    reminder: DateTime.now(),
    repeat: Repeat.NO_REPEAT,
    expired: false,
  );

  test(
    'should return Right<NoteReminder> when getReminder is called',
    () {
      when(dataSource.getReminder(any, WriteOn.home)).thenReturn(model);

      final result = impl.getReminder('noteKey', WriteOn.home);

      verify(dataSource.getReminder('noteKey', WriteOn.home));
      verifyNoMoreInteractions(dataSource);
      expect(result, Right(model));
    },
  );
}

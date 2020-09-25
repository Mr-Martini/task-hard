import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/core/error/exceptions.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/features/taged_notes_home/data/datasources/taged_notes_home_local_data_source.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:task_hard/features/taged_notes_home/data/model/taged_notes_home_model.dart';
import 'package:task_hard/features/taged_notes_home/data/repositories/taged_notes_home_repository_impl.dart';

class MockLocalDataSource extends Mock
    implements TagedNotesHomeLocalDataSource {}

void main() {
  TagedNotesHomeRepositoryImpl sourceImpl;
  MockLocalDataSource mockLocalDataSource;

  setUp(
    () {
      mockLocalDataSource = MockLocalDataSource();
      sourceImpl = TagedNotesHomeRepositoryImpl(mockLocalDataSource);
    },
  );

  group(
    'getPreference',
    () {
      final model = TagedNotesHomeModel(true);
      test(
        'should return [TagedNotesHome] when the calls is successusful',
        () {
          when(mockLocalDataSource.getPreference()).thenReturn(model);

          final result = sourceImpl.getPreference();

          verify(mockLocalDataSource.getPreference());
          verifyNoMoreInteractions(mockLocalDataSource);
          expect(result, Right(model));
        },
      );

      test(
        'should return [CacheFailure] when there\'s no cached data',
        () {
          when(mockLocalDataSource.getPreference()).thenThrow(CacheException());

          final result = sourceImpl.getPreference();

          verify(mockLocalDataSource.getPreference());
          verifyNoMoreInteractions(mockLocalDataSource);
          expect(result, Left(CacheFailure()));
        },
      );
    },
  );
}

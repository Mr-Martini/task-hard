import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/core/error/exceptions.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/features/delete_notes/data/datasources/deleted_notes_local_data_source.dart';
import 'package:task_hard/features/delete_notes/data/repositories/deleted_notes_repository_impl.dart';

class MockLocalDataSource extends Mock implements DeletedNotesLocalDataSource {}

void main() {
  MockLocalDataSource dataSource;
  DeletedNotesRepositoryImpl impl;

  setUp(
    () {
      dataSource = MockLocalDataSource();
      impl = DeletedNotesRepositoryImpl(dataSource: dataSource);
    },
  );

  test(
    'should return Left<Failure> when a error is catched',
    () {
      when(dataSource.getNotes()).thenThrow(CacheException());

      final result = impl.getNotes();

      verify(dataSource.getNotes());
      verifyNoMoreInteractions(dataSource);
      expect(result, Left(CacheFailure()));
    },
  );
}

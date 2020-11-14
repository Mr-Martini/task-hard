import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/core/error/exceptions.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/features/delete_notes/data/datasources/deleted_notes_local_data_source.dart';
import 'package:task_hard/features/delete_notes/data/model/deleted_notes_model.dart';
import 'package:task_hard/features/delete_notes/data/repositories/deleted_notes_repository_impl.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

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
  final notes = <Note>[];
  final expected = DeletedNotesModel(notes: notes);

  group(
    'success',
    () {
      test(
        'should return Right<DeletedNotes> getNotes is successfully called',
        () {
          when(dataSource.getNotes()).thenReturn(expected);

          final result = impl.getNotes();

          verify(dataSource.getNotes());
          verifyNoMoreInteractions(dataSource);
          expect(result, Right(expected));
        },
      );

      test(
        'should return Right<DeletedNotes> restoreNotes is successfully called',
        () {
          when(dataSource.restoreNotes(notes)).thenReturn(expected);

          final result = impl.restoreNotes(notes);

          verify(dataSource.restoreNotes(notes));
          verifyNoMoreInteractions(dataSource);
          expect(result, Right(expected));
        },
      );
    },
  );

  group(
    'failures',
    () {
      test(
        'should return Left<Failure> when a error is catched from getNotes',
        () {
          when(dataSource.getNotes()).thenThrow(CacheException());

          final result = impl.getNotes();

          verify(dataSource.getNotes());
          verifyNoMoreInteractions(dataSource);
          expect(result, Left(CacheFailure()));
        },
      );

      test(
        'should return Left<Failure> when a error is catched from restoreNotes',
        () {
          when(dataSource.restoreNotes(notes)).thenThrow(CacheException());

          final result = impl.restoreNotes(notes);

          verify(dataSource.restoreNotes(notes));
          verifyNoMoreInteractions(dataSource);
          expect(result, Left(CacheFailure()));
        },
      );
    },
  );
}

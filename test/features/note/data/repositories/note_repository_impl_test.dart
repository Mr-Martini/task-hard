import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/controllers/repeat-controller/repeat-controller.dart';
import 'package:task_hard/core/Utils/write_on.dart';
import 'package:task_hard/features/note/data/datasources/note_local_data_source.dart';
import 'package:task_hard/features/note/data/model/note_model.dart';
import 'package:task_hard/features/note/data/repositories/note_repository_impl.dart';

class MockNoteDataSource extends Mock implements NoteLocalDataSource {}

void main() {
  MockNoteDataSource dataSource;
  NoteRepositoryImpl impl;

  setUp(
    () {
      dataSource = MockNoteDataSource();
      impl = NoteRepositoryImpl(dataSource: dataSource);
    },
  );

  group(
    'writeOperations',
    () {
      final reminder = DateTime(2030);
      final key = 'key';
      final now = TimeOfDay.now();

      final note = NoteModel(
        key: key,
        title: null,
        note: null,
        color: null,
        reminder: reminder,
        reminderKey: key.hashCode,
        tags: null,
        lastEdited: null,
        repeat: Repeat.NO_REPEAT,
        expired: false,
      );
      test(
        'should return Right<Note> when WriteNoteReminder is called',
        () {
          when(dataSource.writeNoteReminder(any, any, any, any, any, any, any))
              .thenReturn(note);

          final result = impl.writeNoteReminder(
              reminder, now, Repeat.NO_REPEAT, key, null, null, WriteOn.home);

          verify(dataSource.writeNoteReminder(
              reminder, now, Repeat.NO_REPEAT, key, null, null, WriteOn.home));
          verifyNoMoreInteractions(dataSource);
          expect(result, Right(note));
        },
      );

      test(
        'should return Right<Note> when ArchiveNoteUseCase is called',
        () {
          when(dataSource.archiveNote(any, any)).thenReturn(note);

          final result = impl.archiveNote('key', WriteOn.home);

          verify(dataSource.archiveNote('key', WriteOn.home));
          verifyNoMoreInteractions(dataSource);
          expect(result, Right(note));
        },
      );

      test(
        'should return Right<Note> when CopyNoteUseCase is created',
        () {
          when(dataSource.copyNote(any, any, any, any, any)).thenReturn(note);

          final result = impl.copyNote(key, 'title', 'content', Colors.amber, WriteOn.home);

          verify(dataSource.copyNote(key, 'title', 'content', Colors.amber, WriteOn.home));
          verifyNoMoreInteractions(dataSource);
          expect(result, Right(note));
        },
      );
    },
  );
}

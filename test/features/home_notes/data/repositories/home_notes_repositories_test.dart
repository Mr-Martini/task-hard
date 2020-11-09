import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/home_notes/data/datasources/home_notes.datasource.dart';
import 'package:task_hard/features/home_notes/data/model/home_notes_model.dart';
import 'package:task_hard/features/home_notes/data/repositories/home_notes_repository_impl.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

class MockHomeNotesDataSource extends Mock implements HomeNotesDataSource {}

void main() {
  MockHomeNotesDataSource dataSource;
  // ignore: unused_local_variable
  HomeNotesRepositoryImpl impl;

  setUp(
    () {
      dataSource = MockHomeNotesDataSource();
      impl = HomeNotesRepositoryImpl(dataSource: dataSource);
    },
  );

  final model = HomeNotesModel(
    notes: <Note>[],
  );

  final Iterable<dynamic> notes = [{}];
  test(
    'should return Right<HomeNotes> when impl.expireChecker is called',
    () {
      when(dataSource.expireChecker(any)).thenReturn(model);

      final result = dataSource.expireChecker(notes);

      verify(dataSource.expireChecker(notes));
      verifyNoMoreInteractions(dataSource);
      expect(result, model);
    },
  );
}

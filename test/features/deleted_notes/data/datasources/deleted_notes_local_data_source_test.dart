import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/delete_notes/data/datasources/deleted_notes_local_data_source.dart';
import 'package:task_hard/features/delete_notes/data/model/deleted_notes_model.dart';

class MockBox extends Mock implements Box<dynamic> {}

void main() {
  MockBox box;
  DeletedNotesLocalDataSourceImpl impl;

  setUp(
    () {
      box = MockBox();
      impl = DeletedNotesLocalDataSourceImpl(
        deleteBox: box,
        archiveBox: null,
        homeBox: null,
      );
    },
  );

  final Iterable<dynamic> expected = [];

  test(
    'should return DeletedNotes when getNotes is called',
    () {
      when(box.values).thenReturn(expected);

      final result = impl.getNotes();

      verify(box.values);
      verifyNoMoreInteractions(box);
      expect(result, isA<DeletedNotesModel>());
    },
  );
}

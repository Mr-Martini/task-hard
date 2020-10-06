import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/note_tags/data/datasources/note_tags_local_data_source.dart';
import 'package:task_hard/features/note_tags/data/model/note_tags_model.dart';
import 'package:task_hard/features/note_tags/data/repositories/note_tags_repository_impl.dart';

class MockLocalDataSource extends Mock implements NoteTagsLocalDataSource {}

void main() {
  MockLocalDataSource dataSource;
  NoteTagsRepositoryImpl impl;

  setUp(
    () {
      dataSource = MockLocalDataSource();
      impl = NoteTagsRepositoryImpl(dataSource: dataSource);
    },
  );

  final model = NoteTagsModel(tags: <String>[]);

  test(
    'should return Right<NoteTagsEntity> when getNoteTags is called',
    () {
      when(dataSource.getNoteTags(any)).thenReturn(model);

      final result = impl.getTags('noteKey');

      verify(dataSource.getNoteTags('noteKey'));
      verifyNoMoreInteractions(dataSource);
      expect(result, Right(model));
    },
  );
}

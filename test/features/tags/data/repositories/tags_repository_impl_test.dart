import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/tags/data/datasources/tags_local_data_source.dart';
import 'package:task_hard/features/tags/data/model/tags_model.dart';
import 'package:task_hard/features/tags/data/repositories/tags_repository_impl.dart';

class MockLocalDataSource extends Mock implements TagsLocalDataSouce {}

void main() {
  MockLocalDataSource dataSource;
  TagsRepositoryImpl impl;

  setUp(
    () {
      dataSource = MockLocalDataSource();
      impl = TagsRepositoryImpl(dataSource: dataSource);
    },
  );

  final model =
      TagsModel(tags: <String>[], noteTags: <String>[], noteList: <Note>[]);

  test(
    'should return Right<TagsModel> when getTags is called',
    () {
      when(dataSource.getTags('key')).thenReturn(model);

      final result = impl.getTags('key');

      verify(dataSource.getTags('key'));
      verifyNoMoreInteractions(dataSource);
      expect(result, Right(model));
    },
  );

  final modelForAddTagOnNote = TagsModel(
      tags: <String>['car'], noteTags: <String>['car'], noteList: <Note>[]);

  test(
    'should return Right<TagsModel> with the correct data when addTagOnNote is called',
    () {
      when(dataSource.addTagOnNote(any, any)).thenReturn(modelForAddTagOnNote);

      final result = impl.addTagOnNote('noteKey', 'car');

      verify(dataSource.addTagOnNote('noteKey', 'car'));
      verifyNoMoreInteractions(dataSource);
      expect(result, Right(modelForAddTagOnNote));
    },
  );

  final modelForRemove = TagsModel(
      tags: <String>['car', 'plane'],
      noteTags: <String>['car', 'plane'],
      noteList: <Note>[]);
  test(
    'should return Right<TagsModel> with the correct data when removeTagFromNote is called',
    () {
      when(dataSource.removeTagFronNote(any, any)).thenReturn(modelForRemove);

      final result = impl.removeTagFromNote('noteKey', 'plane');

      verify(dataSource.removeTagFronNote('noteKey', 'plane'));
      verifyNoMoreInteractions(dataSource);
      expect(result, Right(modelForRemove));
    },
  );

  final modelForAddTagList =
      TagsModel(tags: <String>[], noteTags: <String>[], noteList: <Note>[]);
  test(
    'should return Right<TagsModel> with the correct data when addTagOnList is called',
    () {
      when(dataSource.addTagOnList(any, any)).thenReturn(modelForAddTagList);

      final result = impl.addTagOnList(<Note>[], 'tagName');

      verify(dataSource.addTagOnList(<Note>[], 'tagName'));
      verifyNoMoreInteractions(dataSource);
      expect(result, Right(modelForAddTagList));
    },
  );
}

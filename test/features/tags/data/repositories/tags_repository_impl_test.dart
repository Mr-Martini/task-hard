import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/core/Utils/write_on.dart';
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
      when(dataSource.getTags('key', WriteOn.home)).thenReturn(model);

      final result = impl.getTags('key', WriteOn.home);

      verify(dataSource.getTags('key', WriteOn.home));
      verifyNoMoreInteractions(dataSource);
      expect(result, Right(model));
    },
  );

  final modelForAddTagOnNote = TagsModel(
      tags: <String>['car'], noteTags: <String>['car'], noteList: <Note>[]);

  test(
    'should return Right<TagsModel> with the correct data when addTagOnNote is called',
    () {
      when(dataSource.addTagOnNote(any, any, WriteOn.home)).thenReturn(modelForAddTagOnNote);

      final result = impl.addTagOnNote('noteKey', 'car', WriteOn.home);

      verify(dataSource.addTagOnNote('noteKey', 'car', WriteOn.home));
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
      when(dataSource.removeTagFromNote(any, any, WriteOn.home)).thenReturn(modelForRemove);

      final result = impl.removeTagFromNote('noteKey', 'plane', WriteOn.home);

      verify(dataSource.removeTagFromNote('noteKey', 'plane', WriteOn.home));
      verifyNoMoreInteractions(dataSource);
      expect(result, Right(modelForRemove));
    },
  );

  final modelForAddTagList =
      TagsModel(tags: <String>[], noteTags: <String>[], noteList: <Note>[]);
  test(
    'should return Right<TagsModel> with the correct data when addTagOnList is called',
    () {
      when(dataSource.addTagOnList(any, any, WriteOn.home)).thenReturn(modelForAddTagList);

      final result = impl.addTagOnList(<Note>[], 'tagName', WriteOn.home);

      verify(dataSource.addTagOnList(<Note>[], 'tagName', WriteOn.home));
      verifyNoMoreInteractions(dataSource);
      expect(result, Right(modelForAddTagList));
    },
  );

  final modelForRemoveTagFromList =
      TagsModel(tags: <String>[], noteTags: <String>[], noteList: <Note>[]);

  test(
    'should return Right<TagsModel> with the correct data when removeTagFromList is called',
    () {
      when(dataSource.removeTagFromList(any, any, WriteOn.home))
          .thenReturn(modelForRemoveTagFromList);

      final result = impl.removeTagFromList(<Note>[], 'tagName', WriteOn.home);

      verify(dataSource.removeTagFromList(<Note>[], 'tagName', WriteOn.home));
      verifyNoMoreInteractions(dataSource);
      expect(result, Right(modelForRemoveTagFromList));
    },
  );
}

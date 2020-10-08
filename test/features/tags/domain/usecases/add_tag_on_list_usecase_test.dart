import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/tags/domain/entities/tags.dart';
import 'package:task_hard/features/tags/domain/repositories/tags_repository.dart';
import 'package:task_hard/features/tags/domain/usecases/add_tag_on_list.dart';

class MockRepository extends Mock implements TagsRepository {}

void main() {
  MockRepository repository;
  AddTagOnListUseCase useCase;

  setUp(
    () {
      repository = MockRepository();
      useCase = AddTagOnListUseCase(repository: repository);
    },
  );

  final model =
      TagsEntity(tags: <String>[], noteTags: <String>[], noteList: <Note>[]);
  final String tagName = 'car';
  final notes = <Note>[];
  test(
    'should return Right<TagsEntity> when useCase is called',
    () {
      when(repository.addTagOnList(any, any)).thenReturn(Right(model));

      final result =
          useCase(AddTagOnListParams(notes: notes, tagName: tagName));

      verify(repository.addTagOnList(notes, tagName));
      verifyNoMoreInteractions(repository);
      expect(result, Right(model));
    },
  );
}

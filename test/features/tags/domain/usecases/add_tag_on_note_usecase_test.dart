import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/core/Utils/write_on.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/tags/domain/entities/tags.dart';
import 'package:task_hard/features/tags/domain/repositories/tags_repository.dart';
import 'package:task_hard/features/tags/domain/usecases/add_tag_on_note.dart';

class MockTagsRepository extends Mock implements TagsRepository {}

void main() {
  MockTagsRepository repository;
  AddTagOnNoteUseCase useCase;

  setUp(
    () {
      repository = MockTagsRepository();
      useCase = AddTagOnNoteUseCase(repository: repository);
    },
  );

  final model =
      TagsEntity(tags: <String>[], noteTags: <String>[], noteList: <Note>[]);

  test(
    'should return Right<TagsEntity> when AddTagOnNoteUseCase is called',
    () {
      when(repository.addTagOnNote(any, any, WriteOn.home)).thenReturn(Right(model));

      final result =
          useCase(AddTagOnNoteParams(tagName: 'null', noteKey: 'null', box: WriteOn.home));

      verify(repository.addTagOnNote('null', 'null', WriteOn.home));
      verifyNoMoreInteractions(repository);
      expect(result, Right(model));
    },
  );
}

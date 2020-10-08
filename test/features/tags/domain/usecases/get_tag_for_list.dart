import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/tags/domain/entities/tags.dart';
import 'package:task_hard/features/tags/domain/repositories/tags_repository.dart';
import 'package:task_hard/features/tags/domain/usecases/get_tag_for_list_usecase.dart';

class MockRepository extends Mock implements TagsRepository {}

void main() {
  MockRepository repository;
  GetTagForListUseCase useCase;

  setUp(
    () {
      repository = MockRepository();
      useCase = GetTagForListUseCase(repository: repository);
    },
  );

  final model =
      TagsEntity(tags: <String>[], noteTags: <String>[], noteList: <Note>[]);

  test(
    'should return Right<TagsEntity> when useCase is called',
    () {
      when(repository.getTagsForList(any)).thenReturn(Right(model));

      final result = useCase(GetTagForListParams(notes: <Note>[]));

      verify(repository.getTagsForList(<Note>[]));
      verifyNoMoreInteractions(repository);
      expect(result, Right(model));
    },
  );
}

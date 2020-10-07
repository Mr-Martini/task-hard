import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:task_hard/features/tags/domain/entities/tags.dart';
import 'package:task_hard/features/tags/domain/repositories/tags_repository.dart';
import 'package:task_hard/features/tags/domain/usecases/get_tags_usecase.dart';

class MockTagsRepository extends Mock implements TagsRepository {}

void main() {
  MockTagsRepository repository;
  GetTagsUseCase useCase;

  setUp(
    () {
      repository = MockTagsRepository();
      useCase = GetTagsUseCase(repository: repository);
    },
  );

  final model = TagsEntity(tags: <String>[], noteTags: <String>[]);
  test(
    'should return Right<TagsEntity> when GetTagsUseCase is called',
    () {
      when(repository.getTags('key')).thenReturn(Right(model));

      final result = useCase(GetTagsParams(noteKey: 'key'));

      verify(repository.getTags('key'));
      verifyNoMoreInteractions(repository);
      expect(result, Right(model));
    },
  );
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:task_hard/features/tags/domain/entities/tags.dart';
import 'package:task_hard/features/tags/domain/repositories/tags_repository.dart';
import 'package:task_hard/features/tags/domain/usecases/get_only_tags_usecase.dart';

class MockTagsRepository extends Mock implements TagsRepository {}

void main() {
  MockTagsRepository repository;
  GetOnlyTagsUseCases useCases;

  setUp(
    () {
      repository = MockTagsRepository();
      useCases = GetOnlyTagsUseCases(repository: repository);
    },
  );

  final model = TagsEntity(tags: <String>[], noteTags: <String>[]);
  test(
    'should return Right<TagsEntity> when useCases is called',
    () {
      when(repository.getOnlyTags()).thenReturn(Right(model));

      final result = useCases(NoParams());

      verify(repository.getOnlyTags());
      verifyNoMoreInteractions(repository);
      expect(result, Right(model));
    },
  );
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/tags/domain/entities/tags.dart';
import 'package:task_hard/features/tags/domain/repositories/tags_repository.dart';
import 'package:task_hard/features/tags/domain/usecases/remove_tag_from_list_usecase.dart';

class MockRepository extends Mock implements TagsRepository {}

void main() {
  MockRepository repository;
  RemoveTagFromListUseCase useCase;

  final model =
      TagsEntity(tags: <String>[], noteTags: <String>[], noteList: <Note>[]);

  setUp(
    () {
      when(repository.removeTagFromList(any, any)).thenReturn(Right(model));

      final result = useCase(
        RemoveTagFromListParams(
          notes: <Note>[],
          tagName: 'tagName',
        ),
      );

      verify(repository.removeTagFromList(<Note>[], 'tagName'));
      verifyNoMoreInteractions(repository);
      expect(result, Right(model));
    },
  );
}

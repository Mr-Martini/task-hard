import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/tags/domain/entities/tags.dart';
import 'package:task_hard/features/tags/domain/repositories/tags_repository.dart';
import 'package:task_hard/features/tags/domain/usecases/remove_tag_from_note_usecase.dart';

class MockTagRepository extends Mock implements TagsRepository {}

void main() {
  MockTagRepository repository;
  RemoveTagFromNoteUseCase useCase;

  setUp(
    () {
      repository = MockTagRepository();
      useCase = RemoveTagFromNoteUseCase(repository: repository);
    },
  );

  final model = TagsEntity(
      tags: ['plane'], noteTags: <String>['car', 'plane'], noteList: <Note>[]);

  test(
    'should return Right<TagsEntity> when useCase is called',
    () {
      when(repository.removeTagFromNote(any, any)).thenReturn(Right(model));

      final result =
          useCase(RemoveTagFromNoteParams(noteKey: 'null', tagName: 'plane'));

      verify(repository.removeTagFromNote('null', 'plane'));
      verifyNoMoreInteractions(repository);
      expect(result, Right(model));
    },
  );
}

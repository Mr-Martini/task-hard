import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/core/Utils/write_on.dart';
import 'package:task_hard/features/note_tags/domain/entities/note_tags.dart';
import 'package:task_hard/features/note_tags/domain/repositories/note_tags_repository.dart';
import 'package:task_hard/features/note_tags/domain/usecases/get_tags_usecase.dart';

class MockNoteTagsRepository extends Mock implements NoteTagsRepository {}

void main() {
  MockNoteTagsRepository repository;
  GetNoteTagsUseCase useCase;

  setUp(
    () {
      repository = MockNoteTagsRepository();
      useCase = GetNoteTagsUseCase(repository: repository);
    },
  );

  final model = NoteTagsEntity(tags: <String>[]);

  test(
    'should return Right<NoteTagsEntity> when GetNoteTagsUseCase is called',
    () {
      when(repository.getTags(any, WriteOn.home)).thenReturn(Right(model));

      final result = useCase(GetNoteTagsParams(noteKey: 'null', box: WriteOn.home));

      verify(repository.getTags('null', WriteOn.home));
      verifyNoMoreInteractions(repository);
      expect(result, Right(model));
    },
  );
}

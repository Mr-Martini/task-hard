import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/home_app_bar/data/model/home_app_bar_model.dart';
import 'package:task_hard/features/home_app_bar/domain/entities/home_app_bar_entity.dart';
import 'package:task_hard/features/home_app_bar/domain/repositories/home_app_bar_repository.dart';
import 'package:task_hard/features/home_app_bar/domain/usecases/archive_note_usecase.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

class MockHomeAppBarRepository extends Mock implements HomeAppBarRepository {}

void main() {
  MockHomeAppBarRepository repository;
  ArchiveNoteAppBarUseCase useCase;

  setUp(
    () {
      repository = MockHomeAppBarRepository();
      useCase = ArchiveNoteAppBarUseCase(repository: repository);
    },
  );

  final model = HomeAppBarEntity(selectedNotes: <Note>[]);
  test(
    'should return Right<HomeAppBarEntity> when ArchiveNoteAppBarUseCase is called',
    () {
      when(repository.archiveNotes(any)).thenReturn(Right(model));

      final result = useCase(ArchiveNoteAppBarParams(selectedNotes: <Note>[]));

      verify(repository.archiveNotes(<Note>[]));
      verifyNoMoreInteractions(repository);
      expect(result, Right(model));
    },
  );
}

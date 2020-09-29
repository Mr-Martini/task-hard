import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/home_app_bar/domain/entities/home_app_bar_entity.dart';
import 'package:task_hard/features/home_app_bar/domain/repositories/home_app_bar_repository.dart';
import 'package:task_hard/features/home_app_bar/domain/usecases/undo_archive_usecase.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

class MockHomeAppBarRepository extends Mock implements HomeAppBarRepository {}

void main() {
  MockHomeAppBarRepository repository;
  UndoArchiveAppBarUseCase useCase;

  final model = HomeAppBarEntity(selectedNotes: <Note>[]);

  setUp(
    () {
      repository = MockHomeAppBarRepository();
      useCase = UndoArchiveAppBarUseCase(repository: repository);
    },
  );

  test(
    'should return Right<HomeAppBarEntity> when UndoArchiveAppBarUseCase is called',
    () {
      when(repository.undoArchive(any)).thenReturn(Right(model));

      final result = useCase(UndoArchiveAppBarParams(selectedNotes: <Note>[]));

      verify(repository.undoArchive(<Note>[]));
      verifyNoMoreInteractions(repository);
      expect(result, Right(model));
    },
  );
}

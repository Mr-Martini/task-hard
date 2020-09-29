import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/home_app_bar/data/model/home_app_bar_model.dart';
import 'package:task_hard/features/home_app_bar/domain/repositories/home_app_bar_repository.dart';
import 'package:task_hard/features/home_app_bar/domain/usecases/undo_delete_usecase.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

class MockAppBarRepository extends Mock implements HomeAppBarRepository {}

void main() {
  MockAppBarRepository repository;
  UndoDeleteNotesAppBarUseCase useCase;

  setUp(
    () {
      repository = MockAppBarRepository();
      useCase = UndoDeleteNotesAppBarUseCase(repository: repository);
    },
  );

  final model = HomeAppBarModel.fromList(<Note>[]);

  test(
    'should return Right<HomeAppBarEntity> when useCase is called',
    () {
      when(repository.undoDelete(any)).thenReturn(Right(model));

      final result =
          useCase(UndoDeleteNotesAppBarParams(selectedNotes: <Note>[]));

      verify(repository.undoDelete(<Note>[]));
      verifyNoMoreInteractions(repository);
      expect(result, Right(model));
    },
  );
}

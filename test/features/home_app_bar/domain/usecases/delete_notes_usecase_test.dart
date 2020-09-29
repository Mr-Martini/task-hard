import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/home_app_bar/domain/entities/home_app_bar_entity.dart';
import 'package:task_hard/features/home_app_bar/domain/repositories/home_app_bar_repository.dart';
import 'package:task_hard/features/home_app_bar/domain/usecases/delete_notes_usecase.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

class MockHomeAppBarRepository extends Mock implements HomeAppBarRepository {}

void main() {
  MockHomeAppBarRepository repository;
  DeleteNotesAppBarUseCase useCase;

  setUp(
    () {
      repository = MockHomeAppBarRepository();
      useCase = DeleteNotesAppBarUseCase(repository: repository);
    },
  );

  final HomeAppBarEntity entity = HomeAppBarEntity(selectedNotes: <Note>[]);
  test(
    'should return Right<HomeAppBarEntity> when DeleteNotesAppBar is called',
    () {
      when(repository.deleteNotes(any)).thenReturn(Right(entity));

      final result = useCase(DeleteNoteAppBarParams(notes: <Note>[]));

      verify(repository.deleteNotes(<Note>[]));
      verifyNoMoreInteractions(repository);
      expect(result, Right(entity));
    },
  );
}

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/home_app_bar/domain/entities/home_app_bar_entity.dart';
import 'package:task_hard/features/home_app_bar/domain/repositories/home_app_bar_repository.dart';
import 'package:task_hard/features/home_app_bar/domain/usecases/change_color_usecase.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

class MockHomeAppBarRepository extends Mock implements HomeAppBarRepository {}

void main() {
  MockHomeAppBarRepository repository;
  ChangeColorUseCase useCase;

  setUp(
    () {
      repository = MockHomeAppBarRepository();
      useCase = ChangeColorUseCase(repository: repository);
    },
  );

  final model = HomeAppBarEntity(selectedNotes: <Note>[]);

  test(
    'should return Right<HomeAppBarEntity> when ChangeColorUseCase is called',
    () {
      when(repository.changeColor(any, any)).thenReturn(Right(model));

      final result =
          useCase(ChangeColorParams(notes: <Note>[], color: Colors.blue));

      verify(repository.changeColor(Colors.blue, <Note>[]));
      verifyNoMoreInteractions(repository);
      expect(result, Right(model));
    },
  );
}

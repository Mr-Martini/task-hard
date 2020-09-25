import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:task_hard/features/theme/data/model/theme_model.dart';
import 'package:task_hard/features/theme/domain/entities/theme_entity.dart';
import 'package:task_hard/features/theme/domain/repositories/theme_repository.dart';
import 'package:task_hard/features/theme/domain/usecases/theme_get_theme_data_usecase.dart';

class MockThemeRepository extends Mock implements ThemeRepository {}

void main() {
  GetThemeDataUseCase useCase;
  MockThemeRepository repository;

  setUp(
    () {
      repository = MockThemeRepository();
      useCase = GetThemeDataUseCase(repository);
    },
  );

  final themeModel = ThemeEntity(
    themeData: ThemeData(),
    darkTheme: ThemeData.dark(),
    mainColor: Colors.blue,
    preference: themePreference.automatic.toString(),
  );

  test(
    'should return [Right<ThemeEntity>] when getThemeData is called',
    () {
      when(repository.getThemeData()).thenReturn(Right(themeModel));

      final result = useCase(NoParams());

      verify(repository.getThemeData());
      verifyNoMoreInteractions(repository);
      expect(result, Right(themeModel));
    },
  );
}

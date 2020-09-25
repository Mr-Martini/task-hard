import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/theme/data/model/theme_model.dart';
import 'package:task_hard/features/theme/domain/entities/theme_entity.dart';
import 'package:task_hard/features/theme/domain/repositories/theme_repository.dart';
import 'package:task_hard/features/theme/domain/usecases/theme_set_theme.dart';

class MockThemeRepository extends Mock implements ThemeRepository {}

void main() {
  MockThemeRepository repository;
  SetThemeUseCase useCase;

  setUp(
    () {
      repository = MockThemeRepository();
      useCase = SetThemeUseCase(repository);
    },
  );

  final themeEntity = ThemeEntity(
    themeData: null,
    darkTheme: null,
    mainColor: Colors.blue,
    preference: themePreference.light.toString(),
  );

  test(
    'should return [Right<ThemeEntity]',
    () {
      when(repository.getToggleTheme(themePreference.dark))
          .thenReturn(Right(themeEntity));

      final result = useCase(ThemeSetThemeParams(themePreference.dark));

      verify(repository.getToggleTheme(themePreference.dark));
      expect(result, Right(themeEntity));
    },
  );
}

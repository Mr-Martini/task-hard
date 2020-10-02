import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/theme/data/model/theme_model.dart';
import 'package:task_hard/features/theme/domain/repositories/theme_repository.dart';
import 'package:task_hard/features/theme/domain/usecases/theme_set_theme_main_color.dart';

class MockThemeRepository extends Mock implements ThemeRepository {}

void main() {
  SetMainColorUseCase useCase;
  MockThemeRepository repository;

  setUp(
    () {
      repository = MockThemeRepository();
      useCase = SetMainColorUseCase(repository);
    },
  );

  final expectedModel = ThemeModel(
      themeData: null,
      darkTheme: null,
      preference: null,
      mainColor: Colors.blue);

  test(
    'should return [Right<ThemeEntity>] when setMainColor is called',
    () {
      when(repository.setMainColor(Colors.blue))
          .thenReturn(Right(expectedModel));

      final result = useCase(ThemeSetMainColorParams(Colors.blue));

      verify(repository.setMainColor(Colors.blue));
      expect(result, Right(expectedModel));
    },
  );
}

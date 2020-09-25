import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/theme/data/datasources/theme_local_data_source.dart';
import 'package:task_hard/features/theme/data/model/theme_model.dart';
import 'package:task_hard/features/theme/data/repositories/theme_repository_impl.dart';

class MockLocalDataSource extends Mock implements ThemeLocalDataSource {}

void main() {
  MockLocalDataSource mock;
  ThemeRepositoryImpl sourceImpl;

  setUp(
    () {
      mock = MockLocalDataSource();
      sourceImpl = ThemeRepositoryImpl(mock);
    },
  );

  final defaultTheme = ThemeModel(
    themeData: ThemeData()
        .copyWith(primaryColor: Colors.white, buttonColor: Colors.blue),
    darkTheme: ThemeData.dark().copyWith(buttonColor: Colors.blue),
    mainColor: Colors.blue,
    preference: themePreference.automatic.toString(),
  );
  test(
    'should return defaultTheme when there\'s nothing in cache',
    () {
      when(mock.getTheme()).thenReturn(defaultTheme);

      final result = sourceImpl.getThemeData();

      verify(sourceImpl.getThemeData());
      expect(result, Right(defaultTheme));
    },
  );

  final lightTheme = ThemeModel(
    themeData: ThemeData()
        .copyWith(primaryColor: Colors.white, buttonColor: Colors.blue),
    darkTheme: null,
    mainColor: Colors.blue,
    preference: themePreference.light.toString(),
  );

  test(
    'should return lightTheme when [themePreference.light] is called',
    () {
      when(mock.setTheme(themePreference.light)).thenReturn(lightTheme);

      final result = sourceImpl.getToggleTheme(themePreference.light);

      verify(sourceImpl.getToggleTheme(themePreference.light));
      expect(result, Right(lightTheme));
    },
  );

  final modelColor = ThemeModel(
    themeData: ThemeData()
        .copyWith(primaryColor: Colors.white, buttonColor: Colors.blue),
    darkTheme: null,
    mainColor: Colors.blue,
    preference: themePreference.light.toString(),
  );

  test(
    'should return the model with the specified color',
    () {
      when(mock.setColor(Colors.blue)).thenReturn(modelColor);

      final result = sourceImpl.setMainColor(Colors.blue);

      verify(sourceImpl.setMainColor(Colors.blue));
      expect(result, Right(modelColor));
    },
  );
}

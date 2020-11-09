import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/theme/data/datasources/theme_local_data_source.dart';
import 'package:task_hard/features/theme/data/model/theme_model.dart';

class MockBox extends Mock implements Box<dynamic> {}

void main() {
  MockBox mockBox;
  ThemeLocalDataSourceImpl dataSource;

  setUp(
    () {
      mockBox = MockBox();
      dataSource = ThemeLocalDataSourceImpl(themeBox: mockBox);
    },
  );

  final expectedModel = ThemeModel(
    themeData: ThemeData.light().copyWith(
      buttonColor: Colors.blue,
      primaryColor: Colors.white,
      textTheme: Typography.blackRedmond,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: Typography.blackRedmond.headline6.color,
        ),
      ),
    ),
    preference: themePreference.light.toString(),
    mainColor: Colors.blue,
    darkTheme: null,
  );

  final model = <String, dynamic>{
    "theme": themePreference.automatic.toString(),
    "color": 'blue'
  };
  test(
    'should return ThemeEntity with the specified theme',
    () {
      when(mockBox.get(any)).thenReturn(model);

      final result = dataSource.setTheme(themePreference.light);

      expect(result, expectedModel);
    },
  );
}

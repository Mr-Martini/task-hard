import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_hard/features/theme/data/model/theme_model.dart';

void main() {
  test(
    'should return a valid json for a model',
    () {
      themePreference dark = themePreference.dark;

      final themeModel = ThemeModel(
        themeData: null,
        darkTheme: ThemeData.dark().copyWith(buttonColor: Colors.blue),
        mainColor: Colors.blue,
        preference: themePreference.dark.toString(),
      );

      Map<String, dynamic> map = {
        'color': 'blue',
        'theme': dark.toString(),
      };

      final result = themeModel.toMap();

      expect(result, map);
    },
  );
}

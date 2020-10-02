import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_hard/features/theme/data/model/theme_model.dart';

void main() {
  test(
    'shoud return the [themeModel] when theme model facotry is called',
    () {
      themePreference dark = themePreference.dark;

      Map<String, dynamic> map = {'color': 'blue', 'theme': dark.toString()};

      final themeModel = ThemeModel(
        themeData: null,
        darkTheme: ThemeData.dark().copyWith(
          buttonColor: Colors.blue,
          textTheme: Typography.whiteRedmond,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Typography.whiteRedmond.headline6.color,
            ),
          ),
        ),
        mainColor: Colors.blue,
        preference: themePreference.dark.toString(),
      );

      final result = ThemeModel.fromMap(map);

      expect(result, themeModel);
    },
  );

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

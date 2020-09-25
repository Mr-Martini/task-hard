import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_hard/features/theme/data/model/theme_model.dart';

void main() {
  test(
    'shoud return the [themeModel] when theme model facotry is called',
    () {
      Color pink = Colors.pink;

      themePreference dark = themePreference.dark;

      Map<String, dynamic> map = {
        'color': pink.toString(),
        'theme': dark.toString(),
      };

      final themeModel = ThemeModel(
        themeData: null,
        darkTheme: ThemeData.dark().copyWith(
          buttonColor: pink,
          textTheme: Typography.whiteRedmond,
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Typography.whiteRedmond.headline6.color,
            ),
          ),
        ),
        mainColor: pink,
        preference: themePreference.dark.toString(),
      );

      final result = ThemeModel.fromMap(map);

      expect(result, themeModel);
    },
  );

  test(
    'should return a valid json for a model',
    () {
      Color pink = Colors.pink;
      themePreference dark = themePreference.dark;

      final themeModel = ThemeModel(
        themeData: null,
        darkTheme: ThemeData.dark().copyWith(buttonColor: pink),
        mainColor: pink,
        preference: themePreference.dark.toString(),
      );

      Map<String, dynamic> map = {
        'color': pink.toString(),
        'theme': dark.toString(),
      };

      final result = themeModel.toMap();

      expect(result, map);
    },
  );
}

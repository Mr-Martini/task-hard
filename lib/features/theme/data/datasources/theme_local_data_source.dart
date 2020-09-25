import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_hard/features/theme/data/model/theme_model.dart';
import 'package:meta/meta.dart';

const String THEME_BOX = 'THEME_BOX';

abstract class ThemeLocalDataSource {
  ThemeModel getTheme();
  ThemeModel setTheme(themePreference preference);
  ThemeModel setColor(Color color);
}

class ThemeLocalDataSourceImpl implements ThemeLocalDataSource {
  final Box<dynamic> themeBox;

  ThemeLocalDataSourceImpl({@required this.themeBox});

  @override
  ThemeModel getTheme() {
    final theme = themeBox.get(THEME_BOX, defaultValue: null);
    if (theme != null) {
      return ThemeModel.fromMap(theme);
    }
    final model = ThemeModel(
      themeData: ThemeData().copyWith(
        primaryColor: Colors.white,
        buttonColor: Colors.blue,
        textTheme: Typography.blackRedmond,
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Typography.blackRedmond.headline6.color,
          ),
        ),
      ),
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
      preference: themePreference.automatic.toString(),
    );
    themeBox.put(THEME_BOX, model.toMap());
    return model;
  }

  @override
  ThemeModel setTheme(themePreference preference) {
    dynamic map = themeBox.get(THEME_BOX);

    map['theme'] = preference.toString();

    themeBox.put(THEME_BOX, map);

    return ThemeModel.fromMap(map);
  }

  @override
  ThemeModel setColor(Color color) {
    dynamic map = themeBox.get(THEME_BOX);

    map['color'] = color.toString();

    themeBox.put(THEME_BOX, map);

    return ThemeModel.fromMap(map);
  }
}

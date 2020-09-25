import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_hard/features/theme/domain/entities/theme_entity.dart';

class ThemeModel extends Equatable implements ThemeEntity {
  final ThemeData themeData;
  final ThemeData darkTheme;
  final Color mainColor;
  final String preference;

  ThemeModel({
    @required this.themeData,
    @required this.darkTheme,
    @required this.mainColor,
    @required this.preference,
  });

  factory ThemeModel.fromMap(dynamic map) {
    themePreference _fromString(String theme) {
      for (themePreference value in themePreference.values) {
        if (value.toString() == theme) return value;
      }
      return null;
    }

    Map<String, Color> _getHiveColor = {
      Colors.blue.toString(): Colors.blue,
      Colors.orange.toString(): Colors.orange,
      Colors.green.toString(): Colors.green,
      Colors.red.toString(): Colors.red,
      Colors.deepPurple.toString(): Colors.deepPurple,
      Colors.purple.toString(): Colors.purple,
      Colors.amber.toString(): Colors.amber,
      Colors.teal.toString(): Colors.teal,
      Colors.pink.toString(): Colors.pink,
      Colors.black38.toString(): Colors.black38
    };

    String hiveColor = map['color'];
    themePreference preference = _fromString(map['theme']);
    Color color = _getHiveColor[hiveColor];

    switch (preference) {
      case themePreference.automatic:
        return ThemeModel(
          themeData: ThemeData().copyWith(
            buttonColor: color,
            primaryColor: Colors.white,
            textTheme: Typography.blackRedmond,
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                color: Typography.blackRedmond.headline6.color,
              ),
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            buttonColor: color,
            textTheme: Typography.whiteRedmond,
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                color: Typography.whiteRedmond.headline6.color,
              ),
            ),
          ),
          mainColor: color,
          preference: preference.toString(),
        );
        break;
      case themePreference.light:
        return ThemeModel(
          themeData: ThemeData.light().copyWith(
            buttonColor: color,
            primaryColor: Colors.white,
            textTheme: Typography.blackRedmond,
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                color: Typography.blackRedmond.headline6.color,
              ),
            ),
          ),
          darkTheme: null,
          mainColor: color,
          preference: preference.toString(),
        );
        break;
      case themePreference.dark:
        return ThemeModel(
          darkTheme: ThemeData.dark().copyWith(
            buttonColor: color,
            textTheme: Typography.whiteRedmond,
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(
                color: Typography.whiteRedmond.headline6.color,
              ),
            ),
          ),
          themeData: null,
          mainColor: color,
          preference: preference.toString(),
        );
        break;
      default:
        return ThemeModel(
          themeData: ThemeData()
              .copyWith(buttonColor: color, primaryColor: Colors.white),
          darkTheme: ThemeData.dark().copyWith(buttonColor: color),
          mainColor: color,
          preference: preference.toString(),
        );
    }
  }

  Map<String, dynamic> toMap() {
    themePreference preference;

    if (themeData != null && darkTheme != null) {
      preference = themePreference.automatic;
    } else if (themeData == null) {
      preference = themePreference.dark;
    } else {
      preference = themePreference.light;
    }

    return <String, dynamic>{
      'theme': preference.toString(),
      'color': mainColor.toString(),
    };
  }

  @override
  List<Object> get props => [themeData, darkTheme, mainColor, preference];
}

enum themePreference { dark, light, automatic }

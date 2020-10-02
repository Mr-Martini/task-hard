import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_hard/core/Utils/accent_colors.dart';
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

    String hiveColor = map['color'];
    themePreference preference = _fromString(map['theme']);
    final Color lightColor = AccentColors.getLightColor(hiveColor);
    final Color darkColor = AccentColors.getDarkColor(hiveColor);

    ThemeData lightTheme = ThemeData.light().copyWith(
      buttonColor: lightColor,
      primaryColor: Colors.white,
      textTheme: Typography.blackRedmond,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: Typography.blackRedmond.headline6.color,
        ),
      ),
    );

    ThemeData darkTheme = ThemeData.dark().copyWith(
      buttonColor: darkColor,
      textTheme: Typography.whiteRedmond,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: Typography.whiteRedmond.headline6.color,
        ),
      ),
    );

    switch (preference) {
      case themePreference.automatic:
        return ThemeModel(
          themeData: lightTheme,
          darkTheme: darkTheme,
          mainColor: lightColor,
          preference: preference.toString(),
        );
        break;
      case themePreference.light:
        return ThemeModel(
          themeData: lightTheme,
          darkTheme: null,
          mainColor: lightColor,
          preference: preference.toString(),
        );
        break;
      case themePreference.dark:
        return ThemeModel(
          darkTheme: darkTheme,
          themeData: null,
          mainColor: darkColor,
          preference: preference.toString(),
        );
        break;
      default:
        return ThemeModel(
          themeData: lightTheme,
          darkTheme: darkTheme,
          mainColor: lightColor,
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
      'color': AccentColors.getColorName(mainColor),
    };
  }

  @override
  List<Object> get props => [themeData, mainColor, darkTheme, preference];
}

enum themePreference { dark, light, automatic }

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class ThemeEntity extends Equatable {
  final ThemeData themeData;
  final ThemeData darkTheme;
  final Color mainColor;
  final String preference;

  ThemeEntity({
    @required this.themeData,
    @required this.darkTheme,
    @required this.mainColor,
    @required this.preference,
  });

  @override
  List<Object> get props => [themeData, darkTheme, mainColor, preference];
}

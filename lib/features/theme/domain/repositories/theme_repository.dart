import 'package:dartz/dartz.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/features/theme/data/model/theme_model.dart';
import 'package:task_hard/features/theme/domain/entities/theme_entity.dart';
import 'package:flutter/material.dart';

abstract class ThemeRepository {
  Either<Failure, ThemeEntity> getThemeData();
  Either<Failure, ThemeEntity> getToggleTheme(themePreference preference);
  Either<Failure, ThemeEntity> setMainColor(Color color);
}

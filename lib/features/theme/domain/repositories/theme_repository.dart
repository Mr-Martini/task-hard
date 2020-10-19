import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../data/model/theme_model.dart';
import '../entities/theme_entity.dart';

abstract class ThemeRepository {
  Either<Failure, ThemeEntity> getThemeData();
  Either<Failure, ThemeEntity> getToggleTheme(themePreference preference);
  Either<Failure, ThemeEntity> setMainColor(Color color);
}

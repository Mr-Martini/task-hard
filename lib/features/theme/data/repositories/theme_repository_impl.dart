import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/theme_entity.dart';
import '../../domain/repositories/theme_repository.dart';
import '../datasources/theme_local_data_source.dart';
import '../model/theme_model.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource dataSource;

  ThemeRepositoryImpl(this.dataSource);

  @override
  Either<Failure, ThemeEntity> getThemeData() {
    try {
      final theme = dataSource.getTheme();
      return Right(theme);
    } on NoSuchMethodError{
      return Left(ThemeBlocNotReady());
    } catch (e) {
      FirebaseCrashlytics.instance.recordError(e, StackTrace.current);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, ThemeEntity> getToggleTheme(themePreference preference) {
    try {
      final theme = dataSource.setTheme(preference);
      return Right(theme);
    } catch (e) {
      FirebaseCrashlytics.instance.recordError(e, StackTrace.current);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, ThemeEntity> setMainColor(Color color) {
    try {
      final theme = dataSource.setColor(color);
      return Right(theme);
    } catch (e) {
      FirebaseCrashlytics.instance.recordError(e, StackTrace.current);
      return Left(CacheFailure());
    }
  }
}

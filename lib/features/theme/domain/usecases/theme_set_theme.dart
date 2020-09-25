import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:task_hard/features/theme/data/model/theme_model.dart';
import 'package:task_hard/features/theme/domain/entities/theme_entity.dart';
import 'package:task_hard/features/theme/domain/repositories/theme_repository.dart';

class SetThemeUseCase implements UseCases<ThemeEntity, ThemeSetThemeParams> {
  final ThemeRepository repository;

  SetThemeUseCase(this.repository);

  @override
  Either<Failure, ThemeEntity> call(ThemeSetThemeParams params) {
    return repository.getToggleTheme(params.preference);
  }
}

class ThemeSetThemeParams extends Equatable {
  final themePreference preference;

  ThemeSetThemeParams(this.preference);

  @override
  List<Object> get props => [preference];
}

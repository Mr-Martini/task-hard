import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/model/theme_model.dart';
import '../entities/theme_entity.dart';
import '../repositories/theme_repository.dart';

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

import 'package:task_hard/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:task_hard/features/theme/domain/entities/theme_entity.dart';
import 'package:task_hard/features/theme/domain/repositories/theme_repository.dart';

class GetThemeDataUseCase implements UseCases<ThemeEntity, NoParams> {
  final ThemeRepository repository;

  GetThemeDataUseCase(this.repository);

  @override
  Either<Failure, ThemeEntity> call(NoParams params) {
    return repository.getThemeData();
  }
}

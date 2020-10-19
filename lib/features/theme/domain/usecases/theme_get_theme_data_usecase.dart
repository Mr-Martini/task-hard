import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/theme_entity.dart';
import '../repositories/theme_repository.dart';

class GetThemeDataUseCase implements UseCases<ThemeEntity, NoParams> {
  final ThemeRepository repository;

  GetThemeDataUseCase(this.repository);

  @override
  Either<Failure, ThemeEntity> call(NoParams params) {
    return repository.getThemeData();
  }
}

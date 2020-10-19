import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/time_preference.dart';
import '../repositories/time_preference_repository.dart';

class GetTimePreferenceUseCase implements UseCases<TimePreference, NoParams> {
  final TimePreferenceRepository repository;

  GetTimePreferenceUseCase(this.repository);

  @override
  Either<Failure, TimePreference> call(NoParams params) {
    return repository.getPreference();
  }
}

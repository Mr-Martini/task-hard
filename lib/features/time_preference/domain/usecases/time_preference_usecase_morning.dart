import 'package:task_hard/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:task_hard/features/time_preference/domain/entities/time_preference.dart';
import 'package:task_hard/features/time_preference/domain/repositories/time_preference_repository.dart';

class GetTimePreferenceUseCase implements UseCases<TimePreference, NoParams> {
  final TimePreferenceRepository repository;

  GetTimePreferenceUseCase(this.repository);

  @override
  Either<Failure, TimePreference> call(NoParams params) {
    return repository.getPreference();
  }
}

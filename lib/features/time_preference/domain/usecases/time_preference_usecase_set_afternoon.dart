import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:task_hard/features/time_preference/domain/entities/time_preference.dart';
import 'package:task_hard/features/time_preference/domain/repositories/time_preference_repository.dart';

class SetAfternoonTimePreferenceUsecase
    extends UseCases<TimePreference, AfternoonParams> {
  final TimePreferenceRepository repository;

  SetAfternoonTimePreferenceUsecase(this.repository);

  @override
  Either<Failure, TimePreference> call(AfternoonParams params) {
    return repository.setAfternoon(afternoon: params.afternoon);
  }
}

class AfternoonParams extends Equatable {
  final TimeOfDay afternoon;

  AfternoonParams({@required this.afternoon});

  @override
  List<Object> get props => [afternoon];
}

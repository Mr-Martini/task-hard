import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:task_hard/features/time_preference/domain/entities/time_preference.dart';
import 'package:meta/meta.dart';
import 'package:task_hard/features/time_preference/domain/repositories/time_preference_repository.dart';

class SetMorningTimePreferenceUseCase
    implements UseCases<TimePreference, MorningParams> {
  final TimePreferenceRepository repository;

  SetMorningTimePreferenceUseCase(this.repository);

  @override
  Either<Failure, TimePreference> call(MorningParams params) {
    return repository.setMorning(morning: params.morning);
  }
}

class MorningParams extends Equatable {
  final TimeOfDay morning;

  MorningParams({@required this.morning});

  @override
  List<Object> get props => [morning];
}

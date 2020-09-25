import 'package:equatable/equatable.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:task_hard/features/time_preference/domain/entities/time_preference.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:task_hard/features/time_preference/domain/repositories/time_preference_repository.dart';

class SetNightTimePreferenceUseCase
    extends UseCases<TimePreference, NightParams> {
  final TimePreferenceRepository repository;

  SetNightTimePreferenceUseCase(this.repository);

  @override
  Either<Failure, TimePreference> call(NightParams params) {
    return repository.setNight(night: params.night);
  }
}

class NightParams extends Equatable {
  final TimeOfDay night;

  NightParams({@required this.night});

  @override
  List<Object> get props => [night];
}

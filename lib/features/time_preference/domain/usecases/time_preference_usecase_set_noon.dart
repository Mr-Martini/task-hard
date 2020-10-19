import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/time_preference.dart';
import '../repositories/time_preference_repository.dart';

class SetNoonTimePreferenceUseCase
    extends UseCases<TimePreference, NoonParams> {
  final TimePreferenceRepository repository;

  SetNoonTimePreferenceUseCase(this.repository);

  @override
  Either<Failure, TimePreference> call(NoonParams params) {
    return repository.setNoon(noon: params.noon);
  }
}

class NoonParams extends Equatable {
  final TimeOfDay noon;

  NoonParams({@required this.noon});

  @override
  List<Object> get props => [noon];
}

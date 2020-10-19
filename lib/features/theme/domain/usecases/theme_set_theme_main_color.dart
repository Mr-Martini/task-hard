import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/theme_entity.dart';
import '../repositories/theme_repository.dart';

class SetMainColorUseCase
    implements UseCases<ThemeEntity, ThemeSetMainColorParams> {
  final ThemeRepository repository;

  SetMainColorUseCase(this.repository);

  @override
  Either<Failure, ThemeEntity> call(ThemeSetMainColorParams params) {
    return repository.setMainColor(params.color);
  }
}

class ThemeSetMainColorParams extends Equatable {
  final Color color;

  ThemeSetMainColorParams(this.color);

  @override
  List<Object> get props => [color];
}

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:task_hard/features/theme/domain/entities/theme_entity.dart';
import 'package:task_hard/features/theme/domain/repositories/theme_repository.dart';
import 'package:flutter/material.dart';

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

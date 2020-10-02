import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/visualization_option.dart';
import '../repositories/visualization_option_repository.dart';

class SetVisualizationOptionUseCase
    implements UseCases<VisualizationOption, SetVisualizationOptionParams> {
  final VisualizationOptionRepository repository;

  SetVisualizationOptionUseCase({@required this.repository});

  @override
  Either<Failure, VisualizationOption> call(
      SetVisualizationOptionParams params) {
    return repository.setVisualizatinOption(params.value);
  }
}

class SetVisualizationOptionParams extends Equatable {
  final int value;

  SetVisualizationOptionParams({@required this.value});

  @override
  List<Object> get props => [value];
}

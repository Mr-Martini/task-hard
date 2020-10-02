import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../domain/entities/visualization_option.dart';
import '../../domain/usecases/get_visualization_option_usecase.dart';
import '../../domain/usecases/set_visualization_option.dart';

part 'visualizationoption_event.dart';
part 'visualizationoption_state.dart';

class VisualizationOptionBloc
    extends Bloc<VisualizationOptionEvent, VisualizationOptionState> {
  final GetVisualizationOptionUseCase getVisualizationOption;
  final SetVisualizationOptionUseCase setVisualizationOption;

  VisualizationOptionBloc({
    @required this.getVisualizationOption,
    @required this.setVisualizationOption,
  }) : super(VisualizationOptionInitial());

  @override
  Stream<VisualizationOptionState> mapEventToState(
    VisualizationOptionEvent event,
  ) async* {
    if (event is GetVisualizationOption) {
      final type = getVisualizationOption(NoParams());
      yield* _eitherFailureOrSuccess(type);
    } else if (event is SetVisualizationOption) {
      final type = setVisualizationOption(
          SetVisualizationOptionParams(value: event.value));
      yield* _eitherFailureOrSuccess(type);
    }
  }

  Stream<VisualizationOptionState> _eitherFailureOrSuccess(
      Either<Failure, VisualizationOption> type) async* {
    yield type.fold(
      (failure) => Error(message: 'Something happened'),
      (option) => Loaded(type: option),
    );
  }
}

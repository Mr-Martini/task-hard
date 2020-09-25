import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_hard/features/time_preference/domain/usecases/time_preference_usecase_night.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../domain/entities/time_preference.dart';
import '../../domain/usecases/time_preference_usecase_morning.dart';
import '../../domain/usecases/time_preference_usecase_set_afternoon.dart';
import '../../domain/usecases/time_preference_usecase_set_noon.dart';
import '../../domain/usecases/time_preference_usecase_set_preference_morning.dart';

part 'timepreference_event.dart';
part 'timepreference_state.dart';

const String CACHE_FAILURE = 'CACHE_FAILURE';

class TimepreferenceBloc
    extends Bloc<TimepreferenceEvent, TimepreferenceState> {
  final GetTimePreferenceUseCase getTime;
  final SetMorningTimePreferenceUseCase setMorning;
  final SetNoonTimePreferenceUseCase setNoon;
  final SetAfternoonTimePreferenceUsecase setAfternoon;
  final SetNightTimePreferenceUseCase setNight;

  TimepreferenceBloc({
    @required this.getTime,
    @required this.setMorning,
    @required this.setNoon,
    @required this.setAfternoon,
    @required this.setNight,
  }) : super(TimepreferenceInitial());

  @override
  Stream<TimepreferenceState> mapEventToState(
    TimepreferenceEvent event,
  ) async* {
    if (event is GetTimePreference) {
      yield Loading();
      final preference = getTime(NoParams());
      yield* _eitherFailureOrSuccess(preference);
    } else if (event is SetMorningTimePreference) {
      yield Loading();
      final preference = setMorning(MorningParams(morning: event.morning));
      yield* _eitherFailureOrSuccess(preference);
    } else if (event is SetNoonTimePreference) {
      yield Loading();
      final preference = setNoon(NoonParams(noon: event.noon));
      yield* _eitherFailureOrSuccess(preference);
    } else if (event is SetAfternoonTimePreference) {
      yield Loading();
      final preference =
          setAfternoon(AfternoonParams(afternoon: event.afternoon));
      yield* _eitherFailureOrSuccess(preference);
    } else if (event is SetNightTimePreference) {
      yield Loading();
      final preference = setNight(NightParams(night: event.night));
      yield* _eitherFailureOrSuccess(preference);
    }
  }

  Stream<TimepreferenceState> _eitherFailureOrSuccess(
      Either<Failure, TimePreference> preference) async* {
    yield preference.fold(
      (failure) => Error(message: CACHE_FAILURE),
      (model) => Loaded(timePreference: model),
    );
  }
}

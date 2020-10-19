import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../data/model/theme_model.dart';
import '../../domain/entities/theme_entity.dart';
import '../../domain/usecases/theme_get_theme_data_usecase.dart';
import '../../domain/usecases/theme_set_theme.dart';
import '../../domain/usecases/theme_set_theme_main_color.dart';

part 'theme_event.dart';
part 'theme_state.dart';

const String CACHE_FAILURE = 'CACHE_FAILURE';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetThemeDataUseCase getTheme;
  final SetThemeUseCase setTheme;
  final SetMainColorUseCase setColor;

  ThemeBloc({
    @required this.getTheme,
    @required this.setTheme,
    @required this.setColor,
  }) : super(ThemeInitial());

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is GetTheme) {
      yield Loading();
      final theme = getTheme(NoParams());
      yield* _eitherFailureOrSuccess(theme);
    } else if (event is SetTheme) {
      yield Loading();
      final theme = setTheme(ThemeSetThemeParams(event.preference));
      yield* _eitherFailureOrSuccess(theme);
    } else if (event is SetColor) {
      yield Loading();
      final theme = setColor(ThemeSetMainColorParams(event.color));
      yield* _eitherFailureOrSuccess(theme);
    }
  }

  Stream<ThemeState> _eitherFailureOrSuccess(
      Either<Failure, ThemeEntity> theme) async* {
    yield theme.fold(
      (failure) => Error(message: CACHE_FAILURE),
      (theme) => Loaded(theme: theme),
    );
  }
}

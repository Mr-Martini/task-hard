import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../domain/entities/taged_notes_home.dart';
import '../../domain/usecases/taged_notes_home_get_preference.dart';
import '../../domain/usecases/taged_notes_home_set_preferences.dart';

part 'tagednoteshomebloc_event.dart';
part 'tagednoteshomebloc_state.dart';

const String CACHE_FAILURE_MESSAGE = 'Cache Failure';

class TagednoteshomeblocBloc
    extends Bloc<TagednoteshomeblocEvent, TagednoteshomeblocState> {
  final GetTagedNotesHomePreference getTagedNotesHomePreference;
  final SetTagedNotesPreference setTagedNotesPreference;

  TagednoteshomeblocBloc({
    @required GetTagedNotesHomePreference getPreference,
    @required SetTagedNotesPreference setPreference,
  })  : getTagedNotesHomePreference = getPreference,
        setTagedNotesPreference = setPreference,
        super(Empty());

  @override
  Stream<TagednoteshomeblocState> mapEventToState(
    TagednoteshomeblocEvent event,
  ) async* {
    if (event is GetPreference) {
      yield Loading();
      final preference = getTagedNotesHomePreference(NoParams());
      yield* _eitherLoadOrError(preference);
    } else if (event is SetPreference) {
      yield Loading();
      final preference = setTagedNotesPreference(Params(should: event.should));
      yield* _eitherLoadOrError(preference);
    }
  }

  Stream<TagednoteshomeblocState> _eitherLoadOrError(
      Either<Failure, TagedNotesHome> should) async* {
    yield should.fold(
      (failure) => Error(message: CACHE_FAILURE_MESSAGE),
      (preference) => Loaded(should: preference.should),
    );
  }
}

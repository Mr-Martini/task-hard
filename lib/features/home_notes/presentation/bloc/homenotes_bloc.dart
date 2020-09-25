import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:task_hard/features/home_notes/domain/usecases/listen_notes_usecase.dart';

import '../../domain/entities/home_notes.dart';
import '../../domain/usecases/get_notes_usecase.dart';

part 'homenotes_event.dart';
part 'homenotes_state.dart';

class HomenotesBloc extends Bloc<HomenotesEvent, HomenotesState> {
  final GetNotesUseCase getNotes;
  final ListenNotesUseCase listenNotes;

  ValueListenable _subscription;

  HomenotesBloc({
    @required this.getNotes,
    @required this.listenNotes,
  }) : super(HomenotesInitial());

  @override
  Stream<HomenotesState> mapEventToState(
    HomenotesEvent event,
  ) async* {
    if (event is GetHomeNotes) {
      _subscription = Hive.box('notes').listenable();
      _subscription.addListener(_listener);
      final list = getNotes(NoParams());
      yield* _eitherFailureOrSuccess(list);
    } else if (event is ListenHomeNotes) {
      final list = listenNotes(ListenNotesParams(notes: event.notes));
      yield* _eitherFailureOrSuccess(list);
    }
  }

  Stream<HomenotesState> _eitherFailureOrSuccess(
      Either<Failure, HomeNotes> list) async* {
    yield list.fold(
      (failure) => Error(message: 'Something went wrong'),
      (homeNotes) => Loaded(notes: homeNotes),
    );
  }

  void _listener() {
    Box<dynamic> box = _subscription.value;
    add(ListenHomeNotes(notes: box.values));
  }

  @override
  Future<void> close() {
    _subscription.removeListener(_listener);
    return super.close();
  }
}

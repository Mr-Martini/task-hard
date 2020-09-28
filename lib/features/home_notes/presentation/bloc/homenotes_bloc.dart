import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_hard/controllers/repeat-controller/repeat-controller.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:task_hard/features/home_notes/domain/usecases/expire_checker_usecase.dart';
import 'package:task_hard/features/home_notes/domain/usecases/listen_notes_usecase.dart';

import '../../domain/entities/home_notes.dart';
import '../../domain/usecases/get_notes_usecase.dart';

part 'homenotes_event.dart';
part 'homenotes_state.dart';

class HomenotesBloc extends Bloc<HomenotesEvent, HomenotesState> {
  final GetNotesUseCase getNotes;
  final ListenNotesUseCase listenNotes;
  final ExpireCheckerUseCase expireChecker;

  ValueListenable _subscription;
  Timer _timer;

  HomenotesBloc({
    @required this.getNotes,
    @required this.listenNotes,
    @required this.expireChecker,
  }) : super(HomenotesInitial());

  @override
  Stream<HomenotesState> mapEventToState(
    HomenotesEvent event,
  ) async* {
    if (event is GetHomeNotes) {
      _subscription = Hive.box('notes').listenable();
      _subscription.addListener(_listener);
      _expireChecker();
      final list = getNotes(NoParams());
      yield* _eitherFailureOrSuccess(list);
    } else if (event is ListenHomeNotes) {
      final list = listenNotes(ListenNotesParams(notes: event.notes));
      yield* _eitherFailureOrSuccess(list);
    } else if (event is ExpireChecker) {
      final list = expireChecker(ExpireCheckerParams(notes: event.notes));
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

  void _expireChecker() {
    _timer = Timer.periodic(
      Duration(seconds: 4),
      (timer) {
        Box<dynamic> box = _subscription.value;
        Iterable<dynamic> notes = box.values;
        Iterable<dynamic> filtered = notes.where(
          (element) {
            DateTime reminder = element['reminder'];
            if (reminder != null && element['repeat'] == Repeat.NO_REPEAT) {
              DateTime now = DateTime.now();
              if (reminder.isBefore(now) && element['expired'] != true) {
                return true;
              }
            }
            return false;
          },
        );
        if (filtered.isNotEmpty) {
          add(ExpireChecker(notes: filtered));
        }
      },
    );
  }

  void _listener() {
    Box<dynamic> box = _subscription.value;
    add(ListenHomeNotes(notes: box.values));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    _subscription.removeListener(_listener);
    return super.close();
  }
}

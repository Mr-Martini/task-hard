import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../../controllers/repeat-controller/repeat-controller.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../../dependency_container.dart';
import '../../../note/domain/entities/note.dart';
import '../../domain/entities/home_notes.dart';
import '../../domain/usecases/delete_empty_notes_usecase.dart';
import '../../domain/usecases/expire_checker_usecase.dart';
import '../../domain/usecases/get_notes_usecase.dart';
import '../../domain/usecases/listen_notes_usecase.dart';

part 'homenotes_event.dart';
part 'homenotes_state.dart';

class HomenotesBloc extends Bloc<HomenotesEvent, HomenotesState> {
  final GetNotesUseCase getNotes;
  final ListenNotesUseCase listenNotes;
  final ExpireCheckerUseCase expireChecker;
  final DeleteEmptyNotesUseCase deleteEmptyNotes;

  Timer _timer;

  HomenotesBloc({
    @required this.getNotes,
    @required this.listenNotes,
    @required this.expireChecker,
    @required this.deleteEmptyNotes,
  }) : super(HomenotesInitial());

  @override
  Stream<HomenotesState> mapEventToState(
    HomenotesEvent event,
  ) async* {
    if (event is GetHomeNotes) {
      _expireChecker();
      final list = getNotes(NoParams());
      yield* _eitherFailureOrSuccess(list);
    } else if (event is ListenHomeNotes) {
      final list = listenNotes(ListenNotesParams(notes: event.notes));
      yield* _eitherFailureOrSuccess(list);
    } else if (event is ExpireChecker) {
      final list = expireChecker(ExpireCheckerParams(notes: event.notes));
      yield* _eitherFailureOrSuccess(list);
    } else if (event is DeleteEmptyNotes) {
      final list = deleteEmptyNotes(DeleteEmptyNotesParams(notes: event.notes));
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
    _timer?.cancel();
    _timer = Timer.periodic(
      Duration(seconds: 4),
      (timer) async {
        Box<dynamic> box = sl.get(instanceName: 'home_notes');
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
          add(GetHomeNotes());
        }
      },
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}

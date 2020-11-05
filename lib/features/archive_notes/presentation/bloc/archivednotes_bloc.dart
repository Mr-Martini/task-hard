import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

import '../../../../controllers/repeat-controller/repeat-controller.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../../dependency_container.dart';
import '../../../note/domain/entities/note.dart';
import '../../domain/entities/archive_notes.dart';
import '../../domain/usecases/archive_expire_checker.dart';
import '../../domain/usecases/get_archive_notes_usecase.dart';

part 'archivednotes_event.dart';
part 'archivednotes_state.dart';

class ArchivedNotesBloc extends Bloc<ArchivedNotesEvent, ArchivedNotesState> {
  final GetArchiveNotesUseCase getArchivedNotes;
  final ExpireCheckerArchiveUseCase expireChecker;
  ArchivedNotesBloc(
      {@required this.getArchivedNotes, @required this.expireChecker})
      : super(ArchivedNotesInitial());

  Timer _timer;

  @override
  Stream<ArchivedNotesState> mapEventToState(
    ArchivedNotesEvent event,
  ) async* {
    if (event is GetArchivedNotes) {
      _expireChecker();
      final notes = getArchivedNotes(NoParams());
      yield* _eitherLoadedOrError(notes);
    } else if (event is ExpireCheckerArchive) {
      final notes = expireChecker(ExpireCheckerArchiveParams(notes: event.notes));
      yield* _eitherLoadedOrError(notes);
    }
  }

  Stream<ArchivedNotesState> _eitherLoadedOrError(
      Either<Failure, ArchivedNotes> notes) async* {
    yield notes.fold(
      (failure) => Error(message: 'Something went wrong'),
      (archivedNotes) => Loaded(notes: archivedNotes.notes),
    );
  }

  void _expireChecker() {
    _timer?.cancel();
    _timer = Timer.periodic(
      Duration(seconds: 4),
      (timer) async {
        Box<dynamic> box = sl.get(instanceName: 'archive_notes');
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
          add(ExpireCheckerArchive(notes: filtered));
          add(GetArchivedNotes());
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

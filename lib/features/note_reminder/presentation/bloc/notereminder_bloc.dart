import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entity/note_reminder.dart';
import '../../domain/usecases/get_reminder_usecase.dart';

part 'notereminder_event.dart';
part 'notereminder_state.dart';

class NoteReminderBloc extends Bloc<NoteReminderEvent, NoteReminderState> {
  final GetNoteReminderUseCase getNoteReminder;
  NoteReminderBloc({
    @required this.getNoteReminder,
  }) : super(NoteReminderInitial());

  @override
  Stream<NoteReminderState> mapEventToState(
    NoteReminderEvent event,
  ) async* {
    if (event is GetNoteReminder) {
      final noteReminder =
          getNoteReminder(GetNoteReminderParams(noteKey: event.noteKey));
      yield* _eitherFailureOrSuccess(noteReminder);
    }
  }

  Stream<NoteReminderState> _eitherFailureOrSuccess(
      Either<Failure, NoteReminder> noteReminder) async* {
    yield noteReminder.fold(
      (failure) => Error(message: 'something went wrong'),
      (note) => Loaded(
        reminder: note.reminder,
        expired: note.expired,
        repeat: note.repeat,
      ),
    );
  }
}

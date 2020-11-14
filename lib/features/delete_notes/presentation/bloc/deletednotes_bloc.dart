import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../note/domain/entities/note.dart';
import '../../domain/entities/deleted_notes.dart';
import '../../domain/usecases/get_notes_usecase.dart';
import '../../domain/usecases/restore_notes_usecase.dart';

part 'deletednotes_event.dart';
part 'deletednotes_state.dart';

class DeletedNotesBloc extends Bloc<DeletedNotesEvent, DeletedNotesState> {
  final GetDeletedNotesUseCase getDeletedNotes;
  final RestoreNotesUseCase restoreNotes;
  DeletedNotesBloc({
    @required this.getDeletedNotes,
    @required this.restoreNotes,
  }) : super(DeletedNotesInitial());

  @override
  Stream<DeletedNotesState> mapEventToState(
    DeletedNotesEvent event,
  ) async* {
    if (event is GetDeletedNotes) {
      final notes = getDeletedNotes(NoParams());
      yield* _eitherLoadOrError(notes);
    } else if (event is RestoreNotes) {
      final notes = restoreNotes(RestoreNotesParams(notes: event.notes));
      yield* _eitherLoadOrError(notes);
    }
  }

  Stream<DeletedNotesState> _eitherLoadOrError(
      Either<Failure, DeletedNotes> notes) async* {
    yield notes.fold(
      (failure) => DeletedNotesError(message: 'Something went wrong'),
      (success) => DeletedNotesLoaded(notes: success.notes),
    );
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../note/domain/entities/note.dart';
import '../../domain/entities/archive_notes.dart';
import '../../domain/usecases/get_archive_notes_usecase.dart';

part 'archivednotes_event.dart';
part 'archivednotes_state.dart';

class ArchivedNotesBloc extends Bloc<ArchivedNotesEvent, ArchivedNotesState> {
  final GetArchiveNotesUseCase getArchivedNotes;
  ArchivedNotesBloc({@required this.getArchivedNotes}) : super(ArchivedNotesInitial());

  @override
  Stream<ArchivedNotesState> mapEventToState(
    ArchivedNotesEvent event,
  ) async* {
    if (event is GetArchivedNotes) {
      final notes = getArchivedNotes(NoParams());
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
}

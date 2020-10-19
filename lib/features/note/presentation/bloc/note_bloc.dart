import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/Utils/write_on.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/note.dart';
import '../../domain/usecases/archive_note_usecase.dart';
import '../../domain/usecases/copy_note_usecase.dart';
import '../../domain/usecases/delete_note.dart';
import '../../domain/usecases/delete_note_reminder_usecase.dart';
import '../../domain/usecases/get_note_by_key_usecase.dart';
import '../../domain/usecases/write_note_color_usecase.dart';
import '../../domain/usecases/write_note_content_usecase.dart';
import '../../domain/usecases/write_note_reminder_usecase.dart';
import '../../domain/usecases/write_note_title_usecase.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final GetNoteByKeyUseCase getNote;
  final WriteNoteContentUseCase writeContent;
  final WriteNoteTitletUseCase writeTitle;
  final WriteNoteColorUseCase writeColor;
  final WriteNoteReminderUseCase writeReminder;
  final DeleteNoteReminderUseCase deleteReminder;
  final DeleteNoteUseCase deleteNote;
  final ArchiveNoteUseCase archiveNote;
  final CopyNoteUseCase copyNote;

  NoteBloc({
    @required this.getNote,
    @required this.writeContent,
    @required this.writeTitle,
    @required this.writeColor,
    @required this.writeReminder,
    @required this.deleteReminder,
    @required this.deleteNote,
    @required this.archiveNote,
    @required this.copyNote,
  }) : super(NoteInitial());

  @override
  Stream<NoteState> mapEventToState(
    NoteEvent event,
  ) async* {
    if (event is GetNoteByKey) {
      yield Loading();
      final model = getNote(GetNoteByKeyParams(key: event.key, box: event.box));
      yield* _eitherFailureOrSuccess(model);
    } else if (event is WriteNoteContent) {
      String content = event.content;
      String key = event.key;
      final model = writeContent(
          WriteContentParams(content: content, key: key, box: event.box));
      yield* _eitherFailureOrSuccess(model);
    } else if (event is WriteNoteTitle) {
      String title = event.title;
      String key = event.key;
      final model =
          writeTitle(WriteTitleParams(title: title, key: key, box: event.box));
      yield* _eitherFailureOrSuccess(model);
    } else if (event is WriteNoteColor) {
      final Color color = event.color;
      final String key = event.key;
      final model = writeColor(
          WriteNoteColorParams(color: color, key: key, box: event.box));
      yield* _eitherFailureOrSuccess(model);
    } else if (event is WriteNoteReminder) {
      final DateTime reminder = event.reminder;
      final TimeOfDay time = event.time;
      final String repeat = event.repeat;
      final String key = event.key;
      final String title = event.title;
      final String message = event.message;
      final model = writeReminder(
        WriteNoteReminderParams(
          reminder: reminder,
          time: time,
          repeat: repeat,
          key: key,
          title: title,
          message: message,
          box: event.box,
        ),
      );
      yield* _eitherFailureOrSuccess(model);
    } else if (event is DeleteNoteReminder) {
      final model = deleteReminder(
          DeleteNoteReminderParams(key: event.key, box: event.box));
      yield* _eitherFailureOrSuccess(model);
    } else if (event is DeleteNote) {
      final model = deleteNote(DeleteNoteParams(key: event.key, box: event.box));
      yield* _eitherFailureOrSuccess(model);
    } else if (event is ArchiveNote) {
      final model = archiveNote(ArchiveNoteParams(key: event.key, box: event.box));
      yield* _eitherFailureOrSuccess(model);
    } else if (event is CopyNote) {
      final String key = event.key;
      final String title = event.title;
      final String content = event.content;
      final Color color = event.color;
      final WriteOn box = event.box;
      final model = copyNote(
        CopyNoteParams(
          key: key,
          title: title,
          content: content,
          color: color,
          box: box,
        ),
      );
      yield* _eitherFailureOrSuccess(model);
    }
  }

  Stream<NoteState> _eitherFailureOrSuccess(
      Either<Failure, Note> model) async* {
    yield model.fold(
      (failure) => Error(message: 'Something went wrong'),
      (note) => Loaded(note: note),
    );
  }
}

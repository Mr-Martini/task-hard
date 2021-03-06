import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:task_hard/core/Utils/write_on.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class WriteNoteReminderUseCase
    implements UseCases<Note, WriteNoteReminderParams> {
  final NoteRepository repository;

  WriteNoteReminderUseCase({@required this.repository});

  @override
  Either<Failure, Note> call(WriteNoteReminderParams params) {
    return repository.writeNoteReminder(
      params.reminder,
      params.time,
      params.repeat,
      params.key,
      params.title,
      params.message,
      params.box,
    );
  }
}

class WriteNoteReminderParams extends Equatable {
  final DateTime reminder;
  final TimeOfDay time;
  final String repeat;
  final String key;
  final String title;
  final String message;
  final WriteOn box;

  WriteNoteReminderParams({
    @required this.reminder,
    @required this.time,
    @required this.repeat,
    @required this.key,
    @required this.title,
    @required this.message,
    @required this.box,
  });

  @override
  List<Object> get props => [reminder, time, repeat, key, box];
}

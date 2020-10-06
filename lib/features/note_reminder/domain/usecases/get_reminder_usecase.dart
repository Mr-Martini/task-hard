import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entity/note_reminder.dart';
import '../repositories/note_reminder_repository.dart';

class GetNoteReminderUseCase
    implements UseCases<NoteReminder, GetNoteReminderParams> {
  final NoteReminderRepository repository;

  GetNoteReminderUseCase({@required this.repository});

  @override
  Either<Failure, NoteReminder> call(GetNoteReminderParams params) {
    return repository.getReminder(params.noteKey);
  }
}

class GetNoteReminderParams extends Equatable {
  final String noteKey;

  GetNoteReminderParams({@required this.noteKey});

  @override
  List<Object> get props => [noteKey];
}

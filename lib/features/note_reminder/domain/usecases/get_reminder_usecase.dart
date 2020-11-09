import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/Utils/write_on.dart';
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
    return repository.getReminder(params.noteKey, params.box);
  }
}

class GetNoteReminderParams extends Equatable {
  final String noteKey;
  final WriteOn box;

  GetNoteReminderParams({
    @required this.noteKey,
    @required this.box,
  });

  @override
  List<Object> get props => [noteKey, box];
}

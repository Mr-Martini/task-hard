import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/Utils/write_on.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class DeleteNoteReminderUseCase
    implements UseCases<Note, DeleteNoteReminderParams> {
  final NoteRepository repository;

  DeleteNoteReminderUseCase({@required this.repository});

  @override
  Either<Failure, Note> call(DeleteNoteReminderParams params) {
    return repository.deleteNoteReminder(params.key, params.box);
  }
}

class DeleteNoteReminderParams extends Equatable {
  final String key;
  final WriteOn box;

  DeleteNoteReminderParams({@required this.key, @required this.box});

  @override
  List<Object> get props => [key, box];
}

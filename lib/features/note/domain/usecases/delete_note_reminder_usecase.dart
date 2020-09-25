import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:meta/meta.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/note/domain/repositories/note_repository.dart';

class DeleteNoteReminderUseCase
    implements UseCases<Note, DeleteNoteReminderParams> {
  final NoteRepository repository;

  DeleteNoteReminderUseCase({@required this.repository});

  @override
  Either<Failure, Note> call(DeleteNoteReminderParams params) {
    return repository.deleteNoteReminder(params.key);
  }
}

class DeleteNoteReminderParams extends Equatable {
  final String key;

  DeleteNoteReminderParams({@required this.key});

  @override
  List<Object> get props => [key];
}

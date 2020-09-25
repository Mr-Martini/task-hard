import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:meta/meta.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/note/domain/repositories/note_repository.dart';

class DeleteNoteUseCase implements UseCases<Note, DeleteNoteParams> {
  final NoteRepository repository;

  DeleteNoteUseCase({@required this.repository});

  @override
  Either<Failure, Note> call(DeleteNoteParams params) {
    return repository.deleteNote(params.key);
  }
}

class DeleteNoteParams extends Equatable {
  final String key;

  DeleteNoteParams({@required this.key});

  @override
  List<Object> get props => [key];
}

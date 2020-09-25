import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:meta/meta.dart';
import 'package:task_hard/features/note/domain/repositories/note_repository.dart';

class GetNoteByKeyUseCase implements UseCases<Note, GetNoteByKeyParams> {
  final NoteRepository repository;

  GetNoteByKeyUseCase({@required this.repository});

  @override
  Either<Failure, Note> call(GetNoteByKeyParams params) {
    return repository.getNoteByKey(params.key);
  }
}

class GetNoteByKeyParams extends Equatable {
  final String key;

  GetNoteByKeyParams({@required this.key});

  @override
  List<Object> get props => [key];
}

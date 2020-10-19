import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:task_hard/core/Utils/write_on.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class DeleteNoteUseCase implements UseCases<Note, DeleteNoteParams> {
  final NoteRepository repository;

  DeleteNoteUseCase({@required this.repository});

  @override
  Either<Failure, Note> call(DeleteNoteParams params) {
    return repository.deleteNote(params.key, params.box);
  }
}

class DeleteNoteParams extends Equatable {
  final String key;
  final WriteOn box;

  DeleteNoteParams({@required this.key, @required this.box});

  @override
  List<Object> get props => [key];
}

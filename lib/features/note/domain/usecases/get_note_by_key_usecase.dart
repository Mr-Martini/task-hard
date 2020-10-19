import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:task_hard/core/Utils/write_on.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class GetNoteByKeyUseCase implements UseCases<Note, GetNoteByKeyParams> {
  final NoteRepository repository;

  GetNoteByKeyUseCase({@required this.repository});

  @override
  Either<Failure, Note> call(GetNoteByKeyParams params) {
    return repository.getNoteByKey(params.key, params.box);
  }
}

class GetNoteByKeyParams extends Equatable {
  final String key;
  final WriteOn box;

  GetNoteByKeyParams({@required this.key, @required this.box});

  @override
  List<Object> get props => [key, box];
}

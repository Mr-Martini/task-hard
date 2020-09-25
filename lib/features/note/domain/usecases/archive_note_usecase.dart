import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class ArchiveNoteUseCase implements UseCases<Note, ArchiveNoteParams> {
  final NoteRepository repository;

  ArchiveNoteUseCase({@required this.repository});

  @override
  Either<Failure, Note> call(ArchiveNoteParams params) {
    return repository.archiveNote(params.key);
  }
}

class ArchiveNoteParams extends Equatable {
  final String key;

  ArchiveNoteParams({@required this.key});

  @override
  List<Object> get props => [key];
}

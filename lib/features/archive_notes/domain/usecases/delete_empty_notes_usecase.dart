import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../note/domain/entities/note.dart';
import '../entities/archive_notes.dart';
import '../repositories/archive_notes_repository.dart';

class DeleteEmptyNotesArchiveUseCase
    implements UseCases<ArchivedNotes, DeleteEmptyNotesArchiveParams> {
  final ArchiveNotesRepository repository;

  DeleteEmptyNotesArchiveUseCase({@required this.repository});

  @override
  Either<Failure, ArchivedNotes> call(DeleteEmptyNotesArchiveParams params) {
    return repository.deleteEmptyNotes(params.notes);
  }
}

class DeleteEmptyNotesArchiveParams extends Equatable {
  final List<Note> notes;

  DeleteEmptyNotesArchiveParams({@required this.notes});

  @override
  List<Object> get props => [notes];
}

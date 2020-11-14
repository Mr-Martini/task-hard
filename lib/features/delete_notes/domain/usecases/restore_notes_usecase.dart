import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../note/domain/entities/note.dart';
import '../entities/deleted_notes.dart';
import '../repositories/deleted_notes_repository.dart';

class RestoreNotesUseCase
    implements UseCases<DeletedNotes, RestoreNotesParams> {

      final DeletedNotesRepository repository;

  RestoreNotesUseCase({@required this.repository});

  @override
  Either<Failure, DeletedNotes> call(RestoreNotesParams params) {
    return repository.restoreNotes(params.notes);
  }
}

class RestoreNotesParams extends Equatable {
  final List<Note> notes;

  RestoreNotesParams({@required this.notes});

  @override
  List<Object> get props => [notes];
}

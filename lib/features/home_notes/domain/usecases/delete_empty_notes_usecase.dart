import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../note/domain/entities/note.dart';
import '../entities/home_notes.dart';
import '../repositories/home_notes_repository.dart';

class DeleteEmptyNotesUseCase
    implements UseCases<HomeNotes, DeleteEmptyNotesParams> {

      final HomeNotesRepository repository;

  DeleteEmptyNotesUseCase({@required this.repository});

  @override
  Either<Failure, HomeNotes> call(DeleteEmptyNotesParams params) {
    return repository.deleteEmptyNotes(params.notes);
  }
}

class DeleteEmptyNotesParams extends Equatable {
  final Iterable<Note> notes;

  DeleteEmptyNotesParams({@required this.notes});

  @override
  List<Object> get props => [notes];
}

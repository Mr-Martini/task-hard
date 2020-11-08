import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/deleted_notes.dart';
import '../repositories/deleted_notes_repository.dart';

class GetDeletedNotesUseCase implements UseCases<DeletedNotes, NoParams> {

  final DeletedNotesRepository repository;

  GetDeletedNotesUseCase({@required this.repository});

  @override
  Either<Failure, DeletedNotes> call(NoParams params) {
    return repository.getNotes();
  }

}

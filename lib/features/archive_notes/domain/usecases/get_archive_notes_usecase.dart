import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/archive_notes.dart';
import '../repositories/archive_notes_repository.dart';
class GetArchiveNotesUseCase implements UseCases<ArchivedNotes, NoParams> {

  final ArchiveNotesRepository repository;

  GetArchiveNotesUseCase({@required this.repository});

  @override
  Either<Failure, ArchivedNotes> call(NoParams params) {
    return repository.getArchiveNotes();
  }
  
}
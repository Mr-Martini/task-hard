import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/archive_notes.dart';
import '../repositories/archive_notes_repository.dart';

class ExpireCheckerArchiveUseCase
    extends UseCases<ArchivedNotes, ExpireCheckerArchiveParams> {
  final ArchiveNotesRepository repository;

  ExpireCheckerArchiveUseCase({@required this.repository});

  @override
  Either<Failure, ArchivedNotes> call(ExpireCheckerArchiveParams params) {
    return repository.expireCheckerArchive(params.notes);
  }
}

class ExpireCheckerArchiveParams extends Equatable {
  final Iterable<dynamic> notes;

  ExpireCheckerArchiveParams({@required this.notes});

  @override
  List<Object> get props => [notes];
}

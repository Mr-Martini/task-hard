import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/archive_notes.dart';
import '../../domain/repositories/archive_notes_repository.dart';
import '../datasources/archive_notes_local_data_source.dart';

class ArchivedNotesRepositoryImpl implements ArchiveNotesRepository {

  final ArchivedNotesLocalDataSource dataSource;

  ArchivedNotesRepositoryImpl({@required this.dataSource});

  @override
  Either<Failure, ArchivedNotes> getArchiveNotes() {
    try {
      final notes = dataSource.getArchivedNotes();
      return Right(notes);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, ArchivedNotes> expireCheckerArchive(Iterable<dynamic> iterable) {
    try {
      final notes = dataSource.expireCheckerArchive(iterable);
      return Right(notes);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
  
}
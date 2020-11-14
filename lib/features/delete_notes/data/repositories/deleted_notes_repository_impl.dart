import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../note/domain/entities/note.dart';
import '../../domain/entities/deleted_notes.dart';
import '../../domain/repositories/deleted_notes_repository.dart';
import '../datasources/deleted_notes_local_data_source.dart';

class DeletedNotesRepositoryImpl implements DeletedNotesRepository {
  final DeletedNotesLocalDataSource dataSource;

  DeletedNotesRepositoryImpl({@required this.dataSource});

  @override
  Either<Failure, DeletedNotes> getNotes() {
    try {
      final notes = dataSource.getNotes();
      return Right(notes);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, DeletedNotes> restoreNotes(List<Note> notes) {
    try {
      final list = dataSource.restoreNotes(notes);
      return Right(list);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}

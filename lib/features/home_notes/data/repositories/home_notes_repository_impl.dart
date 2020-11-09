import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../note/domain/entities/note.dart';
import '../../domain/entities/home_notes.dart';
import '../../domain/repositories/home_notes_repository.dart';
import '../datasources/home_notes.datasource.dart';

class HomeNotesRepositoryImpl implements HomeNotesRepository {
  final HomeNotesDataSource dataSource;

  HomeNotesRepositoryImpl({@required this.dataSource});

  @override
  Either<Failure, HomeNotes> getNotes() {
    try {
      final list = dataSource.getNotes();
      return Right(list);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, HomeNotes> listen(Iterable notes) {
    try {
      final list = dataSource.listen(notes);
      return Right(list);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, HomeNotes> expireChecker(Iterable notes) {
    try {
      final list = dataSource.expireChecker(notes);
      return Right(list);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, HomeNotes> deleteEmptyNotes(Iterable<Note> notes) {
    try {
      final list = dataSource.deleteEmptyNotes(notes);
      return Right(list);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }
}

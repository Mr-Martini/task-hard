import 'package:dartz/dartz.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/features/home_notes/data/datasources/home_notes.datasource.dart';
import 'package:task_hard/features/home_notes/domain/entities/home_notes.dart';
import 'package:task_hard/features/home_notes/domain/repositories/home_notes_repository.dart';
import 'package:meta/meta.dart';

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
}

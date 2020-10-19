import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/taged_notes_home.dart';
import '../../domain/repositories/taged_notes_home_repository.dart';
import '../datasources/taged_notes_home_local_data_source.dart';

class TagedNotesHomeRepositoryImpl implements TagedNotesHomeRepository {
  final TagedNotesHomeLocalDataSource localDataSource;

  TagedNotesHomeRepositoryImpl(this.localDataSource);

  @override
  Either<Failure, TagedNotesHome> getPreference() {
    try {
      final preference = localDataSource.getPreference();
      return Right(preference);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, TagedNotesHome> setPrefence(bool should) {
    try {
      final preference = localDataSource.setPreference(should);
      return Right(preference);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}

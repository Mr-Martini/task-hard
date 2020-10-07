import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/tags.dart';
import '../../domain/repositories/tags_repository.dart';
import '../datasources/tags_local_data_source.dart';

class TagsRepositoryImpl implements TagsRepository {
  final TagsLocalDataSouce dataSource;

  TagsRepositoryImpl({@required this.dataSource});

  @override
  Either<Failure, TagsEntity> getTags(String noteKey) {
    try {
      final tagEntity = dataSource.getTags(noteKey);
      return Right(tagEntity);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, TagsEntity> addTagOnNote(String noteKey, String tagName) {
    try {
      final tagEntity = dataSource.addTagOnNote(noteKey, tagName);
      return Right(tagEntity);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, TagsEntity> removeTagFromNote(
      String noteKey, String tagName) {
    try {
      final tagEntity = dataSource.removeTagFronNote(noteKey, tagName);
      return Right(tagEntity);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, TagsEntity> getOnlyTags() {
    try {
      final tagEntity = dataSource.getOnlyTags();
      return Right(tagEntity);
    } catch (e) {
      print(e);
      return Left(CacheFailure());
    }
  }
}

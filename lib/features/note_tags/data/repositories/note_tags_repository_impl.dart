import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/Utils/write_on.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/note_tags.dart';
import '../../domain/repositories/note_tags_repository.dart';
import '../datasources/note_tags_local_data_source.dart';

class NoteTagsRepositoryImpl implements NoteTagsRepository {
  final NoteTagsLocalDataSource dataSource;

  NoteTagsRepositoryImpl({@required this.dataSource});

  @override
  Either<Failure, NoteTagsEntity> getTags(String noteKey, WriteOn box) {
    try {
      final tags = dataSource.getNoteTags(noteKey, box);
      return Right(tags);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}

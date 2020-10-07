import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/tags.dart';

abstract class TagsRepository {
  Either<Failure, TagsEntity> getTags(String noteKey);
  Either<Failure, TagsEntity> getOnlyTags();
  Either<Failure, TagsEntity> addTagOnNote(String noteKey, String tagName);
  Either<Failure, TagsEntity> removeTagFromNote(String noteKey, String tagName);
}

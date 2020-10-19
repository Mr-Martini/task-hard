import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../note/domain/entities/note.dart';
import '../entities/tags.dart';

abstract class TagsRepository {
  Either<Failure, TagsEntity> getTags(String noteKey);
  Either<Failure, TagsEntity> getOnlyTags();
  Either<Failure, TagsEntity> getTagsForList(List<Note> notes);
  Either<Failure, TagsEntity> addTagOnNote(String noteKey, String tagName);
  Either<Failure, TagsEntity> addTagOnList(List<Note> notes, String tagName);
  Either<Failure, TagsEntity> removeTagFromNote(String noteKey, String tagName);
  Either<Failure, TagsEntity> removeTagFromList(List<Note> notes, String tagName);
}

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/note_tags.dart';

abstract class NoteTagsRepository {
  Either<Failure, NoteTagsEntity> getTags(String noteKey);
}

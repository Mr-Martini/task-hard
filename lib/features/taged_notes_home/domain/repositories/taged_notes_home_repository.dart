import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/taged_notes_home.dart';

abstract class TagedNotesHomeRepository {
  Either<Failure, TagedNotesHome> getPreference();
  Either<Failure, TagedNotesHome> setPrefence(bool should);
}

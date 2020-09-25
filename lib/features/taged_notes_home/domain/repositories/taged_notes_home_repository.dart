import 'package:dartz/dartz.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/features/taged_notes_home/domain/entities/taged_notes_home.dart';

abstract class TagedNotesHomeRepository {
  Either<Failure, TagedNotesHome> getPreference();
  Either<Failure, TagedNotesHome> setPrefence(bool should);
}

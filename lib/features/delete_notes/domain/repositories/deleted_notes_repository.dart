import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/deleted_notes.dart';

abstract class DeletedNotesRepository {
  Either<Failure, DeletedNotes> getNotes();
}
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/archive_notes.dart';

abstract class ArchiveNotesRepository {
  Either<Failure, ArchivedNotes> getArchiveNotes();
}
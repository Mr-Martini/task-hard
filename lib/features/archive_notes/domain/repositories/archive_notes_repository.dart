import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../note/domain/entities/note.dart';
import '../entities/archive_notes.dart';

abstract class ArchiveNotesRepository {
  Either<Failure, ArchivedNotes> getArchiveNotes();
  Either<Failure, ArchivedNotes> expireCheckerArchive(Iterable<dynamic> notes);
  Either<Failure, ArchivedNotes> deleteEmptyNotes(List<Note> notes);
}
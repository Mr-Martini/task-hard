import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../note/domain/entities/note.dart';
import '../entities/deleted_notes.dart';

abstract class DeletedNotesRepository {
  Either<Failure, DeletedNotes> getNotes();
  Either<Failure, DeletedNotes> restoreNotes(List<Note> notes);
}
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../note/domain/entities/note.dart';
import '../entities/home_notes.dart';

abstract class HomeNotesRepository {
  Either<Failure, HomeNotes> getNotes();
  Either<Failure, HomeNotes> listen(Iterable<dynamic> notes);
  Either<Failure, HomeNotes> expireChecker(Iterable<dynamic> notes);
  Either<Failure, HomeNotes> deleteEmptyNotes(Iterable<Note> notes);
}

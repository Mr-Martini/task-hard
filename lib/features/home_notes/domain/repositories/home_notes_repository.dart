import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/home_notes.dart';

abstract class HomeNotesRepository {
  Either<Failure, HomeNotes> getNotes();
  Either<Failure, HomeNotes> listen(Iterable<dynamic> notes);
}

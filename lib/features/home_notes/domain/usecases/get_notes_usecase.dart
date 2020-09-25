import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/home_notes.dart';
import '../repositories/home_notes_repository.dart';

class GetNotesUseCase implements UseCases<HomeNotes, NoParams> {
  final HomeNotesRepository repository;

  GetNotesUseCase({@required this.repository});

  @override
  Either<Failure, HomeNotes> call(NoParams params) {
    return repository.getNotes();
  }
}

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/taged_notes_home.dart';
import '../repositories/taged_notes_home_repository.dart';

class GetTagedNotesHomePreference
    implements UseCases<TagedNotesHome, NoParams> {
  final TagedNotesHomeRepository repository;

  GetTagedNotesHomePreference(this.repository);

  @override
  Either<Failure, TagedNotesHome> call(NoParams noParams) {
    return repository.getPreference();
  }
}

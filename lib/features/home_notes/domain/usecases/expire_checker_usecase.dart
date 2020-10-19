import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/home_notes.dart';
import '../repositories/home_notes_repository.dart';

class ExpireCheckerUseCase implements UseCases<HomeNotes, ExpireCheckerParams> {
  final HomeNotesRepository repository;

  ExpireCheckerUseCase({@required this.repository});

  @override
  Either<Failure, HomeNotes> call(ExpireCheckerParams params) {
    return repository.expireChecker(params.notes);
  }
}

class ExpireCheckerParams extends Equatable {
  final Iterable<dynamic> notes;

  ExpireCheckerParams({@required this.notes});

  @override
  List<Object> get props => [notes];
}

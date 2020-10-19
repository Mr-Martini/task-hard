import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/taged_notes_home.dart';
import '../repositories/taged_notes_home_repository.dart';

class SetTagedNotesPreference implements UseCases<TagedNotesHome, Params> {
  final TagedNotesHomeRepository repository;

  SetTagedNotesPreference(this.repository);

  @override
  Either<Failure, TagedNotesHome> call(Params params) {
    return repository.setPrefence(params.should);
  }
}

class Params extends Equatable {
  final bool should;

  Params({@required this.should});

  @override
  List<Object> get props => [should];
}

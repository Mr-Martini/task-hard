import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:task_hard/features/taged_notes_home/domain/entities/taged_notes_home.dart';
import 'package:task_hard/features/taged_notes_home/domain/repositories/taged_notes_home_repository.dart';
import 'package:meta/meta.dart';

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

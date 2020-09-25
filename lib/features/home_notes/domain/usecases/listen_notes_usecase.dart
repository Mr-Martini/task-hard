import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/home_notes.dart';
import '../repositories/home_notes_repository.dart';

class ListenNotesUseCase implements UseCases<HomeNotes, ListenNotesParams> {
  final HomeNotesRepository repository;

  ListenNotesUseCase({@required this.repository});

  @override
  Either<Failure, HomeNotes> call(ListenNotesParams params) {
    return repository.listen(params.notes);
  }
}

class ListenNotesParams extends Equatable {
  final Iterable<dynamic> notes;

  ListenNotesParams({@required this.notes});

  @override
  List<Object> get props => [notes];
}

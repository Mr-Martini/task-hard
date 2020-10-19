import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../note/domain/entities/note.dart';
import '../entities/home_app_bar_entity.dart';
import '../repositories/home_app_bar_repository.dart';

class AddNoteUseCase implements UseCases<HomeAppBarEntity, AddNoteParams> {
  final HomeAppBarRepository repository;

  AddNoteUseCase({@required this.repository});

  @override
  Either<Failure, HomeAppBarEntity> call(AddNoteParams params) {
    return repository.addNote(params.notes);
  }
}

class AddNoteParams extends Equatable {
  final List<Note> notes;

  AddNoteParams({@required this.notes});

  @override
  List<Object> get props => [notes];
}

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../note/domain/entities/note.dart';
import '../entities/home_app_bar_entity.dart';
import '../repositories/home_app_bar_repository.dart';

class DeleteNotesAppBarUseCase
    implements UseCases<HomeAppBarEntity, DeleteNoteAppBarParams> {
  final HomeAppBarRepository repository;

  DeleteNotesAppBarUseCase({@required this.repository});

  @override
  Either<Failure, HomeAppBarEntity> call(DeleteNoteAppBarParams params) {
    return repository.deleteNotes(params.notes);
  }
}

class DeleteNoteAppBarParams extends Equatable {
  final List<Note> notes;

  DeleteNoteAppBarParams({@required this.notes});

  @override
  List<Object> get props => [notes];
}

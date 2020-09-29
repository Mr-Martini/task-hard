import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../note/domain/entities/note.dart';
import '../entities/home_app_bar_entity.dart';
import '../repositories/home_app_bar_repository.dart';

class UndoDeleteNotesAppBarUseCase
    implements UseCases<HomeAppBarEntity, UndoDeleteNotesAppBarParams> {
  final HomeAppBarRepository repository;

  UndoDeleteNotesAppBarUseCase({@required this.repository});

  @override
  Either<Failure, HomeAppBarEntity> call(UndoDeleteNotesAppBarParams params) {
    return repository.undoDelete(params.selectedNotes);
  }
}

class UndoDeleteNotesAppBarParams extends Equatable {
  final List<Note> selectedNotes;

  UndoDeleteNotesAppBarParams({@required this.selectedNotes});

  @override
  List<Object> get props => [selectedNotes];
}

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../note/domain/entities/note.dart';
import '../entities/home_app_bar_entity.dart';
import '../repositories/home_app_bar_repository.dart';

class DeleteAppBarNoteReminderUseCase
    implements UseCases<HomeAppBarEntity, DeleteAppBarNoteReminderParams> {
  final HomeAppBarRepository repository;

  DeleteAppBarNoteReminderUseCase({@required this.repository});

  @override
  Either<Failure, HomeAppBarEntity> call(
      DeleteAppBarNoteReminderParams params) {
    return repository.deleteReminder(params.selectedNotes);
  }
}

class DeleteAppBarNoteReminderParams extends Equatable {
  final List<Note> selectedNotes;

  DeleteAppBarNoteReminderParams({@required this.selectedNotes});

  @override
  List<Object> get props => [selectedNotes];
}

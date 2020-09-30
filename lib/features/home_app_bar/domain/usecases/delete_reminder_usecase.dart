import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:task_hard/features/home_app_bar/domain/entities/home_app_bar_entity.dart';
import 'package:task_hard/features/home_app_bar/domain/repositories/home_app_bar_repository.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:meta/meta.dart';

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

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/features/home_app_bar/domain/entities/home_app_bar_entity.dart';
import 'package:task_hard/features/home_app_bar/domain/usecases/add_note_usecase.dart';
import 'package:task_hard/features/home_app_bar/domain/usecases/change_color_usecase.dart';
import 'package:task_hard/features/home_app_bar/domain/usecases/delete_notes_usecase.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

part 'homeappbar_event.dart';
part 'homeappbar_state.dart';

class HomeappbarBloc extends Bloc<HomeappbarEvent, HomeappbarState> {
  final AddNoteUseCase addNote;
  final ChangeColorUseCase changeColor;
  final DeleteNotesAppBarUseCase deleteNotes;

  HomeappbarBloc({
    @required this.addNote,
    @required this.changeColor,
    @required this.deleteNotes,
  }) : super(HomeappbarInitial());

  @override
  Stream<HomeappbarState> mapEventToState(
    HomeappbarEvent event,
  ) async* {
    if (event is AddNote) {
      final list = addNote(AddNoteParams(notes: event.selectedNotes));
      yield* _eitherFailureOrSuccess(list);
    } else if (event is ChangeColor) {
      final list = changeColor(
        ChangeColorParams(
          notes: event.selectedNotes,
          color: event.color,
        ),
      );
      yield* _eitherFailureOrSuccess(list);
    } else if (event is DeleteNotes) {
      final list = deleteNotes(
        DeleteNoteAppBarParams(
          notes: event.selectedNotes,
        ),
      );
      yield* _eitherFailureOrSuccess(list);
    }
  }

  Stream<HomeappbarState> _eitherFailureOrSuccess(
      Either<Failure, HomeAppBarEntity> list) async* {
    yield list.fold(
      (failure) => Error(message: 'Something went wrong'),
      (selectedNotes) => Loaded(selectedNotes: selectedNotes),
    );
  }
}

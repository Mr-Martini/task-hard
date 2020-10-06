import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/note_tags.dart';
import '../../domain/usecases/get_tags_usecase.dart';

part 'notetags_event.dart';
part 'notetags_state.dart';

class NoteTagsBloc extends Bloc<NoteTagsEvent, NoteTagsState> {
  final GetNoteTagsUseCase getNoteTags;

  NoteTagsBloc({@required this.getNoteTags}) : super(NoteTagsInitial());

  @override
  Stream<NoteTagsState> mapEventToState(
    NoteTagsEvent event,
  ) async* {
    if (event is GetTags) {
      final tags = getNoteTags(GetNoteTagsParams(noteKey: event.noteKey));
      yield* _eitherLoadOrError(tags);
    }
  }

  Stream<NoteTagsState> _eitherLoadOrError(
      Either<Failure, NoteTagsEntity> tags) async* {
    yield tags.fold(
      (failure) => Error(message: 'Something went wrong'),
      (state) => Loaded(tags: state.tags),
    );
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../domain/entities/tags.dart';
import '../../domain/usecases/add_tag_on_note.dart';
import '../../domain/usecases/get_only_tags_usecase.dart';
import '../../domain/usecases/get_tags_usecase.dart';
import '../../domain/usecases/remove_tag_from_note_usecase.dart';

part 'tags_event.dart';
part 'tags_state.dart';

class TagsBloc extends Bloc<TagsEvent, TagsState> {
  final GetTagsUseCase getTags;
  final GetOnlyTagsUseCases getOnlyTags;
  final AddTagOnNoteUseCase addTagOnNote;
  final RemoveTagFromNoteUseCase removeTagFromNote;
  TagsBloc({
    @required this.getTags,
    @required this.getOnlyTags,
    @required this.addTagOnNote,
    @required this.removeTagFromNote,
  }) : super(TagsInitial());

  @override
  Stream<TagsState> mapEventToState(
    TagsEvent event,
  ) async* {
    if (event is GetTags) {
      final tags = getTags(GetTagsParams(noteKey: event.noteKey));
      yield* _eitherLoadOrError(tags);
    } else if (event is AddTagOnNote) {
      final tagEntity = addTagOnNote(
        AddTagOnNoteParams(
          tagName: event.tagName,
          noteKey: event.noteKey,
        ),
      );
      yield* _eitherLoadOrError(tagEntity);
    } else if (event is RemoveTagFromNote) {
      final tagEntity = removeTagFromNote(
        RemoveTagFromNoteParams(
          noteKey: event.noteKey,
          tagName: event.tagName,
        ),
      );
      yield* _eitherLoadOrError(tagEntity);
    } else if (event is GetOnlyTags) {
      final tagEntity = getOnlyTags(NoParams());
      yield* _eitherLoadOrError(tagEntity);
    }
  }

  Stream<TagsState> _eitherLoadOrError(
      Either<Failure, TagsEntity> tags) async* {
    yield tags.fold(
      (failure) => Error(message: 'something went wrong'),
      (tags) => Loaded(
        tags: tags.tags,
        noteTags: tags.noteTags,
      ),
    );
  }
}

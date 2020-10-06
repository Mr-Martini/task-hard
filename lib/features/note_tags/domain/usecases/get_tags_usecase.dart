import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/note_tags.dart';
import '../repositories/note_tags_repository.dart';

class GetNoteTagsUseCase
    implements UseCases<NoteTagsEntity, GetNoteTagsParams> {
  final NoteTagsRepository repository;

  GetNoteTagsUseCase({@required this.repository});

  @override
  Either<Failure, NoteTagsEntity> call(GetNoteTagsParams params) {
    return repository.getTags(params.noteKey);
  }
}

class GetNoteTagsParams extends Equatable {
  final String noteKey;

  GetNoteTagsParams({@required this.noteKey});

  @override
  List<Object> get props => [noteKey];
}

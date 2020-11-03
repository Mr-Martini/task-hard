import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:task_hard/core/Utils/write_on.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/tags.dart';
import '../repositories/tags_repository.dart';

class RemoveTagFromNoteUseCase
    implements UseCases<TagsEntity, RemoveTagFromNoteParams> {
  final TagsRepository repository;

  RemoveTagFromNoteUseCase({@required this.repository});

  @override
  Either<Failure, TagsEntity> call(RemoveTagFromNoteParams params) {
    return repository.removeTagFromNote(params.noteKey, params.tagName, params.box);
  }
}

class RemoveTagFromNoteParams extends Equatable {
  final String noteKey;
  final String tagName;
  final WriteOn box;

  RemoveTagFromNoteParams({
    @required this.noteKey,
    @required this.tagName,
    @required this.box,
  });

  @override
  List<Object> get props => [noteKey, tagName, box];
}

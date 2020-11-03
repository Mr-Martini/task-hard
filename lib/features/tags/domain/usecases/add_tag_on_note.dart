import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:task_hard/core/Utils/write_on.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/tags.dart';
import '../repositories/tags_repository.dart';

class AddTagOnNoteUseCase implements UseCases<TagsEntity, AddTagOnNoteParams> {
  final TagsRepository repository;

  AddTagOnNoteUseCase({@required this.repository});

  @override
  Either<Failure, TagsEntity> call(AddTagOnNoteParams params) {
    return repository.addTagOnNote(params.noteKey, params.tagName, params.box);
  }
}

class AddTagOnNoteParams extends Equatable {
  final String tagName;
  final String noteKey;
  final WriteOn box;

  AddTagOnNoteParams({
    @required this.tagName,
    @required this.noteKey,
    @required this.box,
  });

  @override
  List<Object> get props => [tagName, noteKey, box];
}

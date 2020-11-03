import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:task_hard/core/Utils/write_on.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../note/domain/entities/note.dart';
import '../entities/tags.dart';
import '../repositories/tags_repository.dart';

class RemoveTagFromListUseCase
    implements UseCases<TagsEntity, RemoveTagFromListParams> {
  final TagsRepository repository;

  RemoveTagFromListUseCase({@required this.repository});

  @override
  Either<Failure, TagsEntity> call(RemoveTagFromListParams params) {
    return repository.removeTagFromList(params.notes, params.tagName, params.box);
  }
}

class RemoveTagFromListParams extends Equatable {
  final List<Note> notes;
  final String tagName;
  final WriteOn box;

  RemoveTagFromListParams({
    @required this.notes,
    @required this.tagName,
    @required this.box,
  });

  @override
  List<Object> get props => [notes, tagName, box];
}

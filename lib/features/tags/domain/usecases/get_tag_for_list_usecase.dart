import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:task_hard/core/Utils/write_on.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../note/domain/entities/note.dart';
import '../entities/tags.dart';
import '../repositories/tags_repository.dart';

class GetTagForListUseCase
    implements UseCases<TagsEntity, GetTagForListParams> {
  final TagsRepository repository;

  GetTagForListUseCase({@required this.repository});

  @override
  Either<Failure, TagsEntity> call(GetTagForListParams params) {
    return repository.getTagsForList(params.notes, params.box);
  }
}

class GetTagForListParams extends Equatable {
  final List<Note> notes;
  final WriteOn box;

  GetTagForListParams({@required this.notes, @required this.box,});

  @override
  List<Object> get props => [notes, box];
}

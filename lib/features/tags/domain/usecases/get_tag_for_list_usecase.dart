import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
    return repository.getTagsForList(params.notes);
  }
}

class GetTagForListParams extends Equatable {
  final List<Note> notes;

  GetTagForListParams({@required this.notes});

  @override
  List<Object> get props => [notes];
}

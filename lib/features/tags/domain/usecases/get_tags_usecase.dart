import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:task_hard/core/Utils/write_on.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/tags.dart';
import '../repositories/tags_repository.dart';

class GetTagsUseCase implements UseCases<TagsEntity, GetTagsParams> {
  final TagsRepository repository;

  GetTagsUseCase({@required this.repository});

  @override
  Either<Failure, TagsEntity> call(GetTagsParams params) {
    return repository.getTags(params.noteKey, params.box);
  }
}

class GetTagsParams extends Equatable {
  final String noteKey;
  final WriteOn box;

  GetTagsParams({@required this.noteKey, @required this.box});

  @override
  List<Object> get props => [noteKey, box];
}

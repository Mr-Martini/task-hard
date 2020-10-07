import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/tags.dart';
import '../repositories/tags_repository.dart';

class GetTagsUseCase implements UseCases<TagsEntity, GetTagsParams> {
  final TagsRepository repository;

  GetTagsUseCase({@required this.repository});

  @override
  Either<Failure, TagsEntity> call(GetTagsParams params) {
    return repository.getTags(params.noteKey);
  }
}

class GetTagsParams extends Equatable {
  final String noteKey;

  GetTagsParams({@required this.noteKey});

  @override
  List<Object> get props => [noteKey];
}

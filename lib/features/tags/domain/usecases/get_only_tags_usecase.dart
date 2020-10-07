import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/tags.dart';
import '../repositories/tags_repository.dart';

class GetOnlyTagsUseCases implements UseCases<TagsEntity, NoParams> {
  final TagsRepository repository;

  GetOnlyTagsUseCases({@required this.repository});

  @override
  Either<Failure, TagsEntity> call(NoParams params) {
    return repository.getOnlyTags();
  }
}

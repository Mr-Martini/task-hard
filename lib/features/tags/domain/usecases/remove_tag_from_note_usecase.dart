import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

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
    return repository.removeTagFromNote(params.noteKey, params.tagName);
  }
}

class RemoveTagFromNoteParams extends Equatable {
  final String noteKey;
  final String tagName;

  RemoveTagFromNoteParams({@required this.noteKey, @required this.tagName});

  @override
  List<Object> get props => [noteKey, tagName];
}

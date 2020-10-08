import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../../../note/domain/entities/note.dart';
import '../entities/tags.dart';
import '../repositories/tags_repository.dart';

class AddTagOnListUseCase implements UseCases<TagsEntity, AddTagOnListParams> {
  final TagsRepository repository;

  AddTagOnListUseCase({@required this.repository});

  @override
  Either<Failure, TagsEntity> call(AddTagOnListParams params) {
    return repository.addTagOnList(params.notes, params.tagName);
  }
}

class AddTagOnListParams extends Equatable {
  final List<Note> notes;
  final String tagName;

  AddTagOnListParams({@required this.notes, @required this.tagName});

  @override
  List<Object> get props => [notes, tagName];
}

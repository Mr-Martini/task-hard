import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_hard/core/Utils/write_on.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class CopyNoteUseCase implements UseCases<Note, CopyNoteParams> {
  final NoteRepository repository;

  CopyNoteUseCase({@required this.repository});

  @override
  Either<Failure, Note> call(CopyNoteParams params) {
    return repository.copyNote(
      params.key,
      params.title,
      params.content,
      params.color,
      params.box,
    );
  }
}

class CopyNoteParams extends Equatable {
  final String key;
  final String title;
  final String content;
  final Color color;
  final WriteOn box;

  CopyNoteParams({
    @required this.key,
    @required this.title,
    @required this.content,
    @required this.color,
    @required this.box,
  });

  @override
  List<Object> get props => [key, title, content, color, box];
}

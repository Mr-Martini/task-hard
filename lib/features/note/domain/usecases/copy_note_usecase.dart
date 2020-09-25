import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/note/domain/repositories/note_repository.dart';

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
    );
  }
}

class CopyNoteParams extends Equatable {
  final String key;
  final String title;
  final String content;
  final Color color;

  CopyNoteParams({
    @required this.key,
    @required this.title,
    @required this.content,
    @required this.color,
  });

  @override
  List<Object> get props => [key, title, content, color];
}

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/note/domain/repositories/note_repository.dart';

class WriteNoteColorUseCase implements UseCases<Note, WriteNoteColorParams> {
  final NoteRepository repository;

  WriteNoteColorUseCase({@required this.repository});

  @override
  Either<Failure, Note> call(WriteNoteColorParams params) {
    return repository.writeNoteColor(params.color, params.key);
  }
}

class WriteNoteColorParams extends Equatable {
  final Color color;
  final String key;

  WriteNoteColorParams({@required this.color, @required this.key});

  @override
  List<Object> get props => [color, key];
}

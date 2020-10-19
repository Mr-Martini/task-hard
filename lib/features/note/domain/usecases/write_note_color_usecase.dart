import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/Utils/write_on.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class WriteNoteColorUseCase implements UseCases<Note, WriteNoteColorParams> {
  final NoteRepository repository;

  WriteNoteColorUseCase({@required this.repository});

  @override
  Either<Failure, Note> call(WriteNoteColorParams params) {
    return repository.writeNoteColor(params.color, params.key, params.box);
  }
}

class WriteNoteColorParams extends Equatable {
  final Color color;
  final String key;
  final WriteOn box;

  WriteNoteColorParams({@required this.color, @required this.key, @required this.box});

  @override
  List<Object> get props => [color, key, box];
}

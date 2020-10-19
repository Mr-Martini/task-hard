import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/Utils/write_on.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class WriteNoteContentUseCase implements UseCases<Note, WriteContentParams> {
  final NoteRepository repository;

  WriteNoteContentUseCase({@required this.repository});

  @override
  Either<Failure, Note> call(WriteContentParams params) {
    return repository.writeNoteContent(params.content, params.key, params.box);
  }
}

class WriteContentParams extends Equatable {
  final String content;
  final String key;
  final WriteOn box;

  WriteContentParams({@required this.content, @required this.key, @required this.box,});

  @override
  List<Object> get props => [content, key, box];
}

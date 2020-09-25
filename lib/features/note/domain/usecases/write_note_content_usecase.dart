import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:meta/meta.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/note/domain/repositories/note_repository.dart';

class WriteNoteContentUseCase implements UseCases<Note, WriteContentParams> {
  final NoteRepository repository;

  WriteNoteContentUseCase({@required this.repository});

  @override
  Either<Failure, Note> call(WriteContentParams params) {
    return repository.writeNoteContent(params.content, params.key);
  }
}

class WriteContentParams extends Equatable {
  final String content;
  final String key;

  WriteContentParams({@required this.content, @required this.key});

  @override
  List<Object> get props => [content, key];
}

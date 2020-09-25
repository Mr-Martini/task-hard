import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_hard/core/error/failures.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:meta/meta.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/note/domain/repositories/note_repository.dart';

class WriteNoteTitletUseCase implements UseCases<Note, WriteTitleParams> {
  final NoteRepository repository;

  WriteNoteTitletUseCase({@required this.repository});

  @override
  Either<Failure, Note> call(WriteTitleParams params) {
    return repository.writeNoteTitle(params.title, params.key);
  }
}

class WriteTitleParams extends Equatable {
  final String title;
  final String key;

  WriteTitleParams({@required this.title, @required this.key});

  @override
  List<Object> get props => [title, key];
}

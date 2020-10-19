import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/Utils/write_on.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/note.dart';
import '../repositories/note_repository.dart';

class WriteNoteTitletUseCase implements UseCases<Note, WriteTitleParams> {
  final NoteRepository repository;

  WriteNoteTitletUseCase({@required this.repository});

  @override
  Either<Failure, Note> call(WriteTitleParams params) {
    return repository.writeNoteTitle(params.title, params.key, params.box);
  }
}

class WriteTitleParams extends Equatable {
  final String title;
  final String key;
  final WriteOn box;

  WriteTitleParams({@required this.title, @required this.key, @required this.box,});

  @override
  List<Object> get props => [title, key, box];
}

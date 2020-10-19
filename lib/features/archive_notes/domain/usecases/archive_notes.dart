import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../note/domain/entities/note.dart';

class ArchiveNotes extends Equatable {
  final List<Note> notes;

  ArchiveNotes({@required this.notes});

  @override
  List<Object> get props => [notes];
}
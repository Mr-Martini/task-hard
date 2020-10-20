import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../note/domain/entities/note.dart';

class ArchivedNotes extends Equatable {
  final List<Note> notes;

  ArchivedNotes({@required this.notes});

  @override
  List<Object> get props => [notes];
}
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../note/domain/entities/note.dart';

class DeletedNotes extends Equatable {
  final List<Note> notes;

  DeletedNotes({@required this.notes});

  @override
  List<Object> get props => [notes];
}

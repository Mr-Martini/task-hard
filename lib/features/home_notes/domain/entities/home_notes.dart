import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../note/domain/entities/note.dart';

class HomeNotes extends Equatable {
  final List<Note> notes;

  HomeNotes({@required this.notes});

  @override
  List<Object> get props => [notes];
}

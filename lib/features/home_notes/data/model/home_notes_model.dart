import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:task_hard/features/note/data/model/note_model.dart';

import '../../../note/domain/entities/note.dart';
import '../../domain/entities/home_notes.dart';

class HomeNotesModel extends Equatable implements HomeNotes {
  final List<Note> notes;

  HomeNotesModel({@required this.notes});

  @override
  List<Object> get props => [notes];

  factory HomeNotesModel.fromIterable(Iterable<dynamic> iterable) {
    if (iterable == null) return HomeNotesModel(notes: <Note>[]);
    if (iterable.isEmpty) return HomeNotesModel(notes: <Note>[]);

    List<NoteModel> notesAux = [];
    List<dynamic> sorted = iterable.toList();
    sorted.sort(
      (a, b) {
        if (a['lastEdited'] == null) return -1;
        if (b['lastEdited'] == null) return 1;
        return b['lastEdited']
            .millisecondsSinceEpoch
            .compareTo(a['lastEdited'].millisecondsSinceEpoch);
      },
    );
    sorted.forEach(
      (element) {
        final note = NoteModel.fromMap(element);
        notesAux.add(note);
      },
    );
    return HomeNotesModel(notes: notesAux);
  }
}

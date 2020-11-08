import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../note/data/model/note_model.dart';
import '../../../note/domain/entities/note.dart';
import '../../domain/entities/deleted_notes.dart';

class DeletedNotesModel extends Equatable implements DeletedNotes {
  final List<Note> notes;

  DeletedNotesModel({@required this.notes});

  @override
  List<Object> get props => [notes];

  factory DeletedNotesModel.fromIterable(Iterable<dynamic> iterable) {
    if (iterable == null) return DeletedNotesModel(notes: <Note>[]);
    if (iterable.isEmpty) return DeletedNotesModel(notes: <Note>[]);

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
    return DeletedNotesModel(notes: notesAux);
  }
}

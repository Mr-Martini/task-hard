import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../note/data/model/note_model.dart';
import '../../../note/domain/entities/note.dart';
import '../../domain/entities/archive_notes.dart';

class ArchivedNotesModel extends Equatable implements ArchivedNotes {
  final List<Note> notes;

  ArchivedNotesModel({@required this.notes});

  @override
  List<Object> get props => [notes];

  factory ArchivedNotesModel.fromIterable(Iterable<dynamic> iterable) {
    if (iterable == null) return ArchivedNotesModel(notes: <Note>[]);
    if (iterable.isEmpty) return ArchivedNotesModel(notes: <Note>[]);

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
    return ArchivedNotesModel(notes: notesAux);
  }

}
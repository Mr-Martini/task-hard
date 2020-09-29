import 'package:flutter/cupertino.dart';

import '../../features/note/domain/entities/note.dart';

class HomeSelectedNotes with ChangeNotifier {
  List<Note> _notes = <Note>[];

  List<Note> get getNotes => _notes;

  set addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void clear() {
    _notes.clear();
    notifyListeners();
  }

  set removeNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }

  set setList(List<Note> notes) {
    _notes = notes;
    notifyListeners();
  }
}

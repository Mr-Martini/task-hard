import 'package:flutter/cupertino.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

class ArchiveSelectedNotes with ChangeNotifier {
  List<Note> _seletectedNotes = <Note>[];

  void clear() {
    _seletectedNotes.clear();
    notifyListeners();
  }

  set addNote(Note note) {
    _seletectedNotes.add(note);
    notifyListeners();
  }

  set setList(List<Note> notes) {
    _seletectedNotes = List<Note>.from(notes);
    notifyListeners();
  }

  set removeNote(Note note) {
    _seletectedNotes.remove(note);
    notifyListeners();
  }

  List<Note> get getNotes => _seletectedNotes;
}
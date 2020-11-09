import 'package:flutter/cupertino.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

class DeletedSelectedNotes with ChangeNotifier {
  List<Note> _selectedNotes = <Note>[];


  List<Note> get getNotes => _selectedNotes;

  void clear() {
    _selectedNotes.clear();
    notifyListeners();
  }

  set setList(List<Note> notes) {
    _selectedNotes = List<Note>.from(notes);
    notifyListeners();
  }

  set addNote(Note note) {
    _selectedNotes.add(note);
    notifyListeners();
  }

  set removeNote(Note note) {
    _selectedNotes.remove(note);
    notifyListeners();
  }
}
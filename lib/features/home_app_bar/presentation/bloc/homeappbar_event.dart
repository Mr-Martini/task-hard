part of 'homeappbar_bloc.dart';

abstract class HomeappbarEvent extends Equatable {
  const HomeappbarEvent();

  @override
  List<Object> get props => [];
}

class AddNote extends HomeappbarEvent {
  final List<Note> selectedNotes;

  AddNote({@required this.selectedNotes});

  @override
  List<Object> get props => [selectedNotes];
}

class ChangeColor extends HomeappbarEvent {
  final List<Note> selectedNotes;
  final Color color;

  ChangeColor({@required this.selectedNotes, @required this.color});

  @override
  List<Object> get props => [selectedNotes, color];
}

class DeleteNotes extends HomeappbarEvent {
  final List<Note> selectedNotes;

  DeleteNotes({@required this.selectedNotes});

  @override
  List<Object> get props => [selectedNotes];
}

class UndoDeleteNotes extends HomeappbarEvent {
  final List<Note> selectedNotes;

  UndoDeleteNotes({@required this.selectedNotes});

  @override
  List<Object> get props => [selectedNotes];
}

class ArchiveNotes extends HomeappbarEvent {
  final List<Note> selectedNotes;

  ArchiveNotes({@required this.selectedNotes});

  @override
  List<Object> get props => [selectedNotes];
}

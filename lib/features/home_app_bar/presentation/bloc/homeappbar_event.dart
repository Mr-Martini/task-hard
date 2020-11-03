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
  final WriteOn box;

  ChangeColor({
    @required this.selectedNotes,
    @required this.color,
    @required this.box,
  });

  @override
  List<Object> get props => [selectedNotes, color, box];
}

class DeleteNotes extends HomeappbarEvent {
  final List<Note> selectedNotes;
  final WriteOn box;

  DeleteNotes({@required this.selectedNotes, @required this.box,});

  @override
  List<Object> get props => [selectedNotes, box];
}

class UndoDeleteNotes extends HomeappbarEvent {
  final List<Note> selectedNotes;
  final WriteOn box;

  UndoDeleteNotes({@required this.selectedNotes, @required this.box});

  @override
  List<Object> get props => [selectedNotes, box];
}

class ArchiveNotes extends HomeappbarEvent {
  final List<Note> selectedNotes;
  final WriteOn box;

  ArchiveNotes({@required this.selectedNotes, @required this.box});

  @override
  List<Object> get props => [selectedNotes, box];
}

class UndoArchiveNotes extends HomeappbarEvent {
  final List<Note> selectedNotes;
  final WriteOn box;

  UndoArchiveNotes({@required this.selectedNotes, @required this.box});

  @override
  List<Object> get props => [selectedNotes, box];
}

class PutReminder extends HomeappbarEvent {
  final List<Note> selectedNotes;
  final DateTime scheduledDate;
  final String repeat;
  final WriteOn box;

  PutReminder({
    @required this.selectedNotes,
    @required this.scheduledDate,
    @required this.repeat,
    @required this.box,
  });

  @override
  List<Object> get props => [selectedNotes, scheduledDate, repeat, box];
}

class DeleteReminder extends HomeappbarEvent {
  final List<Note> selectedNotes;
  final WriteOn box;

  DeleteReminder({@required this.selectedNotes, @required this.box,});

  @override
  List<Object> get props => [selectedNotes, box];
}

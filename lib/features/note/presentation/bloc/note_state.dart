part of 'note_bloc.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object> get props => [];
}

class NoteInitial extends NoteState {}

class Loaded extends NoteState {
  final Note note;

  Loaded({@required this.note});

  @override
  List<Object> get props => [note];
}

class Error extends NoteState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}

class Loading extends NoteState {}

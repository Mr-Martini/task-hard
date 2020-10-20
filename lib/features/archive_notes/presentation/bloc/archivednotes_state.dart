part of 'archivednotes_bloc.dart';

abstract class ArchivedNotesState extends Equatable {
  const ArchivedNotesState();
  
  @override
  List<Object> get props => [];
}

class ArchivedNotesInitial extends ArchivedNotesState {}

class Loaded extends ArchivedNotesState {
  final List<Note> notes;

  Loaded({@required this.notes});

    @override
  List<Object> get props => [notes];
  
}

class Error extends ArchivedNotesState {
  final String message;

  Error({@required this.message});

    @override
  List<Object> get props => [message];
  
}


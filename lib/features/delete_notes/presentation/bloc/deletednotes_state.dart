part of 'deletednotes_bloc.dart';

abstract class DeletedNotesState extends Equatable {
  const DeletedNotesState();

  @override
  List<Object> get props => [];
}

class DeletedNotesInitial extends DeletedNotesState {}

class DeletedNotesLoaded extends DeletedNotesState {
  final List<Note> notes;

  DeletedNotesLoaded({@required this.notes});

  @override
  List<Object> get props => [notes];
}

class DeletedNotesError extends DeletedNotesState {
  final String message;

  DeletedNotesError({@required this.message});

  @override
  List<Object> get props => [message];
}

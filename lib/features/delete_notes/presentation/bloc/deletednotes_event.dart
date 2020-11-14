part of 'deletednotes_bloc.dart';

abstract class DeletedNotesEvent extends Equatable {
  const DeletedNotesEvent();

  @override
  List<Object> get props => [];
}

class GetDeletedNotes extends DeletedNotesEvent {}

class RestoreNotes extends DeletedNotesEvent {
  final List<Note> notes;

  RestoreNotes({@required this.notes});

  @override
  List<Object> get props => [notes];
}

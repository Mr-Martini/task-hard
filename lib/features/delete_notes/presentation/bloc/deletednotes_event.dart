part of 'deletednotes_bloc.dart';

abstract class DeletedNotesEvent extends Equatable {
  const DeletedNotesEvent();

  @override
  List<Object> get props => [];
}

class GetDeletedNotes extends DeletedNotesEvent {}

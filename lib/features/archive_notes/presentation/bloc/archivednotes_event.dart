part of 'archivednotes_bloc.dart';

abstract class ArchivedNotesEvent extends Equatable {
  const ArchivedNotesEvent();

  @override
  List<Object> get props => [];
}

class GetArchivedNotes extends ArchivedNotesEvent {
  
}
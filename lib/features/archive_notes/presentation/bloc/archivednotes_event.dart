part of 'archivednotes_bloc.dart';

abstract class ArchivedNotesEvent extends Equatable {
  const ArchivedNotesEvent();

  @override
  List<Object> get props => [];
}

class GetArchivedNotes extends ArchivedNotesEvent {}

class ExpireCheckerArchive extends ArchivedNotesEvent {
  final Iterable<dynamic> notes;

  ExpireCheckerArchive({@required this.notes});
  @override
  List<Object> get props => [notes];
}

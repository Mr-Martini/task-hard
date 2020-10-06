part of 'notereminder_bloc.dart';

abstract class NoteReminderEvent extends Equatable {
  const NoteReminderEvent();

  @override
  List<Object> get props => [];
}

class GetNoteReminder extends NoteReminderEvent {
  final String noteKey;

  GetNoteReminder({@required this.noteKey});

  @override
  List<Object> get props => [noteKey];
}

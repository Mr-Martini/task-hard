part of 'notereminder_bloc.dart';

abstract class NoteReminderEvent extends Equatable {
  const NoteReminderEvent();

  @override
  List<Object> get props => [];
}

class GetNoteReminder extends NoteReminderEvent {
  final String noteKey;
  final WriteOn box;

  GetNoteReminder({
    @required this.noteKey,
    @required this.box,
  });

  @override
  List<Object> get props => [noteKey, box];
}

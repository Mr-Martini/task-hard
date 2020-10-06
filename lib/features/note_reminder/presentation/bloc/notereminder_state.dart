part of 'notereminder_bloc.dart';

abstract class NoteReminderState extends Equatable {
  const NoteReminderState();

  @override
  List<Object> get props => [];
}

class NoteReminderInitial extends NoteReminderState {}

class Loaded extends NoteReminderState {
  final DateTime reminder;
  final bool expired;
  final String repeat;

  Loaded({
    @required this.reminder,
    @required this.expired,
    @required this.repeat,
  });

  @override
  List<Object> get props => [reminder, repeat, expired];
}

class Error extends NoteReminderState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}

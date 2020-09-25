part of 'timepreference_bloc.dart';

abstract class TimepreferenceState extends Equatable {
  const TimepreferenceState();

  @override
  List<Object> get props => [];
}

class TimepreferenceInitial extends TimepreferenceState {}

class Loaded extends TimepreferenceState {
  final TimePreference timePreference;

  Loaded({@required this.timePreference});

  @override
  List<Object> get props => [timePreference];
}

class Loading extends TimepreferenceState {}

class Error extends TimepreferenceState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}

part of 'timepreference_bloc.dart';

abstract class TimepreferenceEvent extends Equatable {
  const TimepreferenceEvent();

  @override
  List<Object> get props => [];
}

class GetTimePreference extends TimepreferenceEvent {}

class SetMorningTimePreference extends TimepreferenceEvent {
  final TimeOfDay morning;

  SetMorningTimePreference({@required this.morning});

  @override
  List<Object> get props => [morning];
}

class SetNoonTimePreference extends TimepreferenceEvent {
  final TimeOfDay noon;

  SetNoonTimePreference({@required this.noon});

  @override
  List<Object> get props => [noon];
}

class SetAfternoonTimePreference extends TimepreferenceEvent {
  final TimeOfDay afternoon;

  SetAfternoonTimePreference({@required this.afternoon});

  @override
  List<Object> get props => [afternoon];
}

class SetNightTimePreference extends TimepreferenceEvent {
  final TimeOfDay night;

  SetNightTimePreference({@required this.night});

  @override
  List<Object> get props => [night];
}

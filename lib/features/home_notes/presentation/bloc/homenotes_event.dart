part of 'homenotes_bloc.dart';

abstract class HomenotesEvent extends Equatable {
  const HomenotesEvent();

  @override
  List<Object> get props => [];
}

class GetHomeNotes extends HomenotesEvent {}

class ListenHomeNotes extends HomenotesEvent {
  final Iterable<dynamic> notes;

  ListenHomeNotes({@required this.notes});

  @override
  List<Object> get props => [notes];
}

class ExpireChecker extends HomenotesEvent {
  final Iterable<dynamic> notes;

  ExpireChecker({@required this.notes});

  @override
  List<Object> get props => [notes];
}

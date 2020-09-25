part of 'homenotes_bloc.dart';

abstract class HomenotesState extends Equatable {
  const HomenotesState();

  @override
  List<Object> get props => [];
}

class HomenotesInitial extends HomenotesState {}

class Error extends HomenotesState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}

class Loaded extends HomenotesState {
  final HomeNotes notes;

  Loaded({@required this.notes});

  @override
  List<Object> get props => [notes];
}

part of 'homeappbar_bloc.dart';

abstract class HomeappbarState extends Equatable {
  const HomeappbarState();

  @override
  List<Object> get props => [];
}

class HomeappbarInitial extends HomeappbarState {}

class Loaded extends HomeappbarState {
  final HomeAppBarEntity selectedNotes;

  Loaded({@required this.selectedNotes});

  @override
  List<Object> get props => [selectedNotes];
}

class Error extends HomeappbarState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}

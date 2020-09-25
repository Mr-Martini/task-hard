part of 'tagednoteshomebloc_bloc.dart';

abstract class TagednoteshomeblocState extends Equatable {
  const TagednoteshomeblocState();

  @override
  List<Object> get props => [];
}

class TagednoteshomeblocInitial extends TagednoteshomeblocState {}

class Empty extends TagednoteshomeblocState {
  @override
  List<Object> get props => [];
}

class Loading extends TagednoteshomeblocState {
  @override
  List<Object> get props => [];
}

class Loaded extends TagednoteshomeblocState {
  final bool should;

  Loaded({@required this.should});

  @override
  List<Object> get props => [should];
}

class Error extends TagednoteshomeblocState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}

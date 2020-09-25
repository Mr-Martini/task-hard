part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {}

class Loading extends ThemeState {}

class Loaded extends ThemeState {
  final ThemeEntity theme;

  Loaded({@required this.theme});

  @override
  List<Object> get props => [theme];
}

class Error extends ThemeState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}

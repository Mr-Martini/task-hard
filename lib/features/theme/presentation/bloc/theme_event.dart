part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class GetTheme extends ThemeEvent {}

class SetTheme extends ThemeEvent {
  final themePreference preference;

  SetTheme({@required this.preference});

  @override
  List<Object> get props => [preference];
}

class SetColor extends ThemeEvent {
  final Color color;

  SetColor({@required this.color});

  @override
  List<Object> get props => [color];
}

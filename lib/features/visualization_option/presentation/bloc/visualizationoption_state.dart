part of 'visualizationoption_bloc.dart';

abstract class VisualizationOptionState extends Equatable {
  const VisualizationOptionState();

  @override
  List<Object> get props => [];
}

class VisualizationOptionInitial extends VisualizationOptionState {}

class Loaded extends VisualizationOptionState {
  final VisualizationOption type;

  Loaded({@required this.type});

  @override
  List<Object> get props => [type];
}

class Error extends VisualizationOptionState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}

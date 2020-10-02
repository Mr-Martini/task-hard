part of 'visualizationoption_bloc.dart';

abstract class VisualizationOptionEvent extends Equatable {
  const VisualizationOptionEvent();

  @override
  List<Object> get props => [];
}

class GetVisualizationOption extends VisualizationOptionEvent {
  @override
  List<Object> get props => [];
}

class SetVisualizationOption extends VisualizationOptionEvent {
  final int value;

  SetVisualizationOption({@required this.value});

  @override
  List<Object> get props => [value];
}

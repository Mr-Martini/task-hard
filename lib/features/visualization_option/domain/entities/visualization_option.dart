import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class VisualizationOption extends Equatable {
  final int type;

  VisualizationOption({@required this.type});

  @override
  List<Object> get props => [type];
}

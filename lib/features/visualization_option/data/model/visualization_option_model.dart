import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/visualization_option.dart';

class VisualizationOptionModel extends Equatable
    implements VisualizationOption {
  final int type;

  VisualizationOptionModel({@required this.type});

  factory VisualizationOptionModel.fromInt(int value) {
    return VisualizationOptionModel(type: value);
  }

  int toInt() {
    return type;
  }

  @override
  List<Object> get props => [type];
}

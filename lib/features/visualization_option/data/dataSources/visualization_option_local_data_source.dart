import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../../../core/Utils/visualization_type.dart';
import '../model/visualization_option_model.dart';

const String boxKey = 'visu_type';

abstract class VisualizationOptionLocalDataSource {
  VisualizationOptionModel getVisualizationModel();
  VisualizationOptionModel setVisualizationOption(int value);
}

class VisualizationOptionLocalDataSourceImpl
    implements VisualizationOptionLocalDataSource {
  final Box<dynamic> box;

  VisualizationOptionLocalDataSourceImpl({@required this.box});

  @override
  VisualizationOptionModel getVisualizationModel() {
    final int type = box.get(boxKey, defaultValue: VisualizationType.grid);
    return VisualizationOptionModel.fromInt(type);
  }

  @override
  VisualizationOptionModel setVisualizationOption(int value) {
    box.put(boxKey, value);
    return VisualizationOptionModel.fromInt(value);
  }
}

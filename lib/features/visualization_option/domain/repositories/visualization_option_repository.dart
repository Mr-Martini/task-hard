import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/visualization_option.dart';

abstract class VisualizationOptionRepository {
  Either<Failure, VisualizationOption> getVisualizatinOption();
  Either<Failure, VisualizationOption> setVisualizatinOption(int value);
}

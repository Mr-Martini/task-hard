import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/visualization_option.dart';
import '../../domain/repositories/visualization_option_repository.dart';
import '../dataSources/visualization_option_local_data_source.dart';

class VisualizationOptionRepositoryImpl
    implements VisualizationOptionRepository {
  final VisualizationOptionLocalDataSource dataSource;

  VisualizationOptionRepositoryImpl({@required this.dataSource});

  @override
  Either<Failure, VisualizationOption> getVisualizatinOption() {
    try {
      final type = dataSource.getVisualizationModel();
      return Right(type);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Either<Failure, VisualizationOption> setVisualizatinOption(int value) {
    try {
      final type = dataSource.setVisualizationOption(value);
      return Right(type);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}

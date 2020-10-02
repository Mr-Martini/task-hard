import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/visualization_option.dart';
import '../repositories/visualization_option_repository.dart';

class GetVisualizationOptionUseCase
    implements UseCases<VisualizationOption, NoParams> {
  final VisualizationOptionRepository repository;

  GetVisualizationOptionUseCase({@required this.repository});

  @override
  Either<Failure, VisualizationOption> call(NoParams params) {
    return repository.getVisualizatinOption();
  }
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/core/Utils/visualization_type.dart';
import 'package:task_hard/core/usecases/usecases.dart';
import 'package:task_hard/features/visualization_option/domain/entities/visualization_option.dart';
import 'package:task_hard/features/visualization_option/domain/repositories/visualization_option_repository.dart';
import 'package:task_hard/features/visualization_option/domain/usecases/get_visualization_option_usecase.dart';

class MockVisualizationOptionRepository extends Mock
    implements VisualizationOptionRepository {}

void main() {
  MockVisualizationOptionRepository repository;
  GetVisualizationOptionUseCase useCase;

  setUp(
    () {
      repository = MockVisualizationOptionRepository();
      useCase = GetVisualizationOptionUseCase(repository: repository);
    },
  );

  final model = VisualizationOption(type: VisualizationType.grid);
  test(
    'should return Right<VisualizationOption> when GetVisualizationTypeUseCase is called',
    () {
      when(repository.getVisualizatinOption()).thenReturn(Right(model));

      final result = useCase(NoParams());

      verify(repository.getVisualizatinOption());
      verifyNoMoreInteractions(repository);
      expect(result, Right(model));
    },
  );
}

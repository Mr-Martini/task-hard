import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/core/Utils/visualization_type.dart';
import 'package:task_hard/features/visualization_option/domain/entities/visualization_option.dart';
import 'package:task_hard/features/visualization_option/domain/repositories/visualization_option_repository.dart';
import 'package:task_hard/features/visualization_option/domain/usecases/set_visualization_option.dart';

class MockRepository extends Mock implements VisualizationOptionRepository {}

void main() {
  MockRepository repository;
  SetVisualizationOptionUseCase useCase;

  setUp(
    () {
      repository = MockRepository();
      useCase = SetVisualizationOptionUseCase(repository: repository);
    },
  );

  final model = VisualizationOption(type: VisualizationType.grid);

  test(
    'should return Right<VisualizationOption> when SetVisualizationOptionUseCase is called',
    () {
      when(repository.setVisualizatinOption(any)).thenReturn(Right(model));

      final result =
          useCase(SetVisualizationOptionParams(value: VisualizationType.grid));

      verify(repository.setVisualizatinOption(VisualizationType.grid));
      verifyNoMoreInteractions(repository);
      expect(result, Right(model));
    },
  );
}

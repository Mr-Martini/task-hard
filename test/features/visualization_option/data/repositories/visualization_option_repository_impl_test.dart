import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/core/Utils/visualization_type.dart';
import 'package:task_hard/features/visualization_option/data/dataSources/visualization_option_local_data_source.dart';
import 'package:task_hard/features/visualization_option/data/model/visualization_option_model.dart';
import 'package:task_hard/features/visualization_option/data/repositories/visualization_option_repository_impl.dart';

class MockLocalDataSource extends Mock
    implements VisualizationOptionLocalDataSourceImpl {}

void main() {
  MockLocalDataSource dataSource;
  VisualizationOptionRepositoryImpl impl;

  setUp(
    () {
      dataSource = MockLocalDataSource();
      impl = VisualizationOptionRepositoryImpl(dataSource: dataSource);
    },
  );

  final model = VisualizationOptionModel.fromInt(VisualizationType.grid);
  test(
    'should return Right<VisualizationOptionModel> when getVisualizationOption is called',
    () {
      when(dataSource.getVisualizationModel()).thenReturn(model);

      final result = impl.getVisualizatinOption();

      verify(dataSource.getVisualizationModel());
      verifyNoMoreInteractions(dataSource);
      expect(result, Right(model));
    },
  );

  test(
    'should return Right<VisualizationOptionModel> when setVisualizationOption is called',
    () {
      when(dataSource.setVisualizationOption(any)).thenReturn(model);

      final result = impl.setVisualizatinOption(VisualizationType.grid);

      verify(dataSource.setVisualizationOption(VisualizationType.grid));
      verifyNoMoreInteractions(dataSource);
      expect(result, Right(model));
    },
  );
}

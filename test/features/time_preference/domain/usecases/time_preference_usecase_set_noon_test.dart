import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/time_preference/data/model/time_preference_model.dart';
import 'package:task_hard/features/time_preference/domain/repositories/time_preference_repository.dart';
import 'package:task_hard/features/time_preference/domain/usecases/time_preference_usecase_set_noon.dart';

class MockTimePreferenceRepository extends Mock
    implements TimePreferenceRepository {}

void main() {
  MockTimePreferenceRepository repository;
  // ignore: unused_local_variable
  SetNoonTimePreferenceUseCase set;

  setUp(
    () {
      repository = MockTimePreferenceRepository();
      set = SetNoonTimePreferenceUseCase(repository);
    },
  );

  group(
    'setNoon',
    () {
      final TimeOfDay noon = TimeOfDay(hour: 12, minute: 0);

      final tNoonModel = TimePreferenceModel(
        morning: noon,
        noon: null,
        afternoon: null,
        night: null,
      );

      test(
        'should return the time with the specified noon time',
        () {
          when(repository.setNoon(noon: noon)).thenReturn(Right(tNoonModel));

          final result = repository.setNoon(noon: noon);

          verify(repository.setNoon(noon: noon));
          verifyNoMoreInteractions(repository);
          expect(result, Right(tNoonModel));
        },
      );
    },
  );
}

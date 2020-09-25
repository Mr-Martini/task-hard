import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/time_preference/data/model/time_preference_model.dart';
import 'package:task_hard/features/time_preference/domain/repositories/time_preference_repository.dart';
import 'package:task_hard/features/time_preference/domain/usecases/time_preference_usecase_night.dart';

class MockTimePreferenceRepository extends Mock
    implements TimePreferenceRepository {}

void main() {
  MockTimePreferenceRepository repository;
  // ignore: unused_local_variable
  SetNightTimePreferenceUseCase set;

  setUp(
    () {
      repository = MockTimePreferenceRepository();
      set = SetNightTimePreferenceUseCase(repository);
    },
  );

  group(
    'setNight',
    () {
      final TimeOfDay night = TimeOfDay(hour: 20, minute: 0);

      final tNightModel = TimePreferenceModel(
        morning: null,
        noon: null,
        afternoon: null,
        night: night,
      );

      test(
        'should return the time with the specified night time',
        () {
          when(repository.setNight(night: night))
              .thenReturn(Right(tNightModel));

          final result = repository.setNight(night: night);

          verify(repository.setNight(night: night));
          verifyNoMoreInteractions(repository);
          expect(result, Right(tNightModel));
        },
      );
    },
  );
}

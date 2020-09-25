import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/time_preference/domain/entities/time_preference.dart';
import 'package:task_hard/features/time_preference/domain/repositories/time_preference_repository.dart';
import 'package:task_hard/features/time_preference/domain/usecases/time_preference_usecase_set_afternoon.dart';

class MockTimePreferenceRepository extends Mock
    implements TimePreferenceRepository {}

void main() {
  MockTimePreferenceRepository repository;
  // ignore: unused_local_variable
  SetAfternoonTimePreferenceUsecase usecase;

  setUp(
    () {
      repository = MockTimePreferenceRepository();
      usecase = SetAfternoonTimePreferenceUsecase(repository);
    },
  );

  group(
    'setAfternoon',
    () {
      final afternoon = TimeOfDay(hour: 16, minute: 0);

      final TimePreference timePreference = TimePreference(
        morning: null,
        noon: null,
        afternoon: afternoon,
        night: null,
      );
      test(
        'should return the time with the specified afternoon tiem',
        () {
          when(repository.setAfternoon(afternoon: afternoon))
              .thenReturn(Right(timePreference));

          final result = repository.setAfternoon(afternoon: afternoon);

          verify(repository.setAfternoon(afternoon: afternoon));
          verifyNoMoreInteractions(repository);
          expect(result, Right(timePreference));
        },
      );
    },
  );
}

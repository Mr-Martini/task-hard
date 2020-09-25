import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/time_preference/data/model/time_preference_model.dart';
import 'package:task_hard/features/time_preference/domain/repositories/time_preference_repository.dart';
import 'package:task_hard/features/time_preference/domain/usecases/time_preference_usecase_set_preference_morning.dart';

class MockTimePreferenceRepository extends Mock
    implements TimePreferenceRepository {}

void main() {
  MockTimePreferenceRepository repository;
  // ignore: unused_local_variable
  SetMorningTimePreferenceUseCase set;

  setUp(
    () {
      repository = MockTimePreferenceRepository();
      set = SetMorningTimePreferenceUseCase(repository);
    },
  );

  group(
    'setMorning',
    () {
      final TimeOfDay morning = TimeOfDay(hour: 8, minute: 20);

      final tMorningModel = TimePreferenceModel(
        morning: morning,
        noon: null,
        afternoon: null,
        night: null,
      );

      test(
        'should return the time with the specified morning tiem',
        () {
          when(repository.setMorning(morning: morning))
              .thenReturn(Right(tMorningModel));

          final result = repository.setMorning(morning: morning);

          verify(repository.setMorning(morning: morning));
          verifyNoMoreInteractions(repository);
          expect(result, Right(tMorningModel));
        },
      );
    },
  );
}

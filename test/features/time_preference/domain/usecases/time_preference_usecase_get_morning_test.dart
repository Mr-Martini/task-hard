import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/time_preference/domain/entities/time_preference.dart';
import 'package:task_hard/features/time_preference/domain/repositories/time_preference_repository.dart';
import 'package:task_hard/features/time_preference/domain/usecases/time_preference_usecase_morning.dart';

class MockTimePreferenceRepository extends Mock
    implements TimePreferenceRepository {}

void main() {
  MockTimePreferenceRepository repository;
  // ignore: unused_local_variable
  GetTimePreferenceUseCase getMorningTimePreference;

  setUp(
    () {
      repository = MockTimePreferenceRepository();
      getMorningTimePreference = GetTimePreferenceUseCase(repository);
    },
  );

  group(
    'get_usecase',
    () {
      final TimePreference timePreference = TimePreference(
        morning: null,
        noon: null,
        afternoon: null,
        night: null,
      );
      test(
        'should return morning preference from the repository',
        () {
          when(repository.getPreference()).thenReturn(Right(timePreference));

          final result = repository.getPreference();

          verify(repository.getPreference());
          verifyNoMoreInteractions(repository);
          expect(result, Right(timePreference));
        },
      );
    },
  );
}

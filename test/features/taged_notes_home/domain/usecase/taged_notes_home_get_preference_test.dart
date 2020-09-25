import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/taged_notes_home/domain/entities/taged_notes_home.dart';
import 'package:task_hard/features/taged_notes_home/domain/repositories/taged_notes_home_repository.dart';
import 'package:task_hard/features/taged_notes_home/domain/usecases/taged_notes_home_get_preference.dart';

class MockTagedNotesHomeRepository extends Mock
    implements TagedNotesHomeRepository {}

void main() {
  // ignore: unused_local_variable
  GetTagedNotesHomePreference preference;
  MockTagedNotesHomeRepository repository;

  setUp(
    () {
      repository = MockTagedNotesHomeRepository();
      preference = GetTagedNotesHomePreference(repository);
    },
  );

  final TagedNotesHome tagedNotesHome = TagedNotesHome(true);
  test(
    'should return the preference from the repository',
    () {
      when(repository.getPreference()).thenAnswer((_) => Right(tagedNotesHome));

      final result = repository.getPreference();

      expect(result, Right(tagedNotesHome));
      verify(repository.getPreference());
      verifyNoMoreInteractions(repository);
    },
  );
}

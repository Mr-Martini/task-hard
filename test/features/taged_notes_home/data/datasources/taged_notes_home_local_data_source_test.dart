import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_hard/features/taged_notes_home/data/datasources/taged_notes_home_local_data_source.dart';
import 'package:task_hard/features/taged_notes_home/data/model/taged_notes_home_model.dart';

class MockBox extends Mock implements Box<dynamic> {}

void main() {
  TagedNotesHomeLocalDataSourceImpl dataSource;
  MockBox mockBox;

  setUp(
    () {
      mockBox = MockBox();
      dataSource = TagedNotesHomeLocalDataSourceImpl(mockBox);
    },
  );

  group(
    'getPreference',
    () {
      final model = TagedNotesHomeModel(true);
      test(
        'should return [TagedNotesHome] from box when there is one cached',
        () {
          when(mockBox.get(any)).thenReturn(true);

          final result = dataSource.getPreference();

          expect(result, model);
        },
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';
import 'package:task_hard/features/time_preference/data/datasources/time_preference_local_data_source.dart';
import 'package:task_hard/features/time_preference/data/model/time_preference_model.dart';

class MockBox extends Mock implements Box<dynamic> {}

void main() {
  MockBox mockBox;
  TimePreferenceLocalDataSourceImpl dataSource;

  setUp(
    () {
      mockBox = MockBox();
      dataSource =
          TimePreferenceLocalDataSourceImpl(timePreferenceBox: mockBox);
    },
  );

  group(
    'getTimePreference',
    () {
      final tDefaultTime = TimePreferenceModel(
        morning: TimeOfDay(hour: 7, minute: 0),
        noon: TimeOfDay(hour: 12, minute: 0),
        afternoon: TimeOfDay(hour: 16, minute: 0),
        night: TimeOfDay(hour: 20, minute: 0),
      );

      final tCustomTimeMap = <String, dynamic>{
        'morning': [9, 30],
        'noon': [13, 0],
        'afternoon': [16, 0],
        'night': [19, 0],
      };
      final tCustomTimeModel = TimePreferenceModel(
        morning: TimeOfDay(hour: 9, minute: 30),
        noon: TimeOfDay(hour: 13, minute: 0),
        afternoon: TimeOfDay(hour: 16, minute: 0),
        night: TimeOfDay(hour: 19, minute: 0),
      );
      test(
        'should return time model when there\'s something in cache',
        () {
          when(mockBox.get(any)).thenReturn(tCustomTimeMap);

          final result = dataSource.getTimePreference();

          verify(mockBox.get(TIME_PREFERENCE));
          expect(result, tCustomTimeModel);
        },
      );

      test(
        'should return default time when there\'s nothing in cache',
        () {
          when(mockBox.get(any)).thenReturn(null);

          final result = dataSource.getTimePreference();

          verify(mockBox.get(TIME_PREFERENCE));
          expect(result, tDefaultTime);
        },
      );
    },
  );

  group(
    'setPreference',
    () {
      final morning = TimeOfDay(hour: 6, minute: 0);

      final defaultNoon = TimeOfDay(hour: 12, minute: 0);
      final defaulAfternoon = TimeOfDay(hour: 16, minute: 0);
      final defaultNight = TimeOfDay(hour: 20, minute: 0);

      final tModel = <String, dynamic>{
        'morning': [7, 0],
        'noon': [12, 0],
        'afternoon': [16, 0],
        'night': [20, 0]
      };

      final tModelExpectedMorning = TimePreferenceModel(
        morning: morning,
        noon: defaultNoon,
        afternoon: defaulAfternoon,
        night: defaultNight,
      );

      test(
        'should return tModel when get is called',
        () {
          when(mockBox.get(any)).thenReturn(tModel);

          final result = mockBox.get(TIME_PREFERENCE);

          verify(mockBox.get(TIME_PREFERENCE));
          expect(result, tModel);
        },
      );

      test(
        'should merge the values when morning is updated',
        () {
          when(mockBox.get(any)).thenReturn(tModel);

          final result = dataSource.setMorning(morning);

          verify(mockBox.get(TIME_PREFERENCE));
          expect(result, tModelExpectedMorning);
        },
      );
    },
  );
}

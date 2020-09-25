import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:task_hard/features/time_preference/data/model/time_preference_model.dart';

void main() {
  TimePreferenceModel model;

  TimeOfDay morning = TimeOfDay(hour: 8, minute: 0);
  TimeOfDay noon = TimeOfDay(hour: 12, minute: 0);
  TimeOfDay afternoon = TimeOfDay(hour: 16, minute: 0);
  TimeOfDay night = TimeOfDay(hour: 20, minute: 0);

  setUp(
    () {
      model = TimePreferenceModel(
        morning: morning,
        noon: noon,
        afternoon: afternoon,
        night: night,
      );
    },
  );
  group(
    'time_preference_model',
    () {
      Map<String, dynamic> jsonMap = {
        'morning': [8, 0],
        'noon': [12, 0],
        'afternoon': [16, 0],
        'night': [20, 0]
      };
      test(
        'should return the fucking correct model the the json is inserted',
        () {
          final result = TimePreferenceModel.fromJson(jsonMap);
          expect(result, model);
        },
      );
    },
  );
}

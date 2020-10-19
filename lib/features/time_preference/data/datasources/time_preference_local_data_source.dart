import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../model/time_preference_model.dart';

abstract class TimePreferenceLocalDataSource {
  TimePreferenceModel getTimePreference();
  TimePreferenceModel setMorning(TimeOfDay morning);
  TimePreferenceModel setNoon(TimeOfDay noon);
  TimePreferenceModel setAfternoon(TimeOfDay afternoon);
  TimePreferenceModel setNight(TimeOfDay night);
}

const String TIME_PREFERENCE = 'TIME_PREFERENCE';

class TimePreferenceLocalDataSourceImpl
    implements TimePreferenceLocalDataSource {
  final Box<dynamic> timePreferenceBox;

  TimePreferenceLocalDataSourceImpl({@required this.timePreferenceBox});

  @override
  TimePreferenceModel getTimePreference() {
    final preference =
        timePreferenceBox.get(TIME_PREFERENCE, defaultValue: null);

    if (preference != null) {
      return TimePreferenceModel.fromJson(preference);
    }
    timePreferenceBox.put(TIME_PREFERENCE, _getDefaultTime());
    return TimePreferenceModel.fromJson(_getDefaultTime());
  }

  Map<String, dynamic> _getDefaultTime() {
    return <String, dynamic>{
      'morning': [7, 0],
      'noon': [12, 0],
      'afternoon': [16, 0],
      'night': [20, 0],
    };
  }

  @override
  TimePreferenceModel setMorning(TimeOfDay morning) {
    dynamic preference =
        timePreferenceBox.get(TIME_PREFERENCE, defaultValue: null);
    preference['morning'] = [morning.hour, morning.minute];
    timePreferenceBox.put(TIME_PREFERENCE, preference);
    return TimePreferenceModel.fromJson(preference);
  }

  @override
  TimePreferenceModel setNoon(TimeOfDay noon) {
    dynamic preference =
        timePreferenceBox.get(TIME_PREFERENCE, defaultValue: null);
    preference['noon'] = [noon.hour, noon.minute];
    timePreferenceBox.put(TIME_PREFERENCE, preference);
    return TimePreferenceModel.fromJson(preference);
  }

  @override
  TimePreferenceModel setAfternoon(TimeOfDay afternoon) {
    dynamic preference =
        timePreferenceBox.get(TIME_PREFERENCE, defaultValue: null);
    preference['afternoon'] = [afternoon.hour, afternoon.minute];
    timePreferenceBox.put(TIME_PREFERENCE, preference);
    return TimePreferenceModel.fromJson(preference);
  }

  @override
  TimePreferenceModel setNight(TimeOfDay night) {
    dynamic preference =
        timePreferenceBox.get(TIME_PREFERENCE, defaultValue: null);
    preference['night'] = [night.hour, night.minute];
    timePreferenceBox.put(TIME_PREFERENCE, preference);
    return TimePreferenceModel.fromJson(preference);
  }
}

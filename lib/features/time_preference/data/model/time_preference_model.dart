import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:task_hard/features/time_preference/domain/entities/time_preference.dart';

class TimePreferenceModel extends Equatable implements TimePreference {
  final TimeOfDay morning;
  final TimeOfDay noon;
  final TimeOfDay afternoon;
  final TimeOfDay night;

  TimePreferenceModel({
    @required this.morning,
    @required this.noon,
    @required this.afternoon,
    @required this.night,
  });

  factory TimePreferenceModel.fromJson(dynamic jsonMap) {
    List morningAsList = jsonMap['morning'];
    List noonAsList = jsonMap['noon'];
    List afternoonAsList = jsonMap['afternoon'];
    List nightAsList = jsonMap['night'];

    return TimePreferenceModel(
      morning: TimeOfDay(hour: morningAsList[0], minute: morningAsList[1]),
      noon: TimeOfDay(hour: noonAsList[0], minute: noonAsList[1]),
      afternoon:
          TimeOfDay(hour: afternoonAsList[0], minute: afternoonAsList[1]),
      night: TimeOfDay(hour: nightAsList[0], minute: nightAsList[1]),
    );
  }

  @override
  List<Object> get props => [morning, noon, afternoon, night];
}

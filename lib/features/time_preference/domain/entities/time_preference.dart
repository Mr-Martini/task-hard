import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class TimePreference extends Equatable {
  final TimeOfDay morning;
  final TimeOfDay noon;
  final TimeOfDay afternoon;
  final TimeOfDay night;

  TimePreference({
    @required this.morning,
    @required this.noon,
    @required this.afternoon,
    @required this.night,
  });

  @override
  List<Object> get props => [morning, noon, afternoon, night];
}

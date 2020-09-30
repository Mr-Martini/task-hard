import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_hard/core/Utils/alert_reminder_params.dart';

import '../bloc/timepreference_bloc.dart';
import 'alert_reminder.dart';

class AlertReminderContainer extends StatelessWidget {
  final bool hasReminder;
  final Function deleteReminder;
  final ValueChanged<AlertReminderParams> updateReminder;

  AlertReminderContainer({
    @required this.hasReminder,
    @required this.deleteReminder,
    @required this.updateReminder,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimepreferenceBloc, TimepreferenceState>(
      builder: (context, state) {
        if (state is TimepreferenceInitial) {
          BlocProvider.of<TimepreferenceBloc>(context).add(GetTimePreference());
        }
        if (state is Loaded) {
          return AlertReminder(
            hasReminder: hasReminder,
            deleteReminder: deleteReminder,
            createReminder: updateReminder,
            morningTime: state.timePreference.morning,
            noonTime: state.timePreference.noon,
            afternoonTime: state.timePreference.afternoon,
            nightTime: state.timePreference.night,
          );
        }
        return Container();
      },
    );
  }
}

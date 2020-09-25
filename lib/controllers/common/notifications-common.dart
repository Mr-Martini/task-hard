import 'package:flutter/material.dart';
import 'package:task_hard/components/text-components/text-generic.dart';
import 'package:task_hard/controllers/database-controller/hive-controller.dart';
import 'package:task_hard/controllers/reminder-controller/reminder-controller.dart';
import 'package:task_hard/controllers/selectedValues-controller/selected-values-controller.dart';
import 'package:task_hard/generated/l10n.dart';

class NotificationsCommon {
  Future<void> updateReminder(
    SelectedValuesController sIC,
    DateTime selectedDate,
    TimeOfDay selectedTime,
    BuildContext context,
    String repeat,
    HiveController hC,
  ) async {
    DateTime now = DateTime.now();
    DateTime aux = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, selectedTime.hour, selectedTime.minute);
    if (!aux.isAfter(now)) return;
    List notes = List<dynamic>.from(sIC.getSelectedItems);
    sIC.clearSelectedItems();
    Navigator.pop(context);

    for (var note in notes) {
      hC.createReminder(note['key'], aux, repeat, note['reminderKey']);
      ReminderController.scheduleNotification(
        note['key'],
        note['title'],
        note['note'],
        note['reminderKey'],
        aux,
        repeat,
      );
    }
  }

  Future<void> deleteReminder(
    SelectedValuesController sIC,
    S translate,
    GlobalKey<ScaffoldState> scaffoldKey,
    BuildContext context,
    HiveController hC,
  ) async {
    Navigator.pop(context);
    List notes = List<dynamic>.from(sIC.getSelectedItems);
    sIC.clearSelectedItems();
    DateTime reminderDate;
    String repeat;

    for (var note in notes) {
      if (reminderDate == null) {
        reminderDate = note['reminderDate'];
      }
      if (repeat == null) {
        repeat = note['repeat'];
      }
      ReminderController.cancel(note['reminderKey']);
      hC.deleteReminder(note['key']);
    }

    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        elevation: 12,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(),
        backgroundColor: Theme.of(context).primaryColor,
        content: TextGeneric(
          text: translate.reminders_deleted,
          color: Theme.of(context).textTheme.headline6.color,
        ),
        action: SnackBarAction(
          label: translate.undo,
          textColor: Theme.of(context).buttonColor,
          onPressed: () async {
            DateTime now = DateTime.now();

            DateTime aux = DateTime(reminderDate.year, reminderDate.month,
                reminderDate.day, reminderDate.hour, reminderDate.minute);

            if (!aux.isAfter(now)) return;

            for (var note in notes) {
              hC.createReminder(note['key'], aux, repeat, note['reminderKey']);
              ReminderController.scheduleNotification(
                note['key'],
                note['title'],
                note['note'],
                note['reminderKey'],
                aux,
                repeat,
              );
            }
          },
        ),
      ),
    );
  }
}

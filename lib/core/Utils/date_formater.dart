import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_hard/controllers/repeat-controller/repeat-controller.dart';
import 'package:task_hard/generated/l10n.dart';

abstract class DateFormater {
  static String format({
    @required BuildContext context,
    @required S translate,
    @required DateTime date,
    @required String repeat,
  }) {
    TimeOfDay time = TimeOfDay(hour: date.hour, minute: date.minute);
    DateTime now = DateTime.now();

    if (repeat == Repeat.DAILY_REPEAT) {
      return translate.daily + ' | ' + time.format(context);
    } else if (repeat == Repeat.WEEKLY_REPEAT) {
      return translate.each +
          ' ' +
          DateFormat.EEEE().format(date) +
          ' | ' +
          time.format(context);
    } else {
      if (now.day == date.day) {
        return '${time.format(context)} | ${translate.today}';
      } else if (date.day == now.add(Duration(days: 1)).day) {
        return '${time.format(context)} | ${translate.tomorrow}';
      }
      return '${time.format(context)} | ${DateFormat.MMMEd().format(date)}';
    }
  }
}

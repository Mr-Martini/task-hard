import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:task_hard/controllers/day-controller/day-controller.dart';
import 'package:task_hard/controllers/repeat-controller/repeat-controller.dart';

abstract class ReminderController {
  static const _platform = const MethodChannel("notification_method");

  static Future<Map<String, dynamic>> scheduleNotification(
      String key,
      String title,
      String message,
      int id,
      DateTime scheduledDate,
      String repeat) async {
    if (scheduledDate == null) return null;
    DateTime now = DateTime.now();
    if (repeat == Repeat.NO_REPEAT) {
      if (scheduledDate.isBefore(now)) return null;

      try {
        Map<String, dynamic> data = {
          "title": title ?? "",
          "id": id ?? key.hashCode,
          "time": scheduledDate.millisecondsSinceEpoch,
          "message": message ?? ""
        };
        await _platform.invokeMethod('schedule_notification', data);
        return data;
      } on PlatformException catch (e) {
        debugPrint(e.toString());
      }
    } else if (repeat == Repeat.DAILY_REPEAT) {
      if (scheduledDate.isBefore(now)) {
        int hour = scheduledDate.hour;
        int minute = scheduledDate.minute;

        DateTime aux = DateTime(now.year, now.month, now.day, hour, minute);

        if (aux.isBefore(now)) {
          aux = aux.add(Duration(days: 1));
        }
        scheduledDate = aux;
      }

      try {
        Map<String, dynamic> data = {
          "title": title ?? "",
          "id": id ?? key.hashCode,
          "hour": scheduledDate.hour,
          "minute": scheduledDate.minute,
          "time": scheduledDate.millisecondsSinceEpoch,
          "message": message ?? ""
        };
        await _platform.invokeMethod('daily_notification', data);
        return data;
      } on PlatformException catch (e) {
        debugPrint(e.toString());
      }
    } else {
      if (scheduledDate.isBefore(now)) {
        int hour = scheduledDate.hour;
        int minute = scheduledDate.minute;
        int weekDay = scheduledDate.weekday;
        DateTime aux;

        if (scheduledDate.weekday == now.weekday) {
          aux = DateTime(now.year, now.month, now.day, hour, minute);

          if (aux.isBefore(now)) {
            aux = aux.add(Duration(days: 7));
          }
        } else {
          aux = now;
          aux = aux.add(Duration(days: 1));

          while (aux.weekday != weekDay) {
            aux = aux.add(Duration(days: 1));
          }
        }
        scheduledDate = aux;
      }

      try {
        String day = DateFormat('EEE').format(scheduledDate);

        Map<String, dynamic> data = {
          "title": title ?? "",
          "id": id ?? key.hashCode,
          "hour": scheduledDate.hour,
          "minute": scheduledDate.minute,
          "day": Days.getValueOf(day),
          "time": scheduledDate.millisecondsSinceEpoch,
          "message": message ?? ""
        };
        await _platform.invokeMethod('weekly_notification', data);
        return data;
      } on PlatformException catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  static void cancel(int id) async {
    if (id == null) return;
    try {
      Map<String, dynamic> data = {"id": id};
      await _platform.invokeMethod("cancel_notification", data);
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }
}

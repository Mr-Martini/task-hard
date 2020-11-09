import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:task_hard/controllers/day-controller/day-controller.dart';
import 'package:task_hard/controllers/reminder-controller/reminder-controller.dart';
import 'package:task_hard/controllers/repeat-controller/repeat-controller.dart';

void main() {
  group(
    'reminder_controller',
    () {
      test(
        'should return null when repeat is NO_REPEAT & time is outdated',
        () async {
          final DateTime scheduledDate = DateTime(2020, 09, 21, 14, 30);

          final result = await ReminderController.scheduleNotification(
            '50',
            'title',
            'message',
            '50'.hashCode,
            scheduledDate,
            Repeat.NO_REPEAT,
          );
          expect(result, null);
        },
      );

      test(
        'should return the expectMap when is NO_REPEAT',
        () async {
          final time = DateTime.now().add(Duration(hours: 4));

          final expectedMap = <String, dynamic>{
            "title": "title",
            "message": "message",
            "id": "key".hashCode,
            "time": time.millisecondsSinceEpoch,
          };

          final result = await ReminderController.scheduleNotification(
            'key',
            'title',
            'message',
            'key'.hashCode,
            time,
            Repeat.NO_REPEAT,
          );

          expect(result, expectedMap);
        },
      );

      test(
        'should add 1 day if time is outdated when daily_repeat',
        () async {
          final now = DateTime.now();
          final time =
              DateTime(now.year, now.month, now.day, now.hour - 1, now.minute);

          final expectedMap = <String, dynamic>{
            "title": "title",
            "message": "message",
            "id": "key".hashCode,
            "time": time.add(Duration(days: 1)).millisecondsSinceEpoch,
            "hour": time.hour,
            "minute": time.minute,
          };

          final result = await ReminderController.scheduleNotification(
            'key',
            'title',
            'message',
            'key'.hashCode,
            time,
            Repeat.DAILY_REPEAT,
          );

          expect(result, expectedMap);
        },
      );

      test(
        'should scheduled for the next weekDay when time is not outdated',
        () async {
          final now = DateTime.now();
          final time =
              DateTime(now.year, now.month, now.day, now.hour + 1, now.minute);

          String day = DateFormat('EEE').format(time);

          final expectedMap = <String, dynamic>{
            "title": 'title',
            "id": 'key'.hashCode,
            "hour": time.hour,
            "minute": time.minute,
            "day": Days.getValueOf(day),
            "time": time.millisecondsSinceEpoch,
            "message": 'message'
          };

          final result = await ReminderController.scheduleNotification(
            'key',
            'title',
            'message',
            'key'.hashCode,
            time,
            Repeat.WEEKLY_REPEAT,
          );

          expect(result, expectedMap);
        },
      );

      test(
        'should scheduled for the next weekDay when time is outdated',
        () async {
          final now = DateTime.now();
          final time =
              DateTime(now.year, now.month, now.day, now.hour - 1, now.minute);

          String day = DateFormat('EEE').format(time);

          final expectedMap = <String, dynamic>{
            "title": 'title',
            "id": 'key'.hashCode,
            "hour": time.hour,
            "minute": time.minute,
            "day": Days.getValueOf(day),
            "time": time.add(Duration(days: 7)).millisecondsSinceEpoch,
            "message": 'message'
          };

          final result = await ReminderController.scheduleNotification(
            'key',
            'title',
            'message',
            'key'.hashCode,
            time,
            Repeat.WEEKLY_REPEAT,
          );

          expect(result, expectedMap);
        },
      );
    },
  );
}

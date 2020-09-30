import 'package:meta/meta.dart';

class AlertReminderParams {
  final DateTime scheduledDate;
  final String repeat;

  AlertReminderParams({@required this.scheduledDate, @required this.repeat});
}

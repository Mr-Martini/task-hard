import 'package:flutter/material.dart';

import '../../../../components/dropdown-menu-component/dropdown-menu-component.dart';
import '../../../../components/text-components/text-generic.dart';
import '../../../../controllers/repeat-controller/repeat-controller.dart';
import '../../../../core/Utils/alert_reminder_params.dart';
import '../../../../generated/l10n.dart';

class AlertReminder extends StatefulWidget {
  final TimeOfDay morningTime;
  final TimeOfDay noonTime;
  final TimeOfDay afternoonTime;
  final TimeOfDay nightTime;
  final bool hasReminder;
  final Function deleteReminder;
  final ValueChanged<AlertReminderParams> createReminder;

  AlertReminder({
    @required this.hasReminder,
    @required this.deleteReminder,
    @required this.createReminder,
    @required this.morningTime,
    @required this.noonTime,
    @required this.afternoonTime,
    @required this.nightTime,
  });

  static const String tomorrowReminder = 'tomorrow';
  static const String pickADateReminder = 'pick a date';
  static const String pickATimeReminder = 'pick a time';
  static const String todayReminder = 'today';
  static const String noRepeat = 'no repeat';
  static const String daily = 'daily';
  static const String weekly = 'weekly';
  static const String monthly = 'monthly';
  static const String morning = 'morning';
  static const String noon = 'noon';
  static const String afternoon = 'afternoon';
  static const String night = 'night';
  static const Map<String, String> months = {
    '1': 'Jan',
    '2': 'Feb',
    '3': 'Mar',
    '4': 'Apr',
    '5': 'May',
    '6': 'Jun',
    '7': 'Jul',
    '8': 'Aug',
    '9': 'Sep',
    '10': 'Oct',
    '11': 'Nov',
    '12': 'Dec'
  };

  @override
  _AlertReminderState createState() => _AlertReminderState();
}

class _AlertReminderState extends State<AlertReminder> {
  Future<void> handleDate(String value, BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime tomorrowDate = DateTime(now.year, now.month, now.day + 1);
    hasError = false;

    switch (value) {
      case AlertReminder.todayReminder:
        date = now;
        DateTime aux =
            DateTime(date.year, date.month, date.day, time.hour, time.minute);
        if (now.isAfter(aux)) {
          hasError = true;
          Navigator.pop(context);
          return;
        }
        break;
      case AlertReminder.tomorrowReminder:
        date = tomorrowDate;
        break;
      default:
        DateTime aux = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: now,
          lastDate: DateTime(now.year + 10),
        );
        if (aux == null) return;
        if (now.isAfter(aux)) {
          hasError = true;
          return;
        }
        date = aux;
    }

    Navigator.pop(context);
  }

  Future<void> handleTime(String value, BuildContext context) async {
    hasError = false;
    TimeOfDay nowTime = TimeOfDay.now();
    TimeOfDay aux;

    switch (value) {
      case AlertReminder.morning:
        time = widget.morningTime;
        break;
      case AlertReminder.noon:
        time = widget.noonTime;
        break;
      case AlertReminder.afternoon:
        time = widget.afternoonTime;
        break;
      case AlertReminder.night:
        time = widget.nightTime;
        break;
      default:
        aux = await showTimePicker(
          context: context,
          initialTime: time ?? nowTime,
        );
        if (aux == null) return;
        DateTime now = getCurrentDate();
        DateTime auxDate =
            DateTime(date.year, date.month, date.day, aux.hour, aux.minute);
        if (auxDate.isBefore(now)) {
          Navigator.pop(context);
          hasError = true;
          return;
        }
        time = aux;
    }
    Navigator.pop(context);
  }

  void handleRepeat(String value) {
    switch (value) {
      case AlertReminder.noRepeat:
        repeat = Repeat.NO_REPEAT;
        break;
      case AlertReminder.daily:
        repeat = Repeat.DAILY_REPEAT;
        break;
      case AlertReminder.weekly:
        repeat = Repeat.WEEKLY_REPEAT;
        break;
      default:
    }

    Navigator.pop(context);
  }

  String getMonthAndDay(S translate, DateTime aux) {
    String month = aux.month.toString();
    String day = aux.day.toString();
    month = AlertReminder.months[month];

    Map<String, String> translateMonth = {
      'Jan': translate.Jan,
      'Feb': translate.Feb,
      'Mar': translate.Mar,
      'Apr': translate.Apr,
      'May': translate.May,
      'Jun': translate.Jun,
      'Jul': translate.Jul,
      'Aug': translate.Aug,
      'Sep': translate.Sep,
      'Oct': translate.Oct,
      'Nov': translate.Nov,
      'Dec': translate.Dec,
    };

    DateTime now = getCurrentDate();

    if (aux.year == now.year && aux.month == now.month && aux.day == now.day) {
      return translate.today;
    } else if (aux.year == now.year &&
        aux.month == now.month &&
        aux.day == now.day + 1) {
      return translate.tomorrow;
    }

    month = translateMonth[month];

    return month + ' ' + day;
  }

  String getHourAndMinute(TimeOfDay aux) => aux.format(context);

  DateTime getCurrentDate() => DateTime.now();

  TimeOfDay getCurrentTime() => TimeOfDay.now();

  bool isTimeAllowed(TimeOfDay time) {
    DateTime nowDate = getCurrentDate();
    TimeOfDay nowTime = getCurrentTime();
    if (date.day == nowDate.day) {
      if (nowTime.hour > time.hour) {
        return false;
      } else if (nowTime.hour == time.hour) {
        return false;
      } else {
        return true;
      }
    } else if (date.day < nowDate.day) {
      return false;
    } else {
      return true;
    }
  }

  String getTimeTitle() {
    return getHourAndMinute(time);
  }

  String getDateTitle(S translate) {
    return getMonthAndDay(translate, date);
  }

  String getRepeatTitle(S translate) {
    if (repeat == Repeat.DAILY_REPEAT) {
      return translate.daily;
    } else if (repeat == Repeat.WEEKLY_REPEAT) {
      return translate.weekly;
    } else {
      return translate.no_repeat;
    }
  }

  void getNextPossibleHour() {
    TimeOfDay morning = widget.morningTime;
    TimeOfDay noon = widget.noonTime;
    TimeOfDay afternoon = widget.afternoonTime;
    TimeOfDay night = widget.nightTime;

    List<TimeOfDay> allowedHours = [morning, noon, afternoon, night];

    TimeOfDay nowTime = TimeOfDay.now();

    for (TimeOfDay timeAux in allowedHours) {
      if (nowTime.hour < timeAux.hour) {
        time = timeAux;
        date = DateTime.now();
        return;
      }
    }
    DateTime now = DateTime.now();
    DateTime tomorrow = DateTime(now.year, now.month, now.day + 1);
    date = tomorrow;
    time = morning;
  }

  DateTime date;
  TimeOfDay time;
  String repeat;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    getNextPossibleHour();
    repeat = Repeat.NO_REPEAT;
  }

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    return Theme(
      data: Theme.of(context)
          .copyWith(primaryColor: Theme.of(context).buttonColor),
      child: Builder(
        builder: (BuildContext context) => AlertDialog(
          title: TextGeneric(
            text: widget.hasReminder == true
                ? translate.update_reminder
                : translate.add_a_reminder,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              DropDownMenu(
                hasError: false,
                title: getDateTitle(translate),
                child: <PopupMenuEntry<dynamic>>[
                  PopupMenuItem(
                    height: 40,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          handleDate(AlertReminder.todayReminder, context);
                        });
                      },
                      child: ListTile(
                        leading: TextGeneric(
                          text: translate.today,
                        ),
                      ),
                    ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    height: 40,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          handleDate(AlertReminder.tomorrowReminder, context);
                        });
                      },
                      child: ListTile(
                        leading: TextGeneric(
                          text: translate.tomorrow,
                        ),
                      ),
                    ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    child: InkWell(
                      radius: 40,
                      onTap: () async {
                        await handleDate(
                            AlertReminder.pickADateReminder, context);
                        setState(() {});
                      },
                      child: ListTile(
                        leading: TextGeneric(
                          text: translate.pick_a_date,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              DropDownMenu(
                errorMessage: translate.go_back_time,
                hasError: hasError,
                title: getTimeTitle(),
                child: <PopupMenuEntry<dynamic>>[
                  PopupMenuItem(
                    height: 40,
                    child: isTimeAllowed(widget.morningTime)
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                handleTime(AlertReminder.morning, context);
                              });
                            },
                            child: ListTile(
                              leading: TextGeneric(text: translate.morning),
                              trailing: TextGeneric(
                                  text: widget.morningTime.format(context)),
                            ),
                          )
                        : ListTile(
                            leading: Text(
                              translate.morning,
                              style: TextStyle(color: Colors.grey),
                            ),
                            trailing: Text(
                              widget.morningTime.format(context),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    height: 40,
                    child: isTimeAllowed(widget.noonTime)
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                handleTime(AlertReminder.noon, context);
                              });
                            },
                            child: ListTile(
                              leading: TextGeneric(text: translate.noon),
                              trailing: TextGeneric(
                                  text: widget.noonTime.format(context)),
                            ),
                          )
                        : ListTile(
                            leading: Text(
                              translate.noon,
                              style: TextStyle(color: Colors.grey),
                            ),
                            trailing: Text(
                              widget.noonTime.format(context),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    height: 40,
                    child: isTimeAllowed(widget.afternoonTime)
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                handleTime(AlertReminder.afternoon, context);
                              });
                            },
                            child: ListTile(
                              leading: TextGeneric(text: translate.afternoon),
                              trailing: TextGeneric(
                                  text: widget.afternoonTime.format(context)),
                            ),
                          )
                        : ListTile(
                            leading: Text(
                              translate.afternoon,
                              style: TextStyle(color: Colors.grey),
                            ),
                            trailing: Text(
                              widget.afternoonTime.format(context),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    height: 40,
                    child: isTimeAllowed(widget.nightTime)
                        ? InkWell(
                            onTap: () {
                              setState(() {
                                handleTime(AlertReminder.night, context);
                              });
                            },
                            child: ListTile(
                              leading: TextGeneric(text: translate.night),
                              trailing: TextGeneric(
                                  text: widget.nightTime.format(context)),
                            ),
                          )
                        : ListTile(
                            leading: Text(
                              translate.night,
                              style: TextStyle(color: Colors.grey),
                            ),
                            trailing: Text(
                              widget.nightTime.format(context),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    child: InkWell(
                      radius: 40,
                      onTap: () async {
                        await handleTime(
                            AlertReminder.pickATimeReminder, context);
                        setState(() {});
                      },
                      child: ListTile(
                        leading: TextGeneric(
                          text: translate.pick_a_time,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              DropDownMenu(
                hasError: false,
                title: getRepeatTitle(translate),
                child: <PopupMenuEntry<dynamic>>[
                  PopupMenuItem(
                    height: 40,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          handleRepeat(AlertReminder.noRepeat);
                        });
                      },
                      child: ListTile(
                        leading: TextGeneric(
                          text: translate.no_repeat,
                        ),
                      ),
                    ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    height: 40,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          handleRepeat(AlertReminder.daily);
                        });
                      },
                      child: ListTile(
                        leading: TextGeneric(
                          text: translate.daily,
                        ),
                      ),
                    ),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem(
                    height: 40,
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          handleRepeat(AlertReminder.weekly);
                        });
                      },
                      child: ListTile(
                        leading: TextGeneric(
                          text: translate.weekly,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            widget.hasReminder
                ? FlatButton(
                    onPressed: () {
                      widget.deleteReminder();
                      Navigator.pop(context);
                    },
                    child: TextGeneric(text: translate.delete),
                  )
                : Container(),
            FlatButton(
              onPressed: () => Navigator.pop(context),
              child: TextGeneric(text: translate.cancel),
            ),
            RaisedButton(
              onPressed: () {
                if (hasError) return;
                DateTime scheduledDate = DateTime(
                    date.year, date.month, date.day, time.hour, time.minute, 0);
                widget.createReminder(
                  AlertReminderParams(
                    scheduledDate: scheduledDate,
                    repeat: repeat,
                  ),
                );
                Navigator.pop(context);
              },
              child: TextGeneric(
                text: translate.Ok,
                color: Colors.white,
              ),
              color: Theme.of(context).buttonColor,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utils/Utils.dart';
import '../../components/icon-components/icon-generic.dart';
import '../../components/text-components/text-generic.dart';
import '../../controllers/colors-controller/color-controller.dart';
import '../../controllers/database-controller/hive-controller.dart';
import '../../controllers/reminder-controller/reminder-controller.dart';
import '../../generated/l10n.dart';
import '../home-screen/home-screen.dart' show Arguments;

class DeletedTaskScreen extends StatefulWidget {
  static const String id = 'deleted_task_screen';

  @override
  _DeletedTaskScreenState createState() => _DeletedTaskScreenState();
}

class _DeletedTaskScreenState extends State<DeletedTaskScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  ColorController colorController = ColorController();
  String activeColor;
  String reminder;
  DateTime dateTime;
  TimeOfDay timeOfDay;
  bool expired = false;
  HiveController hC = HiveController();
  Map<String, String> months = {
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

  Color scaffoldColor(String color) {
    if (color == null || color == Theme.of(context).primaryColor.toString()) {
      return Theme.of(context).scaffoldBackgroundColor;
    } else {
      return colorController.getColor(color);
    }
  }

  Color appBarColor(String color) {
    if (color == null ||
        color == Theme.of(context).scaffoldBackgroundColor.toString()) {
      return Theme.of(context).primaryColor;
    } else {
      return colorController.getColor(color);
    }
  }

  Color fabColor(String color) {
    if (color == null) {
      return Theme.of(context).buttonColor;
    } else if (color == Colors.white.toString()) {
      return Theme.of(context).buttonColor;
    } else if (color == Color(0xff303030).toString()) {
      return Theme.of(context).buttonColor;
    } else {
      return Colors.white;
    }
  }

  Color fabIconColor(String color) {
    if (color == null) {
      return Colors.white;
    } else if (color == Colors.white.toString()) {
      return Colors.white;
    } else if (color == Color(0xff303030).toString()) {
      return Colors.white;
    } else {
      return colorController.getColor(color);
    }
  }

  Color appBarTextColor(String color) {
    if (color == null) {
      return null;
    } else if (color == Colors.white.toString()) {
      return Colors.black54;
    } else if (color == Color(0xff303030).toString()) {
      return null;
    } else {
      return Colors.white;
    }
  }

  void initializeDateTime(DateTime reminderDate) {
    if (reminderDate != null) {
      dateTime = reminderDate;
      int hour = dateTime.hour;
      int minute = dateTime.minute;
      timeOfDay = TimeOfDay(hour: hour, minute: minute);
    }
  }

  String getMonthAndDay(S translate, DateTime aux) {
    String month = aux.month.toString();
    String day = aux.day.toString();
    month = months[month];

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

    month = translateMonth[month];

    return month + ' ' + day;
  }

  String getHourAndMinute(TimeOfDay aux) => aux.format(context);

  void updateReminderData(S translate) {
    if (dateTime == null) return;

    String month = getMonthAndDay(translate, dateTime);
    String time = getHourAndMinute(timeOfDay);
    reminder = month + ' | ' + time;
  }

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);
    Arguments args = ModalRoute.of(context).settings.arguments;
    activeColor = args.color;
    expired = args.expired;
    _titleController.text = args.title;
    _noteController.text = args.note;

    initializeDateTime(args.reminderDate);
    updateReminderData(translate);

    return GestureDetector(
      onTap: () {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: TextGeneric(
              text: translate.restore_to_edited,
              color: Theme.of(context).textTheme.headline6.color,
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
        );
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: scaffoldColor(activeColor),
        appBar: AppBar(
          backgroundColor: appBarColor(activeColor),
          leading: IconButton(
            icon: IconGeneric(
              androidIcon: Icons.arrow_back,
              iOSIcon: CupertinoIcons.back,
              semanticLabel: translate.tooltip_previous_screen,
              toolTip: translate.tooltip_previous_screen,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  maxLines: null,
                  minLines: 1,
                  style: TextStyle(
                    fontSize: 25,
                    color: appBarTextColor(activeColor),
                  ),
                  controller: _titleController,
                  enabled: false,
                ),
                Divider(),
                TextField(
                  style: TextStyle(
                    fontSize: 18,
                    color: appBarTextColor(activeColor),
                  ),
                  decoration: InputDecoration(border: InputBorder.none),
                  autocorrect: true,
                  controller: _noteController,
                  maxLines: null,
                  minLines: 1,
                  enabled: false,
                ),
                SizedBox(
                  height: 16,
                ),
                (args.reminderDate != null)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            decoration: BoxDecoration(
                                color: fabColor(activeColor),
                                borderRadius: BorderRadius.circular(8)),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconGeneric(
                                    androidIcon: Icons.alarm,
                                    iOSIcon: CupertinoIcons.clock_solid,
                                    color: scaffoldColor(activeColor),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Flexible(
                                    child: Text(
                                      reminder,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: scaffoldColor(activeColor),
                                        decoration: expired == true
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: IconGeneric(
            androidIcon: Icons.restore_from_trash,
            iOSIcon: Icons.restore_from_trash,
            semanticLabel: translate.restore,
            toolTip: translate.restore,
          ),
          backgroundColor: fabColor(activeColor),
          onPressed: () async {
            Utils.alertDialog(
              context,
              translate.restore_selected_note,
              () => Navigator.pop(context),
              translate.no,
              () {
                Navigator.pop(context);
                hC.restoreFromTrash(args.key);
                ReminderController.scheduleNotification(
                  args.key,
                  _titleController.text,
                  _noteController.text,
                  args.reminderKey,
                  args.reminderDate,
                  args.repeat,
                );
                Navigator.pop(context);
              },
              translate.Ok,
            );
          },
        ),
      ),
    );
  }
}

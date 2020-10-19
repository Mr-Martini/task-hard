import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controllers/colors-controller/color-controller.dart';
import '../../controllers/repeat-controller/repeat-controller.dart';
import '../../controllers/selectedValues-controller/selected-values-controller.dart';
import '../../generated/l10n.dart';
import '../icon-components/icon-generic.dart';

class CardNote extends StatefulWidget {
  final String color;
  final String title;
  final Function onTap;
  final String note;
  final String alarmToolTip;
  final ValueChanged<bool> isSelected;
  final Function onLongPress;
  final int notesCount;
  final DateTime reminderDate;
  final String repeat;
  final double minHeight;
  final double maxHeight;
  final bool expired;

  CardNote({
    this.color,
    this.title,
    this.note,
    @required this.isSelected,
    @required this.onTap,
    @required this.onLongPress,
    this.notesCount,
    this.reminderDate,
    this.alarmToolTip,
    @required this.repeat,
    @required this.minHeight,
    @required this.maxHeight,
    this.expired,
  });

  @override
  _CardNoteState createState() => _CardNoteState();
}

class _CardNoteState extends State<CardNote> {
  bool isSelected = false;
  String alarmText;

  Color getTextColor(String color) {
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

  void getAlarm(DateTime reminderDate, S translate, String repeat) {
    if (reminderDate == null) return;

    Map<String, String> months = {
      '1': translate.jan,
      '2': translate.feb,
      '3': translate.mar,
      '4': translate.apr,
      '5': translate.may,
      '6': translate.jun,
      '7': translate.jul,
      '8': translate.aug,
      '9': translate.sep,
      '10': translate.oct,
      '11': translate.nov,
      '12': translate.dec
    };

    int hour = reminderDate.hour;
    int minute = reminderDate.minute;
    TimeOfDay timeOfDay = TimeOfDay(hour: hour, minute: minute);
    String month = reminderDate.month.toString();
    month = months[month];
    String day = reminderDate.day.toString();

    if (repeat == Repeat.DAILY_REPEAT) {
      alarmText = translate.daily + ' | ' + timeOfDay.format(context);
      return;
    } else if (repeat == Repeat.WEEKLY_REPEAT) {
      String day = DateFormat('EEE').format(reminderDate);
      Map<String, String> dayTranslated = {
        'Mon': translate.monday,
        'Tue': translate.tuesday,
        'Wed': translate.wednesday,
        'Thu': translate.thursday,
        'Fri': translate.friday,
        'Sat': translate.saturday,
        'Sun': translate.sunday,
        'seg': translate.monday,
        'ter': translate.tuesday,
        'qua': translate.wednesday,
        'qui': translate.thursday,
        'sex': translate.friday,
        'sab': translate.saturday,
        'dom': translate.sunday,
      };
      alarmText =
          '${translate.each} ${dayTranslated[day]} | ${timeOfDay.format(context)}';
      return;
    }

    DateTime now = DateTime.now();

    if (reminderDate.year == now.year &&
        reminderDate.month == now.month &&
        reminderDate.day == now.day) {
      alarmText = translate.today + ' | ' + timeOfDay.format(context);
      return;
    } else if (reminderDate.year == now.year &&
        reminderDate.month == now.month &&
        reminderDate.day == now.day + 1) {
      alarmText = translate.tomorrow + ' | ' + timeOfDay.format(context);
      return;
    }

    alarmText = month + ' ' + day + ' | ' + timeOfDay.format(context);
  }

  @override
  Widget build(BuildContext context) {
    SelectedValuesController s = Provider.of<SelectedValuesController>(context);
    S translate = S.of(context);
    getAlarm(widget.reminderDate, translate, widget.repeat);
    if (s.getSelectedItems.isEmpty) {
      setState(() {
        isSelected = false;
      });
    } else if (s.getSelectedItems.length == widget.notesCount) {
      setState(() {
        isSelected = true;
      });
    }
    return Container(
      constraints: BoxConstraints(
          maxHeight: widget.maxHeight, minHeight: widget.minHeight),
      decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor == Colors.white
                  ? Colors.grey[400]
                  : Colors.grey[700]
              : ColorController().getColor(widget.color) ??
                  Theme.of(context).primaryColor,
          border: Border.all(
            width: 1,
            color: isSelected
                ? Colors.grey
                : Theme.of(context).primaryColor == Colors.white
                    ? Colors.grey[500]
                    : Colors.grey[800],
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            if (s.getSelectedItems.isEmpty) {
              widget.onTap();
            } else {
              setState(() {
                isSelected = !isSelected;
                widget.isSelected(isSelected);
              });
            }
          },
          onLongPress: () {
            setState(() {
              isSelected = !isSelected;
              widget.isSelected(isSelected);
            });
          },
          child: Padding(
            padding: EdgeInsets.only(top: 8, right: 8, left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  widget.title ?? '',
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: getTextColor(widget?.color),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Divider(
                  color: Colors.grey[700],
                ),
                Flexible(
                  child: Text(
                    widget.note ?? '',
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: getTextColor(widget?.color),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                widget.reminderDate != null
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              IconGeneric(
                                androidIcon: Icons.alarm,
                                iOSIcon: CupertinoIcons.clock_solid,
                                semanticLabel: widget.alarmToolTip,
                                toolTip: widget.alarmToolTip,
                                size: 18,
                                color: getTextColor(widget?.color),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Flexible(
                                child: Text(
                                  alarmText,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: getTextColor(widget?.color),
                                    decoration: widget.expired == true
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

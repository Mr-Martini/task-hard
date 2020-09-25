import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../Utils/Utils.dart';
import '../../components/chip-component/chip-component.dart';
import '../../components/choose-tag-component/choose-component.dart';
import '../../components/color-selector-component/color-selector-component.dart';
import '../../components/edit-tag-component/edit-tage.dart';
import '../../components/icon-components/icon-generic.dart';
import '../../components/text-components/text-generic.dart';
import '../../controllers/colors-controller/color-controller.dart';
import '../../controllers/database-controller/hive-controller.dart';
import '../../controllers/reminder-controller/reminder-controller.dart';
import '../../controllers/repeat-controller/repeat-controller.dart';
import '../../features/time_preference/presentation/widgets/alert_reminder_container.dart';
import '../../generated/l10n.dart';
import '../home-screen/home-screen.dart' show Arguments;

class NewTask extends StatefulWidget {
  static const String id = 'new_task';

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  HiveController hC = HiveController();
  Map<String, dynamic> noteOnBox = {};
  Arguments args;
  String note;
  String title;
  DateTime reminderDate;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  FocusNode _noteFocusNode = FocusNode();
  String activeColor;
  String reminder;
  bool hasReminder = false;
  bool noteHasTag = false;
  String repeat;
  ColorController colorController = ColorController();
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

  void deleteNote(String key, int reminderKey) async {
    Navigator.pop(context);
    if (isEmpty(title) && isEmpty(note) && !hasReminder) {
      hC.deleteNote(key);
    } else {
      hC.moveToTrash(key);
      ReminderController.cancel(reminderKey);
    }
    Navigator.pop(context);
  }

  void archiveNote(String key, BuildContext contextBuilder, S translate) async {
    Navigator.pop(context);
    if (isEmpty(title) && isEmpty(note) && !hasReminder) {
      Scaffold.of(contextBuilder).showSnackBar(Utils.displaySnackBar(
          translate.cannot_archive_empty_note, contextBuilder));
      return;
    }
    hC.moveToArchive(key);
    Navigator.pop(context);
  }

  void createReminder(String key, int reminderKey, DateTime date,
      TimeOfDay time, String repeat, S translate, BuildContext contextBuilder) {
    Navigator.pop(context);
    DateTime now = DateTime.now();
    DateTime scheduledDate =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);

    if (scheduledDate.isBefore(now)) return;
    if (isEmpty(title) && isEmpty(note)) {
      Scaffold.of(contextBuilder).showSnackBar(
          Utils.displaySnackBar(translate.note_is_empty, contextBuilder));
      return;
    }

    hC.createReminder(key, scheduledDate, repeat, reminderKey);
    ReminderController.scheduleNotification(
        key, title, note, reminderKey, scheduledDate, repeat);
  }

  void deleteReminder(String key, int reminderKey) {
    Navigator.pop(context);
    hC.deleteReminder(key);
    ReminderController.cancel(reminderKey);
  }

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

  Color topAppBarColor(String color) {
    if (color == null || color == Theme.of(context).primaryColor.toString()) {
      return Theme.of(context).scaffoldBackgroundColor;
    } else {
      return colorController.getColor(color);
    }
  }

  Color fabColor(String color) {
    if (color == null) {
      return Theme.of(context).buttonColor;
    } else if (color == Colors.white.toString()) {
      return Theme.of(context).buttonColor;
    } else if (color == Color(0xff212121).toString()) {
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
    } else if (color == Color(0xff212121).toString()) {
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
    } else {
      return Colors.grey[400];
    }
  }

  Color textFieldColor(String color) {
    if (color == null) {
      return null;
    } else if (color == Colors.white.toString()) {
      return Colors.black54;
    } else {
      return Colors.white;
    }
  }

  Color getAppBarIconColor(String color) {
    if (color == null) {
      return Colors.grey[600];
    } else if (color == Colors.white.toString()) {
      return Colors.grey[600];
    } else if (color == Color(0xff212121).toString()) {
      return Colors.grey[500];
    } else {
      return Colors.white;
    }
  }

  Color getDividerColor(String color) {
    if (color == Colors.white.toString()) {
      return Colors.grey[300];
    }
    return DividerThemeData().color;
  }

  void analyzeTitle(String key, String newValue, int reminderKey) {
    title = newValue;
    if (!isEmpty(title) || !isEmpty(note)) {
      hC.writeHive(key, title, note, activeColor);
    }
  }

  void analyzeNote(String key, String newValue, int reminderKey) {
    note = newValue;
    if (!isEmpty(title) || !isEmpty(note)) {
      hC.writeHive(key, title, note, activeColor);
    }
  }

  bool isEmpty(String text) {
    if (text == null) {
      return true;
    } else if (text == '') {
      return true;
    } else {
      return hasEmptyCharacters(text);
    }
  }

  bool hasEmptyCharacters(String text) {
    String aux = text;
    if (aux.replaceAll(RegExp(r"\s+"), '') == '' ||
        aux.replaceAll(RegExp(r"\s+"), '') == null) {
      return true;
    } else {
      return false;
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
    String month = getMonthAndDay(translate, reminderDate);
    TimeOfDay timeOfDay =
        TimeOfDay(hour: reminderDate.hour, minute: reminderDate.minute);
    String time = getHourAndMinute(timeOfDay);
    if (repeat == Repeat.DAILY_REPEAT) {
      reminder = translate.daily + ' | ' + time;
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
      reminder = translate.each + '  ' + dayTranslated[day] + ' | ' + time;
      return;
    }

    DateTime now = DateTime.now();

    if (reminderDate.year == now.year &&
        reminderDate.month == now.month &&
        reminderDate.day == now.day) {
      reminder = translate.today + ' | ' + timeOfDay.format(context);
      return;
    } else if (reminderDate.year == now.year &&
        reminderDate.month == now.month &&
        reminderDate.day == now.day + 1) {
      reminder = translate.tomorrow + ' | ' + timeOfDay.format(context);
      return;
    }

    reminder = month + ' | ' + time;
  }

  void createCopy(BuildContext context, S translate) {
    String key = Uuid().v4();

    hC.createCopy(key, title, note, activeColor, translate);

    Scaffold.of(context).showSnackBar(
      Utils.displaySnackBar(translate.copy_created, context,
          actionMessage: translate.undo, onClick: () async {
        hC.moveToTrash(key);
      }),
    );
  }

  void onSelected(String choice, S translate, BuildContext context) {
    if (choice == translate.create_copy) {
      createCopy(context, translate);
      return;
    }
  }

  void unarchive(String key) {
    Navigator.pop(context);
    hC.restoreFromArchive(key);
    Navigator.pop(context);
  }

  void putTagOnNote(String key, String tagName) {
    hC.putTagOnNote(key, tagName);

    bool hasTag = false;

    for (var tag in hC.getTags()) {
      if (tag['name'] == tagName) {
        hasTag = true;
        break;
      }
    }

    if (!hasTag) {
      String tagKey = Uuid().v4();
      hC.putTag(tagName, tagKey);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteController.dispose();
    _noteFocusNode.dispose();
    activeColor = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    if (args == null) {
      args = ModalRoute.of(context).settings.arguments;

      noteOnBox = Map<String, dynamic>.from(hC.getNote(args.key));

      if (noteOnBox.isNotEmpty) {
        if (isEmpty(title)) {
          _titleController.text = noteOnBox['title'];
          title = noteOnBox['title'];
        }
        if (isEmpty(note)) {
          _noteController.text = noteOnBox['note'];
          note = noteOnBox['note'];
        }

        activeColor = noteOnBox['color'];
      }
    }

    return WillPopScope(
      onWillPop: () async {
        if (isEmpty(title) && isEmpty(note)) {
          hC.deleteNote(args.key);
          ReminderController.cancel(args.reminderKey);
        } else if (hasReminder) {
          ReminderController.scheduleNotification(
              args.key, title, note, args.reminderKey, reminderDate, repeat);
        }
        return true;
      },
      child: GestureDetector(
        onTap: () {
          _noteFocusNode.unfocus();
        },
        child: Scaffold(
          backgroundColor: scaffoldColor(activeColor),
          appBar: AppBar(
            backgroundColor: topAppBarColor(activeColor),
            elevation: 0,
            iconTheme: IconThemeData(color: getAppBarIconColor(activeColor)),
            leading: IconButton(
              onPressed: () {
                if (isEmpty(title) && isEmpty(note)) {
                  hC.deleteNote(args.key);
                  ReminderController.cancel(args.reminderKey);
                } else if (hasReminder) {
                  ReminderController.scheduleNotification(args.key, title, note,
                      args.reminderKey, reminderDate, repeat);
                }
                Navigator.pop(context);
              },
              icon: IconGeneric(
                androidIcon: Icons.arrow_back,
                iOSIcon: CupertinoIcons.back,
                toolTip: translate.tooltip_home_screen,
                color: getAppBarIconColor(activeColor),
              ),
            ),
            title: StreamBuilder(
              stream: Hive.box('notes').watch(key: args.key),
              builder: (context, AsyncSnapshot<BoxEvent> event) {
                noteHasTag = false;
                if (event.data == null) {
                  if (noteOnBox['tags'] == null || noteOnBox['tags'].isEmpty)
                    return Container();
                  noteHasTag = true;
                  List<dynamic> tags = noteOnBox['tags'];
                  String firstTag = tags[0];
                  String message;
                  if (tags.length > 1) {
                    message =
                        '$firstTag ${translate.and} ${tags.length - 1} ${translate.others}';
                  } else {
                    message = firstTag;
                  }
                  return ChipWithBottomSheet(
                    textColor: scaffoldColor(activeColor),
                    backgroundColor: fabColor(activeColor),
                    label: firstTag,
                    message: message,
                    onTap: () {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (BuildContext context, setModalState) {
                              return ChooseTag(
                                noteKey: args.key,
                                deleteTag: (String tagName) {
                                  hC.deleteTagFromNote(args.key, tagName);
                                  setModalState(() {});
                                },
                                updateTag: (String tagName) {
                                  putTagOnNote(args.key, tagName);
                                  setModalState(() {});
                                },
                                multiple: null,
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                }
                if (event.data.value != null) {
                  var data = event.data.value;
                  if (data['tags'] == null || data['tags'].isEmpty)
                    return Container();
                  noteHasTag = true;
                  List<dynamic> tags = data['tags'];
                  String firstTag = tags[0];
                  String message;
                  if (tags.length > 1) {
                    message =
                        '$firstTag ${translate.and} ${tags.length - 1} ${translate.others}';
                  } else {
                    message = firstTag;
                  }
                  return ChipWithBottomSheet(
                    textColor: scaffoldColor(activeColor),
                    backgroundColor: fabColor(activeColor),
                    label: firstTag,
                    message: message,
                    onTap: () {
                      showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (BuildContext context, setModalState) {
                              return ChooseTag(
                                noteKey: args.key,
                                deleteTag: (String tagName) {
                                  hC.deleteTagFromNote(args.key, tagName);
                                  setModalState(() {});
                                },
                                updateTag: (String tagName) {
                                  putTagOnNote(args.key, tagName);
                                  setModalState(() {});
                                },
                                multiple: null,
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                }
                return Container();
              },
            ),
            actions: [
              args.archived == true
                  ? Builder(
                      builder: (BuildContext context) => IconButton(
                        icon: IconGeneric(
                          androidIcon: Icons.archive,
                          iOSIcon: CupertinoIcons.folder_solid,
                          semanticLabel: translate.archive_note,
                          toolTip: translate.unarchive,
                          color: getAppBarIconColor(activeColor),
                        ),
                        onPressed: () async {
                          Utils.alertDialog(
                            context,
                            '${translate.unarchive} ${translate.note_minu}?',
                            () => Navigator.pop(context),
                            translate.no,
                            () => unarchive(args.key),
                            translate.Ok,
                          );
                        },
                      ),
                    )
                  : Builder(
                      builder: (BuildContext context) => IconButton(
                        icon: IconGeneric(
                          androidIcon: Icons.archive,
                          iOSIcon: CupertinoIcons.folder_solid,
                          semanticLabel: translate.archive_note,
                          toolTip: translate.archive_note,
                          color: getAppBarIconColor(activeColor),
                        ),
                        onPressed: () async {
                          Utils.alertDialog(
                            context,
                            translate.archive_note_question,
                            () => Navigator.pop(context),
                            translate.no,
                            () => archiveNote(args.key, context, translate),
                            translate.archive,
                          );
                        },
                      ),
                    ),
              IconButton(
                icon: IconGeneric(
                  androidIcon: FontAwesomeIcons.solidTrashAlt,
                  iOSIcon: FontAwesomeIcons.solidTrashAlt,
                  semanticLabel: translate.delete,
                  toolTip: translate.delete,
                  color: getAppBarIconColor(activeColor),
                  size: 19,
                ),
                onPressed: () async {
                  Utils.alertDialog(
                    context,
                    translate.delete_note_question,
                    () => Navigator.pop(context),
                    translate.no,
                    () => deleteNote(args.key, args.reminderKey),
                    translate.delete,
                  );
                },
              ),
              Builder(
                builder: (BuildContext context) => PopupMenuButton(
                  onSelected: (String choice) {
                    onSelected(choice, translate, context);
                  },
                  itemBuilder: (BuildContext context) {
                    Map<String, IconGeneric> choices = {
                      translate.create_copy: IconGeneric(
                        androidIcon: Icons.content_copy,
                        semanticLabel: translate.create_copy,
                        toolTip: translate.create_copy,
                      ),
                      translate.collaborator: IconGeneric(
                        androidIcon: Icons.person_add,
                        iOSIcon: CupertinoIcons.person_add,
                        semanticLabel: translate.add_person,
                        toolTip: translate.add_person,
                      ),
                      translate.info: IconGeneric(
                        androidIcon: Icons.info,
                        iOSIcon: CupertinoIcons.info,
                        semanticLabel: translate.info,
                        toolTip: translate.info,
                      ),
                    };
                    return choices.keys.map(
                      (String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: ListTile(
                            title: TextGeneric(text: choice),
                            leading: choices[choice],
                          ),
                        );
                      },
                    ).toList();
                  },
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                      fontSize: 25,
                      color: textFieldColor(activeColor),
                    ),
                    autofocus: false,
                    autocorrect: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (value) {
                      _noteFocusNode.requestFocus();
                    },
                    controller: _titleController,
                    decoration: InputDecoration(
                      hintText: translate.note_title,
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 25,
                        color: appBarTextColor(activeColor),
                      ),
                    ),
                    onChanged: (String newValue) {
                      analyzeTitle(args.key, newValue, args.reminderKey);
                    },
                    minLines: 1,
                    maxLines: null,
                  ),
                  Divider(
                    color: getDividerColor(activeColor),
                  ),
                  TextField(
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                      fontSize: 18,
                      color: textFieldColor(activeColor),
                    ),
                    autofocus: false,
                    autocorrect: true,
                    focusNode: _noteFocusNode,
                    controller: _noteController,
                    onChanged: (String newValue) {
                      analyzeNote(args.key, newValue, args.reminderKey);
                    },
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: translate.note_note,
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: appBarTextColor(activeColor),
                      ),
                    ),
                    minLines: 1,
                    maxLines: null,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  StreamBuilder(
                    stream: Hive.box('notes').watch(key: args.key),
                    builder:
                        (BuildContext context, AsyncSnapshot<BoxEvent> event) {
                      reminderDate = null;
                      hasReminder = false;
                      repeat = Repeat.NO_REPEAT;

                      if (event.data == null) {
                        reminderDate = noteOnBox['reminderDate'];
                        if (reminderDate == null) return Container();
                        hasReminder = true;
                        repeat = noteOnBox['repeat'];
                        updateReminderData(translate);
                        return Row(
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
                                      color: fabIconColor(activeColor),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                      child: Text(
                                        reminder,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: fabIconColor(activeColor),
                                          decoration:
                                              noteOnBox['expired'] == true
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
                        );
                      }

                      if (event.data.value != null) {
                        var data = event.data.value;
                        if (data['reminderDate'] == null) return Container();
                        reminderDate = data['reminderDate'];
                        hasReminder = true;
                        repeat = data['repeat'];
                        updateReminderData(translate);
                        return Row(
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
                                      color: fabIconColor(activeColor),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Flexible(
                                      child: Text(
                                        reminder,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: fabIconColor(activeColor),
                                          decoration: data['expired'] == true
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
                        );
                      }
                      return Container();
                    },
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: fabColor(activeColor),
            onPressed: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                ),
                context: context,
                builder: (BuildContext context) => Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      InkWell(
                        onTap: () {},
                        child: ListTile(
                          title: TextGeneric(text: translate.voice_recording),
                          leading: IconGeneric(
                            androidIcon: Icons.keyboard_voice,
                            iOSIcon: CupertinoIcons.mic_solid,
                          ),
                          subtitle: TextGeneric(
                            text: translate.attach_voice_record,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Divider(),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          showModal(
                            configuration: FadeScaleTransitionConfiguration(),
                            context: context,
                            builder: (BuildContext context) {
                              return EditTag(
                                hasTag: noteHasTag,
                                deleteTag: () {
                                  Navigator.pop(context);
                                  hC.deleteAllTagsFromNote(args.key);
                                },
                                updateTag: (String tagName) {
                                  Navigator.pop(context);
                                  putTagOnNote(args.key, tagName);
                                },
                                chooseTag: () {
                                  showModalBottomSheet(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20),
                                      ),
                                    ),
                                    isScrollControlled: true,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return StatefulBuilder(
                                        builder: (context, setModalState) =>
                                            ChooseTag(
                                          noteKey: args.key,
                                          deleteTag: (String tagName) {
                                            hC.deleteTagFromNote(
                                                args.key, tagName);
                                            setModalState(() {});
                                          },
                                          updateTag: (String tagName) {
                                            putTagOnNote(args.key, tagName);
                                            setModalState(() {});
                                          },
                                          multiple: null,
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        },
                        child: ListTile(
                          title: TextGeneric(text: translate.add_a_tag),
                          leading: IconGeneric(
                            androidIcon: Icons.label,
                            iOSIcon: CupertinoIcons.tag_solid,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
            child: IconGeneric(
              androidIcon: Icons.add,
              iOSIcon: CupertinoIcons.add_circled_solid,
              color: fabIconColor(activeColor),
              semanticLabel: translate.add,
              toolTip: translate.add,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            color: appBarColor(activeColor),
            shape: CircularNotchedRectangle(),
            notchMargin: 8,
            elevation: 12,
            child: Container(
              height: kBottomNavigationBarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Flexible(
                    child: InkResponse(
                      radius: 40,
                      containedInkWell: false,
                      onTap: () {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                          ),
                          context: context,
                          builder: (BuildContext context) => ColorSelector(
                            onTap: (Color color) async {
                              hC.updateColor(args.key, color.toString());
                              setState(() {
                                activeColor = color.toString();
                              });
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                      child: Container(
                        constraints: BoxConstraints(
                          minWidth: 60,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            IconGeneric(
                                androidIcon: Icons.palette,
                                iOSIcon: CupertinoIcons.tag_solid,
                                size: 24,
                                semanticLabel: translate.change_color,
                                toolTip: translate.change_color,
                                color: getAppBarIconColor(activeColor)),
                            Text(
                              translate.color,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                  color: getAppBarIconColor(activeColor),
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(),
                  Builder(
                    builder: (BuildContext contextBuilder) => Flexible(
                      child: InkResponse(
                        containedInkWell: false,
                        radius: 40,
                        onTap: () async {
                          showModal(
                            configuration: FadeScaleTransitionConfiguration(),
                            context: context,
                            builder: (BuildContext context) {
                              return AlertReminderContainer(
                                hasReminder: hasReminder,
                                deleteReminder: () =>
                                    deleteReminder(args.key, args.reminderKey),
                                updateReminder: (List<dynamic> values) =>
                                    createReminder(
                                  args.key,
                                  args.reminderKey,
                                  values[0],
                                  values[1],
                                  values[2],
                                  translate,
                                  contextBuilder,
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          constraints: BoxConstraints(
                            minWidth: 60,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              IconGeneric(
                                  androidIcon: Icons.add_alert,
                                  iOSIcon: CupertinoIcons.clock_solid,
                                  size: 24,
                                  semanticLabel: translate.add_a_reminder,
                                  toolTip: translate.add_a_reminder,
                                  color: getAppBarIconColor(activeColor)),
                              Text(
                                translate.alarm,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: getAppBarIconColor(activeColor)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

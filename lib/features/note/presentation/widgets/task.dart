import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_hard/components/color-selector-component/color-selector-component.dart';
import 'package:task_hard/components/icon-components/icon-generic.dart';
import 'package:task_hard/components/text-components/text-generic.dart';
import 'package:task_hard/controllers/colors-controller/color-controller.dart';
import 'package:task_hard/core/Utils/alert_dialog.dart';
import 'package:task_hard/core/Utils/date_formater.dart';
import 'package:task_hard/core/Utils/snackbar_context.dart';
import 'package:task_hard/features/note/presentation/bloc/note_bloc.dart';
import 'package:task_hard/features/time_preference/presentation/widgets/alert_reminder_container.dart';
import 'package:task_hard/generated/l10n.dart';
import 'package:uuid/uuid.dart';

enum options { createACopy, delete }

class Task extends StatefulWidget {
  final String title;
  final String note;
  final Color color;
  final String noteKey;
  final GlobalKey<ScaffoldState> scaffoldKey;

  Task({
    Key key,
    @required this.title,
    @required this.note,
    @required this.color,
    @required this.noteKey,
    @required this.scaffoldKey,
  }) : super(key: key);

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  DateTime reminder;
  final FocusNode _noteFocusNode = FocusNode();
  final FocusNode _titleFocusNode = FocusNode();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final ColorController cC = ColorController();
  Color color;
  String title;
  String note;

  @override
  void initState() {
    super.initState();
    title = widget.title;
    note = widget.note;
    _titleController.text = widget.title;
    _noteController.text = widget.note;
    color = widget.color;
  }

  @override
  void dispose() {
    _noteFocusNode.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  void updateReminder(DateTime reminder, TimeOfDay time, String repeat) {
    Navigator.pop(context);
    BlocProvider.of<NoteBloc>(context).add(
      WriteNoteReminder(
        reminder: reminder,
        time: time,
        repeat: repeat,
        key: widget.noteKey,
        title: title,
        message: note,
      ),
    );
  }

  void deleteReminder() {
    Navigator.pop(context);
    BlocProvider.of<NoteBloc>(context).add(
      DeleteNoteReminder(
        key: widget.noteKey,
      ),
    );
  }

  void changeColor(Color newColor) {
    Navigator.pop(context);
    BlocProvider.of<NoteBloc>(context).add(
      WriteNoteColor(
        color: newColor,
        key: widget.noteKey,
      ),
    );
    setState(() {
      color = newColor;
    });
  }

  void onSelected(options option, S translate) {
    switch (option) {
      case options.delete:
        ShowDialog.alertDialog(
          title: translate.move_note_to_trash,
          flatText: translate.cancel,
          context: context,
          icon: FontAwesomeIcons.trashAlt,
          raisedText: translate.Ok,
          raisedOnPressed: () {
            BlocProvider.of<NoteBloc>(context)
                .add(DeleteNote(key: widget.noteKey));
            Navigator.pop(context);
            Navigator.pop(context);
          },
        );
        break;
      case options.createACopy:
        ShowDialog.alertDialog(
          title: '${translate.create_copy}?',
          flatText: translate.cancel,
          context: context,
          material: true,
          icon: Icons.copy,
          raisedText: translate.Ok,
          raisedOnPressed: () {
            String key = Uuid().v4();
            BlocProvider.of<NoteBloc>(context).add(
              CopyNote(
                key: key,
                title: title,
                content: note,
                color: color,
              ),
            );
            Navigator.pop(context);
            ShowSnackBar.show(
              context: context,
              title: translate.copy_created,
              actionMessage: translate.undo,
              action: () {
                BlocProvider.of<NoteBloc>(context).add(DeleteNote(key: key));
              },
            );
          },
        );
        break;
    }
  }

  void archiveNote(S translate) {
    ShowDialog.alertDialog(
      context: context,
      flatText: translate.cancel,
      icon: Icons.archive,
      material: true,
      title: translate.archive_note_question,
      raisedOnPressed: () {
        BlocProvider.of<NoteBloc>(context).add(
          ArchiveNote(
            key: widget.noteKey,
          ),
        );
        Navigator.pop(context);
        Navigator.pop(context);
      },
      raisedText: translate.Ok,
    );
  }

  void onChangedNote(String value) {
    note = value;
    BlocProvider.of<NoteBloc>(context).add(
      WriteNoteContent(content: value, key: widget.noteKey),
    );
  }

  void onChangedTitle(String value) {
    title = value;
    BlocProvider.of<NoteBloc>(context).add(
      WriteNoteTitle(title: value, key: widget.noteKey),
    );
  }

  Color getFABcolor() {
    if (color == cC.getDark || color == cC.getWhite) {
      return Theme.of(context).buttonColor;
    }
    return Colors.white;
  }

  Color getScaffoldColor() {
    if (color == Theme.of(context).primaryColor) {
      return Theme.of(context).scaffoldBackgroundColor;
    }
    return color;
  }

  Color getIconsColor() {
    if (color == cC.getDark) {
      return Colors.grey;
    } else if (color == cC.getWhite) {
      return Colors.black87;
    }
    return Colors.white;
  }

  TextTheme getTextColor() {
    if (color == Theme.of(context).primaryColor) {
      return Theme.of(context).textTheme;
    } else if (color == cC.getDark) {
      return Typography.whiteRedmond;
    } else if (color == cC.getWhite) {
      return Typography.blackRedmond;
    }
    return Typography.whiteRedmond;
  }

  Color getFABchildColor() {
    if (color == cC.getDark || color == cC.getWhite) {
      return Colors.white;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    return GestureDetector(
      onTap: () {
        _noteFocusNode.unfocus();
        _titleFocusNode.unfocus();
        Scaffold.of(context).hideCurrentSnackBar();
      },
      child: Theme(
        data: Theme.of(context).copyWith(
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: getFABcolor(),
          ),
          scaffoldBackgroundColor: getScaffoldColor(),
          iconTheme: IconThemeData(
            color: getIconsColor(),
          ),
          appBarTheme: AppBarTheme(
            color: getScaffoldColor(),
            iconTheme: IconThemeData(
              color: getIconsColor(),
            ),
          ),
          bottomAppBarColor: getScaffoldColor(),
          textTheme: getTextColor(),
        ),
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: BackButton(),
            actions: [
              IconButton(
                icon: Icon(Icons.archive),
                onPressed: () => archiveNote(translate),
              ),
              PopupMenuButton(
                onSelected: (option) => onSelected(option, translate),
                itemBuilder: (BuildContext context) {
                  Color textColor =
                      Theme.of(context).primaryColor == Colors.white
                          ? Typography.blackRedmond.bodyText1.color
                          : Typography.whiteRedmond.bodyText1.color;

                  return <PopupMenuEntry<options>>[
                    PopupMenuItem<options>(
                      value: options.createACopy,
                      child: ListTile(
                        leading: Icon(
                          FontAwesomeIcons.copy,
                          color: textColor,
                        ),
                        title: Text(
                          translate.create_copy,
                          style: TextStyle(
                            color: textColor,
                          ),
                        ),
                        subtitle: Divider(),
                      ),
                    ),
                    PopupMenuItem<options>(
                      value: options.delete,
                      child: ListTile(
                        leading: Icon(
                          FontAwesomeIcons.trashAlt,
                          color: textColor,
                        ),
                        title: Text(
                          translate.delete,
                          style: TextStyle(
                            color: textColor,
                          ),
                        ),
                        subtitle: Divider(),
                      ),
                    ),
                  ];
                },
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
                        color: Colors.grey,
                      ),
                    ),
                    onChanged: onChangedTitle,
                    minLines: 1,
                    maxLines: null,
                  ),
                  Divider(),
                  TextField(
                    textCapitalization: TextCapitalization.sentences,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                    autofocus: false,
                    autocorrect: true,
                    focusNode: _noteFocusNode,
                    controller: _noteController,
                    onChanged: onChangedNote,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: translate.note_note,
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    minLines: 1,
                    maxLines: null,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<NoteBloc, NoteState>(
                    builder: (context, state) {
                      if (state is NoteInitial) {
                        BlocProvider.of<NoteBloc>(context).add(
                          GetNoteByKey(
                            key: widget.noteKey,
                          ),
                        );
                      }
                      if (state is Loaded) {
                        if (state.note == null) return Container();
                        if (state.note.reminder == null) return Container();
                        var note = state.note;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Chip(
                              backgroundColor: getFABcolor(),
                              clipBehavior: Clip.antiAlias,
                              label: Text(
                                DateFormater.format(
                                  context: context,
                                  translate: translate,
                                  date: note.reminder,
                                  repeat: note.repeat,
                                ),
                                style: TextStyle(
                                  color: getFABchildColor(),
                                ),
                              ),
                              avatar: Icon(
                                Icons.alarm,
                                color: getFABchildColor(),
                              ),
                            ),
                          ],
                        );
                      }
                      return Container();
                    },
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
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
                          leading: Icon(
                            Icons.keyboard_voice,
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
              semanticLabel: translate.add,
              toolTip: translate.add,
              color: getFABchildColor(),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomAppBar(
            clipBehavior: Clip.antiAlias,
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
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return ColorSelector(
                              onTap: changeColor,
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
                            Icon(
                              Icons.palette,
                            ),
                            Text(
                              translate.color,
                              overflow: TextOverflow.visible,
                              style: TextStyle(fontSize: 14),
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
                            builder: (context) {
                              return AlertReminderContainer(
                                hasReminder: reminder != null,
                                deleteReminder: deleteReminder,
                                updateReminder: (values) => updateReminder(
                                  values[0],
                                  values[1],
                                  values[2],
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
                              Icon(
                                Icons.add_alert,
                              ),
                              Text(
                                translate.alarm,
                                overflow: TextOverflow.visible,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_hard/features/archive_notes/presentation/bloc/archivednotes_bloc.dart'
    as aN;
import 'package:task_hard/features/delete_notes/presentation/bloc/deletednotes_bloc.dart';
import 'package:task_hard/features/home_notes/presentation/bloc/homenotes_bloc.dart'
    as hN;
import 'package:task_hard/features/note_reminder/presentation/widgets/note_reminder.dart';
import 'package:task_hard/features/note_tags/presentation/widgets/note_tags.dart';
import 'package:task_hard/generated/l10n.dart';

import '../../../../components/icon-components/icon-generic.dart';
import '../../../../controllers/colors-controller/color-controller.dart';
import '../../../../core/Utils/write_on.dart';

class DeletedTask extends StatefulWidget {
  final String title;
  final String note;
  final Color color;
  final String noteKey;
  final WriteOn box;
  final GlobalKey<ScaffoldState> scaffoldKey;

  static const String id = 'deleted_note';

  DeletedTask({
    Key key,
    @required this.title,
    @required this.note,
    @required this.color,
    @required this.noteKey,
    @required this.box,
    @required this.scaffoldKey,
  }) : super(key: key);

  @override
  _DeletedTaskState createState() => _DeletedTaskState();
}

class _DeletedTaskState extends State<DeletedTask> {
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

  void updateNoteOnExit() {
    switch (widget.box) {
      case WriteOn.home:
        BlocProvider.of<hN.HomenotesBloc>(widget.scaffoldKey.currentContext)
            .add(hN.GetHomeNotes());
        break;
      case WriteOn.archive:
        BlocProvider.of<aN.ArchivedNotesBloc>(widget.scaffoldKey.currentContext)
            .add(aN.GetArchivedNotes());
        break;
      default:
        BlocProvider.of<DeletedNotesBloc>(widget.scaffoldKey.currentContext)
            .add(GetDeletedNotes());
    }
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

    return WillPopScope(
      onWillPop: () async {
        updateNoteOnExit();
        return true;
      },
      child: GestureDetector(
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
              title: NoteTags(
                chipBackgroundColor: getFABcolor(),
                textColor: getFABchildColor(),
                noteKey: widget.noteKey,
                box: widget.box,
              ),
              actions: [],
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
                      enabled: false,
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
                      enabled: false,
                      focusNode: _noteFocusNode,
                      controller: _noteController,
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
                    TaskReminder(
                      noteKey: widget.noteKey,
                      fabChildColor: getFABchildColor(),
                      fabColor: getFABcolor(),
                      translate: translate,
                    ),
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: IconGeneric(
                androidIcon: Icons.restore_from_trash,
                iOSIcon: Icons.restore_from_trash,
                semanticLabel: translate.restore,
                toolTip: translate.restore,
                color: getFABchildColor(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

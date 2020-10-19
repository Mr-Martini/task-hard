import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Utils/date_formater.dart';
import '../../../../generated/l10n.dart';
import '../bloc/notereminder_bloc.dart';

class TaskReminder extends StatefulWidget {
  final String noteKey;
  final Color fabColor;
  final Color fabChildColor;
  final S translate;
  const TaskReminder({
    Key key,
    @required this.noteKey,
    @required this.fabChildColor,
    @required this.fabColor,
    @required this.translate,
  }) : super(key: key);

  @override
  _TaskReminderState createState() => _TaskReminderState();
}

class _TaskReminderState extends State<TaskReminder> {
  Timer _timer;

  void expireChecker(DateTime reminder) {
    _timer?.cancel();
    if (reminder == null) return;
    DateTime now = DateTime.now();
    if (reminder.isAfter(now)) {
      reminder = reminder.add(Duration(seconds: 5));
      Duration duration = reminder.difference(now);
      _timer = Timer(
        duration,
        () {
          BlocProvider.of<NoteReminderBloc>(context).add(
            GetNoteReminder(
              noteKey: widget.noteKey,
            ),
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteReminderBloc, NoteReminderState>(
      builder: (context, state) {
        if (state is NoteReminderInitial) {
          BlocProvider.of<NoteReminderBloc>(context).add(
            GetNoteReminder(
              noteKey: widget.noteKey,
            ),
          );
        }
        if (state is Loaded) {
          DateTime reminder = state.reminder;
          String repeat = state.repeat;
          bool expired = state.expired;
          expireChecker(reminder);
          if (reminder == null) return Container();
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Chip(
                backgroundColor: widget.fabColor,
                clipBehavior: Clip.antiAlias,
                label: Text(
                  DateFormater.format(
                    context: context,
                    translate: widget.translate,
                    date: reminder,
                    repeat: repeat,
                  ),
                  style: TextStyle(
                    color: widget.fabChildColor,
                    decoration: expired
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                avatar: Icon(
                  Icons.alarm,
                  color: widget.fabChildColor,
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}

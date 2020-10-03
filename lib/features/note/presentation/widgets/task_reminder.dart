import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_hard/core/Utils/date_formater.dart';
import 'package:task_hard/features/note/presentation/bloc/note_bloc.dart';
import 'package:task_hard/generated/l10n.dart';

class TaskReminder extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is NoteInitial) {
          BlocProvider.of<NoteBloc>(context).add(
            GetNoteByKey(
              key: noteKey,
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
                backgroundColor: fabColor,
                clipBehavior: Clip.antiAlias,
                label: Text(
                  DateFormater.format(
                    context: context,
                    translate: translate,
                    date: note.reminder,
                    repeat: note.repeat,
                  ),
                  style: TextStyle(
                    color: fabChildColor,
                    decoration: note.expired
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                avatar: Icon(
                  Icons.alarm,
                  color: fabChildColor,
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_hard/features/note/presentation/bloc/note_bloc.dart';

class NoteTags extends StatelessWidget {
  final Color chipBackgroundColor;
  final Color textColor;
  const NoteTags({
    Key key,
    @required this.chipBackgroundColor,
    @required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is Loaded) {
          var note = state.note;
          if (note == null || note.tags == null) return Container();
          if (note.tags.isEmpty) return Container();
          List tags = note.tags;
          String tagText = tags.join(', ');
          return Chip(
            backgroundColor: chipBackgroundColor,
            label: Text(
              tagText,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: textColor,
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

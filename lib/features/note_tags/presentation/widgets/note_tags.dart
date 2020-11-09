import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Utils/write_on.dart';
import '../bloc/notetags_bloc.dart';

class NoteTags extends StatelessWidget {
  final Color chipBackgroundColor;
  final Color textColor;
  final String noteKey;
  final WriteOn box;
  const NoteTags({
    Key key,
    @required this.chipBackgroundColor,
    @required this.textColor,
    @required this.noteKey,
    @required this.box,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteTagsBloc, NoteTagsState>(
      builder: (context, state) {
        if (state is NoteTagsInitial) {
          BlocProvider.of<NoteTagsBloc>(context).add(
            GetTags(
              noteKey: noteKey,
              box: box,
            ),
          );
        }
        if (state is Loaded) {
          List<String> tags = state.tags;

          if (tags.isEmpty) {
            return Container();
          }

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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_hard/features/home_app_bar/presentation/bloc/homeappbar_bloc.dart'
    as sN;
import 'package:task_hard/features/home_notes/presentation/bloc/homenotes_bloc.dart'
    as hN;
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/tags/presentation/bloc/tags_bloc.dart';
import 'package:task_hard/generated/l10n.dart';

import '../../../../components/empty-folder-component/empty-folder.dart';

class TagsListBody extends StatefulWidget {
  final BuildContext selectedNotesContext;
  final List<Note> notes;
  TagsListBody({
    Key key,
    @required this.notes,
    @required this.selectedNotesContext,
  }) : super(key: key);

  @override
  _TagsListBodyState createState() => _TagsListBodyState();
}

class _TagsListBodyState extends State<TagsListBody> {
  void onChanged(bool notContains, String tagName, List<Note> notes) {
    if (notContains) {
      BlocProvider.of<TagsBloc>(context).add(
        AddTagOnList(
          tagName: tagName,
          notes: List<Note>.from(notes),
        ),
      );
    }
    BlocProvider.of<hN.HomenotesBloc>(widget.selectedNotesContext)
        .add(hN.GetHomeNotes());
  }

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    return BlocBuilder<TagsBloc, TagsState>(
      builder: (context, state) {
        if (state is TagsInitial) {
          BlocProvider.of<TagsBloc>(context).add(
            GetTagForList(
              notes: widget.notes,
            ),
          );
        } else if (state is Loaded) {
          List<String> tags = state.tags;
          List<Note> notes = state.noteList;
          if (tags.isEmpty) {
            return EmptyFolder(
              androidIcon: Icons.label,
              title: translate.no_tags,
              iOSIcon: Icons.label,
              toolTip: translate.no_tags,
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: tags.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.label),
                title: Text(tags[index]),
                trailing: Checkbox(
                  activeColor: Theme.of(context).buttonColor,
                  value: notes.every(
                    (note) => note.tags?.contains(tags[index]) ?? false,
                  ),
                  onChanged: (bool value) =>
                      onChanged(value, tags[index], notes),
                ),
              );
            },
          );
        }
        return Container();
      },
    );
  }
}

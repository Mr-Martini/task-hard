import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_hard/features/note_tags/presentation/bloc/notetags_bloc.dart'
    as nT;

import '../../../../components/empty-folder-component/empty-folder.dart';
import '../../../../generated/l10n.dart';
import '../bloc/tags_bloc.dart';

class TagsList extends StatefulWidget {
  final BuildContext blocsContext;
  final String noteKey;
  const TagsList({
    @required this.blocsContext,
    @required this.noteKey,
    Key key,
  }) : super(key: key);

  @override
  _TagsListState createState() => _TagsListState();
}

class _TagsListState extends State<TagsList> {
  void onChanged(bool notContains, String tagName) {
    if (notContains) {
      BlocProvider.of<TagsBloc>(context).add(
        AddTagOnNote(
          tagName: tagName,
          noteKey: widget.noteKey,
        ),
      );
      BlocProvider.of<nT.NoteTagsBloc>(widget.blocsContext).add(
        nT.GetTags(
          noteKey: widget.noteKey,
        ),
      );
    } else {
      BlocProvider.of<TagsBloc>(context).add(
        RemoveTagFromNote(
          tagName: tagName,
          noteKey: widget.noteKey,
        ),
      );
      BlocProvider.of<nT.NoteTagsBloc>(widget.blocsContext).add(
        nT.GetTags(
          noteKey: widget.noteKey,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    return BlocBuilder<TagsBloc, TagsState>(
      builder: (context, state) {
        if (state is TagsInitial) {
          BlocProvider.of<TagsBloc>(context)
              .add(GetTags(noteKey: widget.noteKey));
        } else if (state is Loaded) {
          List<String> tags = state.tags;
          List<String> noteTags = state.noteTags;
          if (tags.isEmpty) {
            return EmptyFolder(
              androidIcon: Icons.label,
              title: translate.no_tags,
              iOSIcon: Icons.label,
              toolTip: translate.no_tags,
            );
          }
          return ListView.builder(
            itemCount: tags.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.label),
                title: Text(tags[index]),
                trailing: Checkbox(
                  activeColor: Theme.of(context).buttonColor,
                  value: noteTags.contains(tags[index]),
                  onChanged: (bool value) => onChanged(value, tags[index]),
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

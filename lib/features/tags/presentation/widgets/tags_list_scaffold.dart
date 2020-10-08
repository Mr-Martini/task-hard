import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_hard/dependency_container.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/tags/presentation/bloc/tags_bloc.dart';
import 'package:task_hard/features/tags/presentation/widgets/tags_list_app_bar.dart';
import 'package:task_hard/features/tags/presentation/widgets/tags_list_body.dart';

class TagsListScaffold extends StatefulWidget {
  final BuildContext selectedNotesContext;
  final List<Note> notes;
  TagsListScaffold({
    Key key,
    @required this.notes,
    @required this.selectedNotesContext,
  }) : super(key: key);

  @override
  _TagsListScaffoldState createState() => _TagsListScaffoldState();
}

class _TagsListScaffoldState extends State<TagsListScaffold> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TagsBloc>(),
      child: Scaffold(
        appBar: TagsListAppBar(
          notes: widget.notes,
          selectedNotesContext: widget.selectedNotesContext,
        ),
        body: TagsListBody(
          selectedNotesContext: widget.selectedNotesContext,
          notes: widget.notes,
        ),
      ),
    );
  }
}

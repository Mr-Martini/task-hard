import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Utils/write_on.dart';
import '../../../../dependency_container.dart';
import '../../../note/domain/entities/note.dart';
import '../bloc/tags_bloc.dart';
import 'tags_list_app_bar.dart';
import 'tags_list_body.dart';

class TagsListScaffold extends StatefulWidget {
  final BuildContext selectedNotesContext;
  final List<Note> notes;
  final WriteOn box;
  TagsListScaffold({
    Key key,
    @required this.notes,
    @required this.selectedNotesContext,
    @required this.box,
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
          box: widget.box,
        ),
        body: TagsListBody(
          selectedNotesContext: widget.selectedNotesContext,
          notes: widget.notes,
          box: widget.box,
        ),
      ),
    );
  }
}

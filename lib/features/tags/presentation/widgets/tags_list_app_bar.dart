import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_hard/features/archive_notes/presentation/bloc/archivednotes_bloc.dart';

import '../../../../core/Utils/write_on.dart';
import '../../../../generated/l10n.dart';
import '../../../home_notes/presentation/bloc/homenotes_bloc.dart';
import '../../../note/domain/entities/note.dart';
import '../bloc/tags_bloc.dart';

class TagsListAppBar extends StatefulWidget implements PreferredSizeWidget {
  final BuildContext selectedNotesContext;
  final List<Note> notes;
  final WriteOn box;
  TagsListAppBar({
    Key key,
    @required this.selectedNotesContext,
    @required this.notes,
    @required this.box,
  }) : super(key: key);

  @override
  _TagsListAppBarState createState() => _TagsListAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(55);
}

class _TagsListAppBarState extends State<TagsListAppBar> {
  FocusNode _focusNode;
  TextEditingController _controller;
  String _text;

  void onAdd() {
    _controller.clear();
    _focusNode.unfocus();
    BlocProvider.of<TagsBloc>(context).add(
      AddTagOnList(
        tagName: _text.trim(),
        notes: widget.notes,
        box: widget.box,
      ),
    );
    switch (widget.box) {
      case WriteOn.home:
        BlocProvider.of<HomenotesBloc>(widget.selectedNotesContext)
            .add(GetHomeNotes());
        break;
      case WriteOn.archive:
        BlocProvider.of<ArchivedNotesBloc>(widget.selectedNotesContext)
            .add(GetArchivedNotes());
        break;
      default:
    }
  }

  void onChanged(String newText) {
    setState(() {
      _text = newText;
    });
  }

  bool isEmpty() {
    if (_text == null || _text == '') {
      return true;
    } else if (_text.trim() == '') {
      return true;
    }
    return false;
  }

  @override
  void initState() {
    _focusNode = FocusNode();
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final S translate = S.of(context);

    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
      title: Container(
        height: 40,
        child: TextField(
          focusNode: _focusNode,
          onChanged: onChanged,
          cursorColor: Theme.of(context).buttonColor,
          decoration: InputDecoration(
            hintText: translate.type_a_new_tag,
            border: InputBorder.none,
          ),
        ),
      ),
      actions: [
        FlatButton(
          textColor: Theme.of(context).buttonColor,
          onPressed: isEmpty() ? null : onAdd,
          child: Text(translate.add),
        ),
      ],
    );
  }
}

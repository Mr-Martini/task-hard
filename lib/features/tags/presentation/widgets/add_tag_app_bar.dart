import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_hard/core/Utils/write_on.dart';
import 'package:task_hard/features/note_tags/presentation/bloc/notetags_bloc.dart'
    as nT;
import 'package:task_hard/features/tags/presentation/bloc/tags_bloc.dart';
import 'package:task_hard/generated/l10n.dart';

class AddTagAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String noteKey;
  final BuildContext blocsContext;
  final WriteOn box;

  AddTagAppBar({
    Key key,
    @required this.noteKey,
    @required this.blocsContext,
    @required this.box,
  }) : super(key: key);

  @override
  _AddTagAppBarState createState() => _AddTagAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(55);
}

class _AddTagAppBarState extends State<AddTagAppBar> {
  FocusNode _focusNode;
  String _text;

  void onAdd() {
    _focusNode.unfocus();
    BlocProvider.of<TagsBloc>(context).add(
      AddTagOnNote(
        tagName: _text.trim(),
        noteKey: widget.noteKey,
        box: widget.box,
      ),
    );
    BlocProvider.of<nT.NoteTagsBloc>(widget.blocsContext).add(
      nT.GetTags(
        noteKey: widget.noteKey,
      ),
    );
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
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
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

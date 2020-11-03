import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_hard/core/Utils/write_on.dart';

import '../../../../dependency_container.dart';
import '../bloc/tags_bloc.dart';
import 'add_tag_app_bar.dart';
import 'tags.dart';

class AddTag extends StatefulWidget {
  final BuildContext blocsContext;
  final String noteKey;
  final WriteOn box;

  AddTag({
    @required this.blocsContext,
    @required this.noteKey,
    Key key,
    @required this.box,
  }) : super(key: key);

  @override
  _AddTagState createState() => _AddTagState();
}

class _AddTagState extends State<AddTag> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TagsBloc>(),
      child: Scaffold(
        appBar: AddTagAppBar(
          blocsContext: widget.blocsContext,
          noteKey: widget.noteKey,
          box: widget.box,
        ),
        body: TagsList(
          blocsContext: widget.blocsContext,
          noteKey: widget.noteKey,
          box: widget.box,
        ),
      ),
    );
  }
}

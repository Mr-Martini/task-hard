import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Utils/arguments.dart';
import '../../../../dependency_container.dart';
import '../../../note_reminder/presentation/bloc/notereminder_bloc.dart';
import '../../../note_tags/presentation/bloc/notetags_bloc.dart';
import 'deleted_note_page.dart';

class DeletedTaskContainer extends StatelessWidget {
  static const String id = 'deleted_note';
  const DeletedTaskContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Arguments args = ModalRoute.of(context).settings.arguments;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<NoteTagsBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<NoteReminderBloc>(),
        ),
      ],
      child: DeletedTask(
        color: args.color,
        title: args.title,
        note: args.note,
        box: args.box,
        noteKey: args.key,
        scaffoldKey: args.scaffoldKey,
      ),
    );
  }
}

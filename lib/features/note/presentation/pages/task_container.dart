import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Utils/arguments.dart';
import '../../../../dependency_container.dart';
import '../../../note_reminder/presentation/bloc/notereminder_bloc.dart';
import '../../../note_tags/presentation/bloc/notetags_bloc.dart';
import '../bloc/note_bloc.dart';
import '../widgets/task.dart';

class TaskContainer extends StatelessWidget {
  static const String id = 'task_container';

  const TaskContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Arguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<NoteBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<NoteReminderBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<NoteTagsBloc>(),
          ),
        ],
        child: Task(
          title: args.title,
          note: args.note,
          color: args.color,
          noteKey: args.key,
          scaffoldKey: args.scaffoldKey,
        ),
      ),
    );
  }
}

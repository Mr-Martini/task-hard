import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_hard/features/note/presentation/bloc/note_bloc.dart';
import 'package:task_hard/features/note/presentation/widgets/task.dart';
import 'package:task_hard/core/Utils/arguments.dart';

import '../../../../dependency_container.dart';

class TaskContainer extends StatelessWidget {
  static const String id = 'task_container';

  const TaskContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Arguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: BlocProvider(
        create: (context) => sl<NoteBloc>(),
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

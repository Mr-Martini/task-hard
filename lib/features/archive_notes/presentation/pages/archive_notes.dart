import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dependency_container.dart';
import '../../../../generated/l10n.dart';
import '../bloc/archivednotes_bloc.dart';
import '../widgets/archived_notes_body.dart';


class ArchivedNotesScreen extends StatelessWidget {

  static const String id = 'archived_screen';

  const ArchivedNotesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    S translate = S.of(context);

    return BlocProvider(
      create: (context) => sl<ArchivedNotesBloc>(),
      child: Scaffold(
        appBar: AppBar(),
        body: ArchivedNotesBody(translate: translate),
      ),
    );
  }
}
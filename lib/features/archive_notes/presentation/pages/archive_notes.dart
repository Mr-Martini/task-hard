import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/Utils/archive_selected_notes.dart';
import '../../../../core/Utils/write_on.dart';
import '../../../../core/widgets/side-drawer-component.dart';
import '../../../../dependency_container.dart';
import '../../../../generated/l10n.dart';
import '../../../home_app_bar/presentation/bloc/homeappbar_bloc.dart';
import '../../../home_app_bar/presentation/widgets/home_app_bar.dart';
import '../bloc/archivednotes_bloc.dart';
import '../widgets/archived_notes_body.dart';

class ArchivedNotesScreen extends StatefulWidget {
  static const String id = 'archived_screen';

  const ArchivedNotesScreen({
    Key key,
  }) : super(key: key);

  @override
  _ArchivedNotesScreenState createState() => _ArchivedNotesScreenState();
}

class _ArchivedNotesScreenState extends State<ArchivedNotesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    return ChangeNotifierProvider(
      create: (_) => ArchiveSelectedNotes(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<ArchivedNotesBloc>()),
          BlocProvider(create: (context) => sl<HomeappbarBloc>()),
        ],
        child: Scaffold(
          key: _scaffoldKey,
          drawer: DrawerComponent(),
          appBar: HomeAppBar(
            alertContext: context,
            translate: translate,
            box: WriteOn.archive,
          ),
          body: ArchivedNotesBody(
            translate: translate,
            scaffoldKey: _scaffoldKey,
          ),
        ),
      ),
    );
  }
}

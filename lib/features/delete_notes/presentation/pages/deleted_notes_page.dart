import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/Utils/deleted_selected_notes.dart';
import '../../../../core/Utils/write_on.dart';
import '../../../../dependency_container.dart';
import '../../../../generated/l10n.dart';
import '../../../home_app_bar/presentation/bloc/homeappbar_bloc.dart';
import '../../../home_app_bar/presentation/widgets/home_app_bar.dart';
import '../bloc/deletednotes_bloc.dart';
import '../widgets/deleted_notes_body.dart';

class DeletedNotesPage extends StatefulWidget {
  static const String id = 'deleted_notes_page';

  DeletedNotesPage({Key key}) : super(key: key);

  @override
  _DeletedNotesPageState createState() => _DeletedNotesPageState();
}

class _DeletedNotesPageState extends State<DeletedNotesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final S translate = S.of(context);
    return ChangeNotifierProvider(
      create: (_) => DeletedSelectedNotes(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<DeletedNotesBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<HomeappbarBloc>(),
          ),
        ],
        child: Scaffold(
          key: _scaffoldKey,
          appBar: HomeAppBar(
            translate: translate,
            alertContext: context,
            box: WriteOn.deleted,
          ),
          body: DeletedNotesBody(
            translate: translate,
            scaffoldKey: _scaffoldKey,
          ),
        ),
      ),
    );
  }
}

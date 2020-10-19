import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../../../core/Utils/home_selected_notes.dart';
import '../../../../core/widgets/side-drawer-component.dart';
import '../../../../dependency_container.dart';
import '../../../../generated/l10n.dart';
import '../../../home_app_bar/presentation/bloc/homeappbar_bloc.dart';
import '../../../home_app_bar/presentation/widgets/home_app_bar.dart';
import '../bloc/homenotes_bloc.dart';
import '../widgets/home_floating_action_button.dart';
import '../widgets/home_provider.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    return ChangeNotifierProvider(
      create: (_) => HomeSelectedNotes(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => sl<HomeappbarBloc>(),
          ),
          BlocProvider(
            create: (context) => sl<HomenotesBloc>(),
          ),
        ],
        child: GestureDetector(
          onTap: () {
            Scaffold.of(context).hideCurrentSnackBar();
          },
          child: Scaffold(
            key: _scaffoldKey,
            appBar: HomeAppBar(
              alertContext: context,
              translate: translate,
            ),
            drawer: DrawerComponent(),
            body: HomeProvider(translate: translate, scaffoldKey: _scaffoldKey),
            floatingActionButton: HomeFloatingActionButton(
              translate: translate,
              scaffoldKey: _scaffoldKey,
            ),
          ),
        ),
      ),
    );
  }
}

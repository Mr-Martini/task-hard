import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_hard/features/home_app_bar/presentation/bloc/homeappbar_bloc.dart';
import 'package:task_hard/features/home_app_bar/presentation/widgets/home_app_bar.dart';
import 'package:task_hard/features/home_notes/presentation/widgets/home_floating_action_button.dart';
import 'package:task_hard/features/home_notes/presentation/widgets/home_provider.dart';

import '../../../../components/side-drawer-component/side-drawer-component.dart';

import '../../../../dependency_container.dart';
import '../../../../generated/l10n.dart';

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

    return BlocProvider(
      create: (context) => sl<HomeappbarBloc>(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: HomeAppBar(),
        drawer: DrawerComponent(),
        body: HomeProvider(translate: translate, scaffoldKey: _scaffoldKey),
        floatingActionButton: HomeFloatingActionButton(
          translate: translate,
          scaffoldKey: _scaffoldKey,
        ),
      ),
    );
  }
}

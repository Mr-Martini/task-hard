import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/theme_bloc.dart';
import 'theme_list_tile.dart';

class ThemeProvider extends StatelessWidget {
  ThemeProvider({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state is ThemeInitial) {
            BlocProvider.of<ThemeBloc>(context).add(GetTheme());
          } else if (state is Loaded) {
            String pref = state.theme.preference.toString();
            return ThemeListTile(
              pref: pref,
            );
          }
          return Container();
        },
      ),
    );
  }
}

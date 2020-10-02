import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/theme_bloc.dart';
import 'theme_color_grid_view.dart';

class ThemeColorChooser extends StatelessWidget {
  ThemeColorChooser({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (state is ThemeInitial) {
          return Container();
        } else if (state is Loaded) {
          return ThemeColorGridView();
        }
        return Container();
      },
    );
  }
}

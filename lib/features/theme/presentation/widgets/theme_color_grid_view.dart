import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../components/color-bubble-component/color-bubble-component.dart';
import '../../../../core/Utils/accent_colors.dart';
import '../bloc/theme_bloc.dart';

class ThemeColorGridView extends StatefulWidget {
  ThemeColorGridView({Key key}) : super(key: key);

  @override
  _ThemeColorGridViewState createState() => _ThemeColorGridViewState();
}

class _ThemeColorGridViewState extends State<ThemeColorGridView> {
  void onTap(Color color) {
    BlocProvider.of<ThemeBloc>(context).add(SetColor(color: color));
  }

  @override
  Widget build(BuildContext context) {
    Color buttonColor = Theme.of(context).buttonColor;

    List<Color> _colors = Theme.of(context).primaryColor == Colors.white
        ? AccentColors.getLightColors
        : AccentColors.getDarkColors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: StaggeredGridView.countBuilder(
        physics: BouncingScrollPhysics(),
        itemCount: _colors.length,
        itemBuilder: (BuildContext context, int index) {
          return ColorBubbleComponent(
            color: _colors[index],
            onTap: () => onTap(_colors[index]),
            isSelected: buttonColor == _colors[index],
          );
        },
        crossAxisCount: 3,
        mainAxisSpacing: 32,
        crossAxisSpacing: 16,
        staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      ),
    );
  }
}

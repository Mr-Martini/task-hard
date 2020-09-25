import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../components/color-bubble-component/color-bubble-component.dart';
import '../bloc/theme_bloc.dart';

class ThemeColorGridView extends StatefulWidget {
  final Color mainColor;

  ThemeColorGridView({Key key, @required this.mainColor}) : super(key: key);

  @override
  _ThemeColorGridViewState createState() => _ThemeColorGridViewState();
}

class _ThemeColorGridViewState extends State<ThemeColorGridView> {
  List<Color> _colors = <Color>[
    Colors.purple,
    Colors.amber,
    Colors.teal,
    Colors.pink,
    Colors.black38,
    Colors.blue,
    Colors.orange,
    Colors.green,
    Colors.red,
    Colors.deepPurple,
  ];

  void onTap(Color color) {
    BlocProvider.of<ThemeBloc>(context).add(SetColor(color: color));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: StaggeredGridView.countBuilder(
        physics: BouncingScrollPhysics(),
        itemCount: _colors.length,
        itemBuilder: (BuildContext context, int index) {
          return ColorBubbleComponent(
            color: _colors[index],
            onTap: () => onTap(_colors[index]),
            isSelected: widget.mainColor == _colors[index],
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

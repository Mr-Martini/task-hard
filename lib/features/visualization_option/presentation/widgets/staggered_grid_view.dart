import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../core/Utils/visualization_type.dart';
import '../bloc/visualizationoption_bloc.dart';

class CustomStaggeredGridView extends StatelessWidget {
  final Function(BuildContext context, int index) itemBuilder;
  final int itemCount;

  const CustomStaggeredGridView({
    Key key,
    @required this.itemBuilder,
    @required this.itemCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisualizationOptionBloc, VisualizationOptionState>(
      builder: (context, state) {
        if (state is VisualizationOptionInitial) {
          BlocProvider.of<VisualizationOptionBloc>(context)
              .add(GetVisualizationOption());
        }
        if (state is Loaded) {
          return StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            itemCount: itemCount,
            itemBuilder: itemBuilder,
            staggeredTileBuilder: (int index) =>
                StaggeredTile.fit(state.type.type),
          );
        }
        return StaggeredGridView.countBuilder(
          crossAxisCount: 2,
          itemCount: itemCount,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          itemBuilder: itemBuilder,
          staggeredTileBuilder: (int index) =>
              StaggeredTile.fit(VisualizationType.grid),
        );
      },
    );
  }
}

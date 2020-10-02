import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_hard/core/Utils/visualization_type.dart';
import 'package:task_hard/features/visualization_option/presentation/bloc/visualizationoption_bloc.dart';
import 'package:task_hard/features/visualization_option/presentation/widgets/alert_visualization_options.dart';
import 'package:task_hard/generated/l10n.dart';

class VisualizationOptionListTile extends StatelessWidget {
  final S translate;
  const VisualizationOptionListTile({
    Key key,
    @required this.translate,
  }) : super(key: key);

  void showAlert(BuildContext context, int type) {
    showModal(
      context: context,
      configuration: FadeScaleTransitionConfiguration(),
      builder: (context) {
        return AlertVisualizationOption(translate: translate, type: type);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisualizationOptionBloc, VisualizationOptionState>(
      builder: (context, state) {
        if (state is VisualizationOptionInitial) {
          BlocProvider.of<VisualizationOptionBloc>(context)
              .add(GetVisualizationOption());
        } else if (state is Loaded) {
          int type = state.type.type;
          return ListTile(
            leading: Icon(
              type == VisualizationType.grid ? Icons.grid_on : Icons.list,
            ),
            title: Text(translate.view_style),
            trailing: FlatButton(
              onPressed: () => showAlert(context, type),
              child: Text(
                type == VisualizationType.grid
                    ? translate.staggered
                    : translate.list,
                style: TextStyle(
                  color: Theme.of(context).buttonColor,
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

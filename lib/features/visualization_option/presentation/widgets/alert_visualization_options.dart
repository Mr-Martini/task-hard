import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/Utils/visualization_type.dart';
import '../../../../generated/l10n.dart';
import '../bloc/visualizationoption_bloc.dart';

class AlertVisualizationOption extends StatefulWidget {
  final S translate;
  final int type;
  AlertVisualizationOption({
    Key key,
    @required this.translate,
    @required this.type,
  }) : super(key: key);

  @override
  _AlertVisualizationOptionState createState() =>
      _AlertVisualizationOptionState();
}

class _AlertVisualizationOptionState extends State<AlertVisualizationOption> {
  int type;

  @override
  void initState() {
    type = widget.type;
    super.initState();
  }

  void onChanged(int value) {
    setState(() {
      type = value;
    });
  }

  void onOK() {
    BlocProvider.of<VisualizationOptionBloc>(context)
        .add(SetVisualizationOption(value: type));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final Color accentColor = Theme.of(context).buttonColor;

    return AlertDialog(
      title: Text(widget.translate.choose_a_option),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Radio(
              value: VisualizationType.grid,
              groupValue: type,
              onChanged: onChanged,
              activeColor: accentColor,
            ),
            title: Text(widget.translate.staggered),
          ),
          ListTile(
            leading: Radio(
              value: VisualizationType.list,
              groupValue: type,
              onChanged: onChanged,
              activeColor: accentColor,
            ),
            title: Text(widget.translate.list),
          ),
        ],
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text(widget.translate.cancel),
        ),
        FlatButton(
          onPressed: onOK,
          child: Text(
            widget.translate.Ok,
            style: TextStyle(
              color: accentColor,
            ),
          ),
        ),
      ],
    );
  }
}

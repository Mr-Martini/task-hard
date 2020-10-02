import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../generated/l10n.dart';
import '../../data/model/theme_model.dart';
import '../bloc/theme_bloc.dart';

class ThemeAlertDialog extends StatefulWidget {
  final S translate;
  final String pref;
  ThemeAlertDialog({
    Key key,
    @required this.translate,
    @required this.pref,
  }) : super(key: key);

  @override
  _ThemeAlertDialogState createState() => _ThemeAlertDialogState();
}

class _ThemeAlertDialogState extends State<ThemeAlertDialog> {
  String pref;

  @override
  void initState() {
    pref = widget.pref;
    super.initState();
  }

  void _onChanged(String value) {
    setState(() {
      pref = value;
    });
  }

  void _onOK() {
    themePreference preference;
    for (themePreference status in themePreference.values) {
      if (status.toString() == pref) {
        preference = status;
      }
    }
    BlocProvider.of<ThemeBloc>(context).add(SetTheme(preference: preference));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.translate.choose_a_option),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Radio(
              activeColor: Theme.of(context).buttonColor,
              value: themePreference.automatic.toString(),
              groupValue: pref,
              onChanged: _onChanged,
            ),
            title: Text(widget.translate.automatic),
          ),
          ListTile(
            leading: Radio(
              activeColor: Theme.of(context).buttonColor,
              value: themePreference.light.toString(),
              groupValue: pref,
              onChanged: _onChanged,
            ),
            title: Text(widget.translate.light),
          ),
          ListTile(
            leading: Radio(
              activeColor: Theme.of(context).buttonColor,
              value: themePreference.dark.toString(),
              groupValue: pref,
              onChanged: _onChanged,
            ),
            title: Text(widget.translate.dark),
          ),
        ],
      ),
      actions: [
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text(widget.translate.cancel),
        ),
        FlatButton(
          textColor: Theme.of(context).buttonColor,
          onPressed: _onOK,
          child: Text(widget.translate.Ok),
        ),
      ],
    );
  }
}

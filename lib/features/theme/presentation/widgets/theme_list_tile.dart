import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_hard/features/theme/presentation/bloc/theme_bloc.dart';

import '../../../../components/icon-components/icon-generic.dart';
import '../../../../components/text-components/text-generic.dart';
import '../../../../generated/l10n.dart';
import '../../data/model/theme_model.dart';

class ThemeListTile extends StatefulWidget {
  final String pref;

  ThemeListTile({Key key, @required this.pref}) : super(key: key);

  @override
  _ThemeListTileState createState() => _ThemeListTileState();
}

class _ThemeListTileState extends State<ThemeListTile> {
  void _changeTheme(String value) {
    themePreference preference;
    for (themePreference status in themePreference.values) {
      if (status.toString() == value) {
        preference = status;
      }
    }
    BlocProvider.of<ThemeBloc>(context).add(SetTheme(preference: preference));
    Navigator.pop(context);
  }

  void _onPressed(S translate) {
    showModal(
      context: context,
      builder: (context) => AlertDialog(
        title: TextGeneric(text: translate.choose_a_option),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Radio(
                activeColor: Theme.of(context).buttonColor,
                value: themePreference.automatic.toString(),
                groupValue: widget.pref,
                onChanged: _changeTheme,
              ),
              title: TextGeneric(text: translate.automatic),
            ),
            ListTile(
              leading: Radio(
                activeColor: Theme.of(context).buttonColor,
                value: themePreference.light.toString(),
                groupValue: widget.pref,
                onChanged: _changeTheme,
              ),
              title: TextGeneric(text: translate.light),
            ),
            ListTile(
              leading: Radio(
                activeColor: Theme.of(context).buttonColor,
                value: themePreference.dark.toString(),
                groupValue: widget.pref,
                onChanged: _changeTheme,
              ),
              title: TextGeneric(text: translate.dark),
            ),
          ],
        ),
      ),
    );
  }

  String _getThemeName(String theme, S translate) {
    if (theme == themePreference.automatic.toString()) {
      return translate.automatic;
    } else if (theme == themePreference.dark.toString()) {
      return translate.dark;
    } else {
      return translate.light;
    }
  }

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    return ListTile(
      leading: IconGeneric(
        androidIcon: Icons.lightbulb_outline,
        iOSIcon: CupertinoIcons.lightbulb,
        semanticLabel: translate.theme,
        toolTip: translate.theme,
      ),
      title: TextGeneric(text: translate.theme),
      trailing: FlatButton(
        onPressed: () => _onPressed(translate),
        child: TextGeneric(
          text: _getThemeName(widget.pref, translate),
          color: Theme.of(context).buttonColor,
        ),
      ),
    );
  }
}

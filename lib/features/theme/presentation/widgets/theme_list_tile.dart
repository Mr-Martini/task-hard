import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_hard/features/theme/presentation/widgets/theme_alert_dialog.dart';

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
  void _onPressed(S translate) {
    showModal(
      context: context,
      builder: (context) => ThemeAlertDialog(
        translate: translate,
        pref: widget.pref,
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
        child: Text(
          _getThemeName(widget.pref, translate),
          style: TextStyle(
            color: Theme.of(context).buttonColor,
          ),
        ),
      ),
    );
  }
}

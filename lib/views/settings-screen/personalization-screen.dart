import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_hard/features/visualization_option/presentation/widgets/visualization_option_list_tile.dart';
import '../../features/theme/presentation/widgets/theme_color_chooser.dart';
import '../../features/theme/presentation/widgets/theme_provider.dart';
import '../../generated/l10n.dart';

class Personalization extends StatefulWidget {
  static const String id = 'personalization_screen';

  @override
  _PersonalizationState createState() => _PersonalizationState();
}

class _PersonalizationState extends State<Personalization> {
  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Hero(
          tag: 'personalization-screen',
          child: Material(
            color: Colors.transparent,
            child: Text(
              translate.personalization,
              style: TextStyle(
                color: Theme.of(context).textTheme.headline6.color,
                fontSize: Theme.of(context).textTheme.headline6.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          VisualizationOptionListTile(translate: translate),
          ThemeProvider(),
          Divider(),
          ListTile(
            leading: Icon(Icons.colorize, color: Theme.of(context).buttonColor),
            title: Text(
              translate.primary_color,
              style: TextStyle(
                color: Theme.of(context).buttonColor,
                fontSize: Theme.of(context).textTheme.bodyText2.fontSize,
              ),
            ),
          ),
          Flexible(
            child: ThemeColorChooser(),
          ),
        ],
      ),
    );
  }
}

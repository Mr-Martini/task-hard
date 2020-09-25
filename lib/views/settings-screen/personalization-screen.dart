import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/icon-components/icon-generic.dart';
import '../../components/text-components/text-generic.dart';
import '../../constants.dart';
import '../../controllers/view-controller/view-controller.dart';
import '../../features/theme/presentation/widgets/theme_color_chooser.dart';
import '../../features/theme/presentation/widgets/theme_provider.dart';
import '../../generated/l10n.dart';

class Personalization extends StatefulWidget {
  static const String id = 'personalization_screen';

  @override
  _PersonalizationState createState() => _PersonalizationState();
}

class _PersonalizationState extends State<Personalization> {
  String getViewTitle(String value, S translate) {
    if (value == 'Staggered') {
      return translate.staggered;
    } else if (value == 'Rectangle') {
      return translate.rectangle;
    } else {
      return translate.list;
    }
  }

  String getChangedValue(String value, S translate) {
    if (value == translate.staggered) {
      return 'Staggered';
    } else if (value == translate.rectangle) {
      return 'Rectangle';
    } else {
      return 'List';
    }
  }

  IconGeneric getIcon(String value) {
    if (value == 'Staggered') {
      return IconGeneric(
        androidIcon: Icons.view_quilt,
      );
    } else if (value == 'Rectangle') {
      return IconGeneric(
        androidIcon: Icons.view_module,
      );
    } else {
      return IconGeneric(
        androidIcon: Icons.view_stream,
      );
    }
  }

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
          Consumer<ViewController>(
            builder: (context, vC, child) => InkWell(
              onTap: () {},
              child: ListTile(
                leading: getIcon(vC.getValue),
                title: Text(translate.view_style),
                trailing: DropdownButton(
                  value: getViewTitle(vC.getValue, translate),
                  items: <String>[
                    translate.staggered,
                    translate.rectangle,
                    translate.list
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String newValue) async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    String value = getChangedValue(newValue, translate);
                    prefs.setString('view', value);
                    vC.setValue = value;
                  },
                ),
              ),
            ),
          ),
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

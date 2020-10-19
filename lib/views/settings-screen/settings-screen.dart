import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/icon-components/icon-generic.dart';
import '../../constants.dart';
import '../../generated/l10n.dart';
import 'account.dart';
import 'general.dart';
import 'personalization-screen.dart';

class SettingsScreen extends StatefulWidget {
  static const String id = 'settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          translate.settings,
          style: TextStyle(
            color: Theme.of(context).textTheme.headline6.color,
          ),
        ),
        leading: BackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, GeneralScreen.id);
              },
              child: ListTile(
                leading: IconGeneric(
                  androidIcon: Icons.assignment,
                  iOSIcon: CupertinoIcons.gear_big,
                  semanticLabel: translate.general,
                  toolTip: translate.general,
                  size: kSettingsIconSize,
                ),
                title: Hero(
                  tag: 'general-screen',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(translate.general),
                  ),
                ),
                subtitle: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 8,
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Personalization.id);
              },
              child: ListTile(
                leading: IconGeneric(
                  androidIcon: Icons.palette,
                  iOSIcon: CupertinoIcons.heart_solid,
                  semanticLabel: translate.personalization,
                  toolTip: translate.personalization,
                  size: kSettingsIconSize,
                ),
                title: Hero(
                  tag: 'personalization-screen',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(translate.personalization),
                  ),
                ),
                subtitle: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 8,
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, Account.id);
              },
              child: ListTile(
                leading: IconGeneric(
                  androidIcon: Icons.account_circle,
                  iOSIcon: CupertinoIcons.person_solid,
                  semanticLabel: translate.account,
                  toolTip: translate.account,
                  size: kSettingsIconSize,
                  color: Colors.grey,
                ),
                title: Hero(
                  tag: 'account-screen',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(translate.account),
                  ),
                ),
                subtitle: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 8,
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/icon-components/icon-generic.dart';
import '../../components/text-components/text-generic.dart';
import '../../constants.dart';
import '../../generated/l10n.dart';

class Account extends StatefulWidget {
  static const String id = 'account_screen';

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Hero(
          tag: 'account-screen',
          child: Material(
            color: Colors.transparent,
            child: Text(
              translate.account,
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
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          InkWell(
            onTap: () {},
            child: ListTile(
              title: TextGeneric(text: translate.change_email),
              leading: IconGeneric(
                androidIcon: Icons.email,
                iOSIcon: CupertinoIcons.mail_solid,
                semanticLabel: translate.change_email,
                toolTip: translate.change_email,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: TextGeneric(text: translate.change_password),
              leading: IconGeneric(
                androidIcon: Icons.lock,
                iOSIcon: CupertinoIcons.padlock_solid,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: TextGeneric(text: translate.change_name),
              leading: IconGeneric(
                androidIcon: Icons.account_circle,
                iOSIcon: CupertinoIcons.person_solid,
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: ListTile(
              title: TextGeneric(text: translate.delete_account),
              subtitle: TextGeneric(
                text: translate.you_loose_all_data,
                color: Colors.grey,
              ),
              leading: IconGeneric(
                androidIcon: Icons.delete,
                iOSIcon: CupertinoIcons.delete_simple,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

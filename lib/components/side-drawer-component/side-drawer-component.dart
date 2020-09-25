import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_hard/components/icon-components/icon-generic.dart';
import 'package:task_hard/components/text-components/text-generic.dart';
import 'package:task_hard/generated/l10n.dart';
import 'package:task_hard/views/archive-screen/archive-screen.dart';
import 'package:task_hard/views/feedback-screen/feedback-screen.dart';
import 'package:task_hard/views/trash-screen/trash-screen.dart';

class DrawerComponent extends StatefulWidget {
  @override
  _DrawerComponentState createState() => _DrawerComponentState();
}

class _DrawerComponentState extends State<DrawerComponent> {
  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).buttonColor,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: AssetImage('images/ProfilePhoto.jpg'),
                  radius: 30,
                ),
                SizedBox(
                  height: 16,
                ),
                Flexible(
                  child: Text(
                    'Marcos Martini',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Theme.of(context).textTheme.headline5.fontSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, ArchiveScreen.id);
            },
            child: ListTile(
              title: TextGeneric(
                text: translate.archives,
              ),
              leading: IconGeneric(
                androidIcon: Icons.archive,
                iOSIcon: CupertinoIcons.folder_solid,
                semanticLabel: translate.archives,
                toolTip: translate.archives,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, TrashScreen.id);
            },
            child: ListTile(
              title: TextGeneric(
                text: translate.trash,
              ),
              leading: IconGeneric(
                androidIcon: Icons.delete,
                iOSIcon: CupertinoIcons.delete_solid,
                semanticLabel: translate.trash,
                toolTip: translate.trash,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, FeedBackScreen.id);
            },
            child: ListTile(
              title: TextGeneric(
                text: translate.feedback,
              ),
              leading: IconGeneric(
                androidIcon: Icons.feedback,
                iOSIcon: CupertinoIcons.conversation_bubble,
                semanticLabel: translate.feedback,
                toolTip: translate.feedback,
              ),
            ),
          ),
          InkWell(
            onTap: () => Navigator.pop(context),
            child: AboutListTile(
              applicationName: 'P Notes',
              applicationIcon: CircleAvatar(
                backgroundImage: AssetImage('images/ic_launcher.png'),
              ),
              applicationVersion: '1.0.0',
              icon: IconGeneric(
                androidIcon: Icons.receipt,
                semanticLabel: translate.licenses,
                toolTip: translate.licenses,
              ),
              aboutBoxChildren: [
                TextGeneric(text: translate.license_rights),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

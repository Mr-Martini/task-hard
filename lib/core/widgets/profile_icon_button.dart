import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_hard/components/icon-components/icon-generic.dart';
import 'package:task_hard/components/text-components/text-generic.dart';
import 'package:task_hard/components/tooltip-component/tooltip-component.dart';
import 'package:task_hard/generated/l10n.dart';
import 'package:task_hard/views/about-screen/about-screen.dart';
import 'package:task_hard/views/profile-screen/profile-screen.dart';
import 'package:task_hard/views/settings-screen/settings-screen.dart';

class ProfileIconButton extends StatelessWidget {
  const ProfileIconButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    return IconButton(
      icon: CircleAvatar(
        backgroundImage: AssetImage('images/ProfilePhoto.jpg'),
        radius: 16,
      ),
      onPressed: () {
        showModal(
          configuration: FadeScaleTransitionConfiguration(),
          context: context,
          builder: (context) => AlertDialog(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(),
            title: TextGeneric(
              text: translate.quick_actions,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ToolTipComponent(
                  message: translate.tooltip_go_to_profile_screen,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, ProfileScreen.id);
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage('images/ProfilePhoto.jpg'),
                      ),
                      title: TextGeneric(
                        text: 'Marcos Martini',
                        fontSize: 14,
                      ),
                      subtitle: TextGeneric(
                        text: 'marcosmartini765@gmail.com',
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Divider(),
                Container(
                  height: 160,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, SettingsScreen.id);
                        },
                        child: ListTile(
                          title: TextGeneric(
                            text: translate.settings,
                          ),
                          leading: IconGeneric(
                            androidIcon: Icons.settings,
                            iOSIcon: CupertinoIcons.settings,
                            toolTip: translate.app_settings,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, AboutScreen.id),
                        child: ListTile(
                          title: TextGeneric(text: translate.about),
                          leading: IconGeneric(
                            androidIcon: Icons.info,
                            iOSIcon: CupertinoIcons.info,
                            toolTip: translate.app_about,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: ListTile(
                          title: TextGeneric(text: translate.sign_out),
                          leading: IconGeneric(
                            androidIcon: Icons.exit_to_app,
                            iOSIcon: CupertinoIcons.person_solid,
                            toolTip: translate.sign_out,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
              ],
            ),
          ),
        );
      },
    );
  }
}

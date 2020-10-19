import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/icon-components/icon-generic.dart';
import '../../components/text-components/text-generic.dart';
import '../../constants.dart';
import '../../generated/l10n.dart';

class AboutScreen extends StatelessWidget {
  static const String id = 'about_screen';

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: IconGeneric(
            androidIcon: Icons.arrow_back,
            iOSIcon: CupertinoIcons.back,
            semanticLabel: translate.tooltip_previous_screen,
            toolTip: translate.tooltip_previous_screen,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextGeneric(
          text: translate.about,
          fontSize: kSectionTitleSize,
        ),
      ),
      body: Container(
        height: height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                showLicensePage(
                  context: context,
                  applicationName: 'P Notes',
                  applicationVersion: '1.0.0',
                  applicationIcon: CircleAvatar(
                    backgroundImage: AssetImage('images/ic_launcher.png'),
                  ),
                );
              },
              child: ListTile(
                leading: IconGeneric(
                  androidIcon: Icons.receipt,
                  iOSIcon: Icons.receipt,
                  semanticLabel: translate.view_licenses,
                  toolTip: translate.view_licenses,
                ),
                title: TextGeneric(text: translate.licenses),
              ),
            ),
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconGeneric(
                      androidIcon: Icons.verified_user,
                      semanticLabel: 'version',
                      toolTip: 'version',
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextGeneric(
                      text: 'Version 1.0.0',
                      bold: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                    SizedBox(
                      height: 16,
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

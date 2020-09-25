import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/text-components/text-generic.dart';
import '../../constants.dart';
import '../../features/taged_notes_home/presentation/widgets/list_tile_should.dart';
import '../../features/time_preference/presentation/widgets/configs.dart';
import '../../generated/l10n.dart';

class GeneralScreen extends StatelessWidget {
  static const String id = 'general_screen';

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).textTheme.headline6.color),
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
        title: Hero(
          tag: 'general-screen',
          child: Material(
            color: Colors.transparent,
            child: Text(
              translate.general,
              style: TextStyle(
                color: Theme.of(context).textTheme.headline6.color,
                fontSize: Theme.of(context).textTheme.headline6.fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: TextGeneric(
                text: translate.date_and_time,
                fontSize: kSectionTitleSize,
              ),
            ),
            SettingsTimePreference(),
            Divider(),
            ListTileShould(),
          ],
        ),
      ),
    );
  }
}

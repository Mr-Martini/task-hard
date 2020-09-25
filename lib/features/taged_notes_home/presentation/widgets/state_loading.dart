import 'package:flutter/material.dart';

import '../../../../components/text-components/text-generic.dart';

class StateLoadingTagedNotesHome extends StatelessWidget {
  const StateLoadingTagedNotesHome({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        title: TextGeneric(text: 'should tagged notes appear on home screen?'),
        trailing: CircularProgressIndicator(),
      ),
    );
  }
}

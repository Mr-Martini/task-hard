import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/text-components/text-generic.dart';
import '../../../../generated/l10n.dart';
import '../bloc/tagednoteshomebloc_bloc.dart';

class StateLoadedTagedNotesHome extends StatefulWidget {
  final bool should;

  const StateLoadedTagedNotesHome({
    Key key,
    @required this.should,
  }) : super(key: key);

  @override
  _StateLoadedTagedNotesHomeState createState() =>
      _StateLoadedTagedNotesHomeState();
}

class _StateLoadedTagedNotesHomeState extends State<StateLoadedTagedNotesHome> {
  void onChanged(bool value) {
    BlocProvider.of<TagednoteshomeblocBloc>(context)
        .add(SetPreference(should: value));
  }

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    return Container(
      child: ListTile(
        title: TextGeneric(
          text: translate.should_tagged_notes_appear_home_title,
        ),
        subtitle: TextGeneric(
            text: translate.should_tagged_notes_appear_home_subtitle,
            fontSize: 14,
            color: Colors.grey),
        trailing: Switch(
          activeColor: Theme.of(context).buttonColor,
          value: widget.should,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

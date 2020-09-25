import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/icon-components/icon-generic.dart';
import '../../../../components/text-components/text-generic.dart';
import '../bloc/timepreference_bloc.dart';

class TimePreferenceListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final TimeOfDay time;
  final Type event;

  const TimePreferenceListTile({
    Key key,
    @required this.title,
    @required this.icon,
    @required this.time,
    @required this.event,
  }) : super(key: key);

  @override
  _TimePreferenceListTileState createState() => _TimePreferenceListTileState();
}

class _TimePreferenceListTileState extends State<TimePreferenceListTile> {
  void onTap() async {
    TimeOfDay timeToSet = await showTimePicker(
      context: context,
      initialTime: widget.time,
    );
    if (timeToSet == null) return;
    switch (widget.event) {
      case SetMorningTimePreference:
        BlocProvider.of<TimepreferenceBloc>(context)
            .add(SetMorningTimePreference(morning: timeToSet));
        break;
      case SetNoonTimePreference:
        BlocProvider.of<TimepreferenceBloc>(context)
            .add(SetNoonTimePreference(noon: timeToSet));
        break;
      case SetAfternoonTimePreference:
        BlocProvider.of<TimepreferenceBloc>(context)
            .add(SetAfternoonTimePreference(afternoon: timeToSet));
        break;
      case SetNightTimePreference:
        BlocProvider.of<TimepreferenceBloc>(context)
            .add(SetNightTimePreference(night: timeToSet));
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          leading: IconGeneric(
            androidIcon: widget.icon,
            iOSIcon: widget.icon,
            semanticLabel: widget.title,
          ),
          title: Text(widget.title),
          trailing: Text(
            widget.time.format(context),
          ),
        ),
      ),
    );
  }
}

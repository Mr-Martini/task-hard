import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../generated/l10n.dart';
import '../bloc/timepreference_bloc.dart';
import 'time_preference_list_tile.dart';
import 'time_preference_loading.dart';

class SettingsTimePreference extends StatelessWidget {
  SettingsTimePreference({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    return BlocBuilder<TimepreferenceBloc, TimepreferenceState>(
      builder: (context, state) {
        if (state is TimepreferenceInitial) {
          BlocProvider.of<TimepreferenceBloc>(context).add(GetTimePreference());
        } else if (state is Loading) {
          return LoadingTimePreference();
        } else if (state is Loaded) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TimePreferenceListTile(
                title: translate.morning,
                icon: FontAwesomeIcons.cloudSun,
                time: state.timePreference.morning,
                event: SetMorningTimePreference,
              ),
              TimePreferenceListTile(
                title: translate.noon,
                icon: FontAwesomeIcons.sun,
                time: state.timePreference.noon,
                event: SetNoonTimePreference,
              ),
              TimePreferenceListTile(
                title: translate.afternoon,
                icon: FontAwesomeIcons.cloud,
                time: state.timePreference.afternoon,
                event: SetAfternoonTimePreference,
              ),
              TimePreferenceListTile(
                title: translate.night,
                icon: FontAwesomeIcons.moon,
                time: state.timePreference.night,
                event: SetNightTimePreference,
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}

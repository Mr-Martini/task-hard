import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tagednoteshomebloc_bloc.dart';
import 'state_loaded.dart';
import 'state_loading.dart';

class ListTileShould extends StatelessWidget {
  const ListTileShould({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder<TagednoteshomeblocBloc, TagednoteshomeblocState>(
        builder: (context, state) {
          if (state.props.isEmpty) {
            BlocProvider.of<TagednoteshomeblocBloc>(context)
                .add(GetPreference());
          }
          if (state is Error) {
            return Container();
          } else if (state is Loading) {
            return StateLoadingTagedNotesHome();
          } else if (state is Loaded) {
            return StateLoadedTagedNotesHome(
              should: state.should,
            );
          } else if (state is Empty) {
            return Container();
          }
          return Container();
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/material_card.dart';
import '../../../note/domain/entities/note.dart';
import '../bloc/homeappbar_bloc.dart';

class MaterialCardAppBarContainer extends StatelessWidget {
  final Note note;
  final ValueChanged<bool> onTap;
  final ValueChanged<bool> onLongPress;

  const MaterialCardAppBarContainer({
    @required this.note,
    @required this.onTap,
    @required this.onLongPress,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeappbarBloc, HomeappbarState>(
      builder: (context, state) {
        if (state is Loaded) {
          var notes = state.selectedNotes.selectedNotes;
          if (notes.contains(note)) {
            return MaterialCard(
              note: note,
              onTap: onTap,
              onLongPress: onLongPress,
              isSelected: true,
            );
          }
          return MaterialCard(
            note: note,
            onTap: onTap,
            isSelected: false,
            onLongPress: onLongPress,
          );
        }
        return MaterialCard(
          note: note,
          onTap: onTap,
          isSelected: false,
          onLongPress: onLongPress,
        );
      },
    );
  }
}

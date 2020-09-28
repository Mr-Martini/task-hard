import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_hard/core/widgets/material_card.dart';
import 'package:task_hard/features/home_app_bar/presentation/bloc/homeappbar_bloc.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';

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
              title: note.title,
              note: note.note,
              repeat: note.repeat,
              onTap: onTap,
              onLongPress: onLongPress,
              reminder: note.reminder,
              color: note.color,
              expired: note.expired,
              isSelected: true,
            );
          }
          return MaterialCard(
            title: note.title,
            note: note.note,
            repeat: note.repeat,
            onTap: onTap,
            reminder: note.reminder,
            color: note.color,
            expired: note.expired,
            isSelected: false,
            onLongPress: onLongPress,
          );
        }
        return MaterialCard(
          title: note.title,
          note: note.note,
          repeat: note.repeat,
          onTap: onTap,
          reminder: note.reminder,
          color: note.color,
          expired: note.expired,
          isSelected: false,
          onLongPress: onLongPress,
        );
      },
    );
  }
}

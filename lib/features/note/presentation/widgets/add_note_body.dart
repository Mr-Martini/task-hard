import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/empty-folder-component/empty-folder.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/note.dart';
import '../bloc/note_bloc.dart';

class AddTagBody extends StatelessWidget {
  final S translate;

  const AddTagBody({
    Key key,
    @required this.translate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NoteState>(
      builder: (context, state) {
        if (state is Loaded) {
          Note note = state.note;
          List tags = note?.tags ?? [];
          return Container();
        }
        return EmptyFolder(
          androidIcon: Icons.label,
          title: translate.no_tags,
          iOSIcon: Icons.label,
          toolTip: translate.no_tags,
        );
      },
    );
  }
}

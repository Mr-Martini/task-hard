import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../components/empty-folder-component/empty-folder.dart';
import '../../../../core/widgets/material_card.dart';
import '../../../../generated/l10n.dart';
import '../../../note/domain/entities/note.dart';
import '../../../visualization_option/presentation/widgets/staggered_grid_view.dart';
import '../bloc/archivednotes_bloc.dart';

class ArchivedNotesBody extends StatefulWidget {
  final S translate;
  ArchivedNotesBody({Key key, @required this.translate,}) : super(key: key);

  @override
  _ArchivedNotesBodyState createState() => _ArchivedNotesBodyState();
}

class _ArchivedNotesBodyState extends State<ArchivedNotesBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArchivedNotesBloc, ArchivedNotesState>(
      builder: (context, state) {
        if (state is ArchivedNotesInitial) {
          BlocProvider.of<ArchivedNotesBloc>(context).add(GetArchivedNotes());
        } else if (state is Loaded) {
          if (state.notes.isEmpty) {
            return EmptyFolder(
              androidIcon: Icons.archive,
              title: widget.translate.no_notes_archived,
              iOSIcon: Icons.archive,
              toolTip: widget.translate.no_notes_archived,
            );
          }
          return Padding(
            padding: EdgeInsets.all(8),
            child: CustomStaggeredGridView(
              itemCount: state.notes.length,
              itemBuilder: (context, index) {
                Note note = state.notes[index];
                return MaterialCard(
                  note: note,
                  onTap: (bool isSelected) {},
                  onLongPress: (bool isSelected) {},
                  isSelected: false,
                );
              },
            ),
          );
        }
        return Container(
          color: Colors.red,
        );
      },
    );
  }
}

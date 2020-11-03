import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task_hard/core/Utils/archive_selected_notes.dart';
import 'package:task_hard/core/Utils/arguments.dart';
import 'package:task_hard/core/Utils/write_on.dart';
import 'package:task_hard/features/home_app_bar/presentation/bloc/homeappbar_bloc.dart'
    as hA;
import 'package:task_hard/features/home_app_bar/presentation/widgets/material_card_app_bar_container.dart';
import 'package:task_hard/features/note/presentation/pages/task_container.dart';

import '../../../../components/empty-folder-component/empty-folder.dart';
import '../../../../generated/l10n.dart';
import '../../../note/domain/entities/note.dart';
import '../../../visualization_option/presentation/widgets/staggered_grid_view.dart';
import '../bloc/archivednotes_bloc.dart';

class ArchivedNotesBody extends StatefulWidget {
  final S translate;
  final GlobalKey<ScaffoldState> scaffoldKey;
  ArchivedNotesBody({
    Key key,
    @required this.translate,
    @required this.scaffoldKey,
  }) : super(key: key);

  @override
  _ArchivedNotesBodyState createState() => _ArchivedNotesBodyState();
}

class _ArchivedNotesBodyState extends State<ArchivedNotesBody> {
  ArchiveSelectedNotes aSN;

  void addOrRemove(bool isSelected, Note note) {
    if (!isSelected) {
      aSN.addNote = note;
      BlocProvider.of<hA.HomeappbarBloc>(context).add(
        hA.AddNote(
          selectedNotes: List<Note>.from(aSN.getNotes),
        ),
      );
    } else {
      aSN.removeNote = note;
      BlocProvider.of<hA.HomeappbarBloc>(context).add(
        hA.AddNote(
          selectedNotes: List<Note>.from(aSN.getNotes),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    aSN = Provider.of<ArchiveSelectedNotes>(context);
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
                return MaterialCardAppBarContainer(
                  note: note,
                  onLongPress: (bool value) {
                    addOrRemove(value, note);
                  },
                  onTap: (bool isSelected) {
                      if (aSN.getNotes.isEmpty) {
                        Navigator.pushNamed(
                          context,
                          TaskContainer.id,
                          arguments: Arguments(
                            title: note.title,
                            note: note.note,
                            color: note.color ?? Theme.of(context).primaryColor,
                            key: note.key,
                            scaffoldKey: widget.scaffoldKey,
                            context: context,
                            box: WriteOn.archive,
                          ),
                        );
                      } else {
                        addOrRemove(isSelected, note);
                      }
                    },
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

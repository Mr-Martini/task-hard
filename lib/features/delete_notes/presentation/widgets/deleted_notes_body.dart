import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../components/empty-folder-component/empty-folder.dart';
import '../../../../core/Utils/arguments.dart';
import '../../../../core/Utils/deleted_selected_notes.dart';
import '../../../../core/Utils/write_on.dart';
import '../../../../generated/l10n.dart';
import '../../../home_app_bar/presentation/bloc/homeappbar_bloc.dart';
import '../../../home_app_bar/presentation/widgets/material_card_app_bar_container.dart';
import '../../../note/domain/entities/note.dart';
import '../../../visualization_option/presentation/widgets/staggered_grid_view.dart';
import '../bloc/deletednotes_bloc.dart';
import '../pages/deleted_note_container.dart';

class DeletedNotesBody extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final S translate;
  DeletedNotesBody({
    Key key,
    @required this.translate,
    @required this.scaffoldKey,
  }) : super(key: key);

  @override
  _DeletedNotesBodyState createState() => _DeletedNotesBodyState();
}

class _DeletedNotesBodyState extends State<DeletedNotesBody> {
  DeletedSelectedNotes dSN;

  @override
  void didChangeDependencies() {
    BlocProvider.of<DeletedNotesBloc>(context).add(GetDeletedNotes());
    super.didChangeDependencies();
  }

  void addOrRemove(bool isSelected, Note note) {
    if (!isSelected) {
      dSN.addNote = note;
      BlocProvider.of<HomeappbarBloc>(context).add(
        AddNote(
          selectedNotes: List<Note>.from(dSN.getNotes),
        ),
      );
    } else {
      dSN.removeNote = note;
      BlocProvider.of<HomeappbarBloc>(context).add(
        AddNote(
          selectedNotes: List<Note>.from(dSN.getNotes),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    dSN = Provider.of<DeletedSelectedNotes>(context, listen: false);
    return BlocBuilder<DeletedNotesBloc, DeletedNotesState>(
      builder: (context, state) {
        if (state is DeletedNotesLoaded) {
          if (state.notes.isEmpty) {
            return EmptyFolder(
              androidIcon: FontAwesomeIcons.trashAlt,
              title: widget.translate.trash,
              iOSIcon: FontAwesomeIcons.trashAlt,
              toolTip: widget.translate.trash,
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
                  onTap: (bool isSelected) {
                    if (dSN.getNotes.isEmpty) {
                      Navigator.pushNamed(
                        context,
                        DeletedTaskContainer.id,
                        arguments: Arguments(
                          color: note.color ?? Theme.of(context).primaryColor,
                          title: note.title,
                          note: note.note,
                          key: note.key,
                          box: WriteOn.deleted,
                          context: context,
                          scaffoldKey: widget.scaffoldKey,
                        ),
                      );
                    } else {
                      addOrRemove(isSelected, note);
                    }
                  },
                  onLongPress: (bool isSelected) {
                    addOrRemove(isSelected, note);
                  },
                );
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}

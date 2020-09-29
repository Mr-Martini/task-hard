import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:task_hard/core/Utils/home_selected_notes.dart';

import '../../../../components/empty-folder-component/empty-folder.dart';
import '../../../../core/Utils/arguments.dart';
import '../../../../core/widgets/material_card_app_bar_container.dart';
import '../../../../dependency_container.dart';
import '../../../../generated/l10n.dart';
import '../../../home_app_bar/presentation/bloc/homeappbar_bloc.dart';
import '../../../note/domain/entities/note.dart';
import '../../../note/presentation/pages/task_container.dart';
import '../bloc/homenotes_bloc.dart' as hN;

class HomeProvider extends StatefulWidget {
  const HomeProvider({
    Key key,
    @required this.translate,
    @required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final S translate;
  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  _HomeProviderState createState() => _HomeProviderState();
}

class _HomeProviderState extends State<HomeProvider> {
  HomeSelectedNotes sN;

  void addOrRemoveNote(bool isSelected, Note note) {
    if (!isSelected) {
      sN.addNote = note;
      BlocProvider.of<HomeappbarBloc>(context).add(
        AddNote(
          selectedNotes: List<Note>.from(sN.getNotes),
        ),
      );
    } else {
      sN.removeNote = note;
      BlocProvider.of<HomeappbarBloc>(context).add(
        AddNote(
          selectedNotes: List<Note>.from(sN.getNotes),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    sN = Provider.of<HomeSelectedNotes>(context, listen: false);

    return BlocProvider(
      create: (context) => sl<hN.HomenotesBloc>(),
      child: BlocBuilder<hN.HomenotesBloc, hN.HomenotesState>(
        builder: (context, state) {
          if (state is hN.HomenotesInitial) {
            BlocProvider.of<hN.HomenotesBloc>(context).add(hN.GetHomeNotes());
          } else if (state is hN.Loaded) {
            if (state.notes.notes.isEmpty) {
              return EmptyFolder(
                androidIcon: Icons.note,
                title: widget.translate.empty_home_notes,
                iOSIcon: Icons.note,
                toolTip: widget.translate.notes,
              );
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: StaggeredGridView.countBuilder(
                staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                itemCount: state.notes.notes.length,
                crossAxisCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  var note = state.notes.notes[index];
                  return MaterialCardAppBarContainer(
                    note: note,
                    onTap: (bool isSelected) {
                      if (sN.getNotes.isEmpty) {
                        Navigator.pushNamed(
                          context,
                          TaskContainer.id,
                          arguments: Arguments(
                            title: note.title,
                            note: note.note,
                            color: note.color ?? Theme.of(context).primaryColor,
                            key: note.key,
                            scaffoldKey: widget._scaffoldKey,
                          ),
                        );
                      } else {
                        addOrRemoveNote(isSelected, note);
                      }
                    },
                    onLongPress: (bool isSelected) {
                      addOrRemoveNote(isSelected, note);
                    },
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}

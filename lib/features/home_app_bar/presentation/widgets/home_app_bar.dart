import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_hard/features/home_notes/presentation/bloc/homenotes_bloc.dart'
    as hN;
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/time_preference/presentation/widgets/alert_reminder_container.dart';
import 'package:task_hard/generated/l10n.dart';

import '../../../../components/color-selector-component/color-selector-component.dart';
import '../../../../core/Utils/alert_dialog.dart';
import '../../../../core/Utils/alert_reminder_params.dart';
import '../../../../core/Utils/home_selected_notes.dart';
import '../../../../core/Utils/snackbar_context.dart';
import '../../../../core/widgets/profile_icon_button.dart';
import '../bloc/homeappbar_bloc.dart';

enum HomeAppBarPoUpMenuOption { change_color, delete, archive, select_all }

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final S translate;
  final BuildContext alertContext;

  HomeAppBar({
    Key key,
    @required this.translate,
    @required this.alertContext,
  }) : super(key: key);

  @override
  _HomeAppBarState createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(55);
}

class _HomeAppBarState extends State<HomeAppBar>
    with SingleTickerProviderStateMixin {
  AnimationController leadingAnimation;

  @override
  void initState() {
    leadingAnimation = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 600,
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    leadingAnimation.dispose();
    super.dispose();
  }

  List<Note> getAllNotes() {
    hN.HomenotesState state = BlocProvider.of<hN.HomenotesBloc>(context).state;

    if (state is hN.HomenotesInitial) {
      return <Note>[];
    } else if (state is hN.Loaded) {
      Provider.of<HomeSelectedNotes>(context, listen: false).setList =
          List<Note>.from(state.notes.notes);
      return state.notes.notes;
    }
    return <Note>[];
  }

  void selectAll() {
    BlocProvider.of<HomeappbarBloc>(context).add(
      AddNote(
        selectedNotes: getAllNotes(),
      ),
    );
  }

  void showReminder() {
    HomeSelectedNotes provider =
        Provider.of<HomeSelectedNotes>(context, listen: false);
    List<Note> selectedNotes = List<Note>.from(provider.getNotes);
    bool hasReminder = selectedNotes.any((element) => element.reminder != null);
    showModal(
      context: context,
      configuration: FadeScaleTransitionConfiguration(),
      builder: (_) {
        return AlertReminderContainer(
          hasReminder: hasReminder,
          deleteReminder: () {
            BlocProvider.of<HomeappbarBloc>(context)
              ..add(
                DeleteReminder(
                  selectedNotes: selectedNotes,
                ),
              )
              ..add(AddNote(selectedNotes: <Note>[]));
            BlocProvider.of<hN.HomenotesBloc>(context).add(hN.GetHomeNotes());
            provider.clear();
          },
          updateReminder: (AlertReminderParams params) {
            BlocProvider.of<HomeappbarBloc>(context)
              ..add(
                PutReminder(
                  selectedNotes: selectedNotes,
                  scheduledDate: params.scheduledDate,
                  repeat: params.repeat,
                ),
              )
              ..add(AddNote(selectedNotes: <Note>[]));
            BlocProvider.of<hN.HomenotesBloc>(context).add(hN.GetHomeNotes());
            provider.clear();
          },
        );
      },
    );
  }

  void deleteNotes() {
    HomeSelectedNotes provider =
        Provider.of<HomeSelectedNotes>(context, listen: false);
    List<Note> selectedNotes = List<Note>.from(provider.getNotes);
    ShowDialog.alertDialog(
      context: context,
      flatText: widget.translate.cancel,
      title: widget.translate.delete_selected_notes,
      raisedOnPressed: () {
        BlocProvider.of<HomeappbarBloc>(context)
          ..add(DeleteNotes(selectedNotes: selectedNotes))
          ..add(AddNote(selectedNotes: <Note>[]));
        BlocProvider.of<hN.HomenotesBloc>(context).add(hN.GetHomeNotes());
        provider.clear();
        ShowSnackBar.show(
          context: widget.alertContext,
          title: widget.translate.done,
          actionMessage: widget.translate.undo,
          action: () {
            BlocProvider.of<HomeappbarBloc>(context)
              ..add(
                UndoDeleteNotes(
                  selectedNotes: selectedNotes,
                ),
              )
              ..add(
                AddNote(
                  selectedNotes: <Note>[],
                ),
              );
            BlocProvider.of<hN.HomenotesBloc>(context).add(hN.GetHomeNotes());
          },
        );
        Navigator.pop(context);
      },
      raisedText: widget.translate.delete,
      icon: FontAwesomeIcons.trashAlt,
    );
  }

  void archiveNotes() {
    HomeSelectedNotes provider =
        Provider.of<HomeSelectedNotes>(context, listen: false);
    List<Note> selectedNotes = List<Note>.from(provider.getNotes);
    ShowDialog.alertDialog(
      context: context,
      flatText: widget.translate.cancel,
      title: widget.translate.archive_selected_notes,
      raisedOnPressed: () {
        BlocProvider.of<HomeappbarBloc>(context)
          ..add(
            ArchiveNotes(
              selectedNotes: selectedNotes,
            ),
          )
          ..add(
            AddNote(
              selectedNotes: <Note>[],
            ),
          );
        BlocProvider.of<hN.HomenotesBloc>(context).add(hN.GetHomeNotes());
        provider.clear();
        Navigator.pop(context);
        ShowSnackBar.show(
          context: widget.alertContext,
          title: widget.translate.done,
          actionMessage: widget.translate.undo,
          action: () {
            BlocProvider.of<HomeappbarBloc>(context)
              ..add(
                UndoArchiveNotes(
                  selectedNotes: selectedNotes,
                ),
              )
              ..add(
                AddNote(
                  selectedNotes: <Note>[],
                ),
              );
            BlocProvider.of<hN.HomenotesBloc>(context).add(hN.GetHomeNotes());
          },
        );
      },
      raisedText: widget.translate.archive,
      icon: Icons.archive,
      material: true,
    );
  }

  void showColorChooser() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext _) {
        return ColorSelector(
          onTap: (Color color) {
            Navigator.pop(context);
            HomeSelectedNotes provider =
                Provider.of<HomeSelectedNotes>(context, listen: false);
            List<Note> selectedNotes = List<Note>.from(provider.getNotes);
            BlocProvider.of<HomeappbarBloc>(context)
              ..add(ChangeColor(
                selectedNotes: selectedNotes,
                color: color,
              ))
              ..add(AddNote(selectedNotes: <Note>[]));
            BlocProvider.of<hN.HomenotesBloc>(context).add(hN.GetHomeNotes());
            provider.clear();
          },
        );
      },
    );
  }

  void onSelected(HomeAppBarPoUpMenuOption option) {
    switch (option) {
      case HomeAppBarPoUpMenuOption.change_color:
        showColorChooser();
        break;
      case HomeAppBarPoUpMenuOption.delete:
        deleteNotes();
        break;
      case HomeAppBarPoUpMenuOption.archive:
        archiveNotes();
        break;
      case HomeAppBarPoUpMenuOption.select_all:
        selectAll();
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeappbarBloc, HomeappbarState>(
      builder: (context, state) {
        if (state is HomeappbarInitial) {
          return AppBar(
            iconTheme: IconThemeData(
              color: Theme.of(context).iconTheme.color,
            ),
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              widget.translate.app_name,
              style: TextStyle(
                color: Theme.of(context).textTheme.headline6.color,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              ProfileIconButton(),
            ],
          );
        } else if (state is Loaded) {
          var notes = state.selectedNotes.selectedNotes;
          if (notes.length >= 1) {
            leadingAnimation.forward();
            return AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              leading: IconButton(
                icon: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: leadingAnimation,
                ),
                onPressed: () {
                  BlocProvider.of<HomeappbarBloc>(context).add(
                    AddNote(
                      selectedNotes: <Note>[],
                    ),
                  );
                  Provider.of<HomeSelectedNotes>(context, listen: false)
                      .clear();
                },
              ),
              title: Text(notes.length.toString()),
              actions: [
                IconButton(
                  icon: Icon(Icons.add_alert),
                  onPressed: showReminder,
                ),
                PopupMenuButton<HomeAppBarPoUpMenuOption>(
                  onSelected: onSelected,
                  itemBuilder: (context) =>
                      <PopupMenuEntry<HomeAppBarPoUpMenuOption>>[
                    PopupMenuItem<HomeAppBarPoUpMenuOption>(
                      value: HomeAppBarPoUpMenuOption.change_color,
                      child: ListTile(
                        leading: Icon(Icons.palette),
                        title: Text(widget.translate.change_color),
                        subtitle: Divider(),
                      ),
                    ),
                    PopupMenuItem<HomeAppBarPoUpMenuOption>(
                      value: HomeAppBarPoUpMenuOption.delete,
                      child: ListTile(
                        leading: Icon(Icons.delete),
                        title: Text(widget.translate.delete),
                        subtitle: Divider(),
                      ),
                    ),
                    PopupMenuItem<HomeAppBarPoUpMenuOption>(
                      value: HomeAppBarPoUpMenuOption.archive,
                      child: ListTile(
                        leading: Icon(Icons.archive),
                        title: Text(widget.translate.archive),
                        subtitle: Divider(),
                      ),
                    ),
                    PopupMenuItem<HomeAppBarPoUpMenuOption>(
                      value: HomeAppBarPoUpMenuOption.select_all,
                      child: ListTile(
                        leading: Icon(Icons.select_all),
                        title: Text(widget.translate.select_all),
                        subtitle: Divider(),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }
          leadingAnimation.reverse();
          return AppBar(
            iconTheme: IconThemeData(
              color: Theme.of(context).iconTheme.color,
            ),
            leading: IconButton(
              icon: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                progress: leadingAnimation,
              ),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              widget.translate.app_name,
              style: TextStyle(
                color: Theme.of(context).textTheme.headline6.color,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              ProfileIconButton(),
            ],
          );
        }
        return Container();
      },
    );
  }
}

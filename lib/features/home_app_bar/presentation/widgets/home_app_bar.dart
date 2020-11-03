import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_hard/core/Utils/archive_selected_notes.dart';
import 'package:task_hard/core/Utils/write_on.dart';
import 'package:task_hard/features/archive_notes/presentation/bloc/archivednotes_bloc.dart'
    as aN;
import 'package:task_hard/features/home_notes/presentation/bloc/homenotes_bloc.dart'
    as hN;
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/features/tags/presentation/widgets/tags_list_scaffold.dart';
import 'package:task_hard/features/time_preference/presentation/widgets/alert_reminder_container.dart';
import 'package:task_hard/generated/l10n.dart';

import '../../../../components/color-selector-component/color-selector-component.dart';
import '../../../../core/Utils/alert_dialog.dart';
import '../../../../core/Utils/alert_reminder_params.dart';
import '../../../../core/Utils/home_selected_notes.dart';
import '../../../../core/Utils/snackbar_context.dart';
import '../../../../core/widgets/profile_icon_button.dart';
import '../bloc/homeappbar_bloc.dart';

enum HomeAppBarPoUpMenuOption {
  change_color,
  delete,
  archive,
  select_all,
  tags,
  reminder,
}

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final S translate;
  final WriteOn box;
  final BuildContext alertContext;

  HomeAppBar({
    Key key,
    @required this.translate,
    @required this.alertContext,
    @required this.box,
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

  List<Note> getSelectedItems() {
    switch (widget.box) {
      case WriteOn.home:
        HomeSelectedNotes homeProvider =
            Provider.of<HomeSelectedNotes>(context, listen: false);
        return List<Note>.from(homeProvider.getNotes);
      case WriteOn.archive:
        ArchiveSelectedNotes archiveProvider =
            Provider.of<ArchiveSelectedNotes>(context, listen: false);
        return List<Note>.from(archiveProvider.getNotes);
      default:
        return <Note>[];
    }
  }

  void listen(HomeAppBarPoUpMenuOption option) {
    switch (widget.box) {
      case WriteOn.home:
        BlocProvider.of<hN.HomenotesBloc>(context).add(hN.GetHomeNotes());
        break;
      case WriteOn.archive:
        BlocProvider.of<aN.ArchivedNotesBloc>(context)
            .add(aN.GetArchivedNotes());
        if (shouldUpdateHome(option)) {
          BlocProvider.of<hN.HomenotesBloc>(context).add(hN.GetHomeNotes());
        }
        break;
      default:
    }
  }

  bool shouldUpdateHome(HomeAppBarPoUpMenuOption option) {
    switch (option) {
      case HomeAppBarPoUpMenuOption.delete:
        return true;
        break;
      case HomeAppBarPoUpMenuOption.archive:
        return true;
        break;
      case HomeAppBarPoUpMenuOption.reminder:
        return true;
      default:
        return false;
    }
  }

  void clearSelectedItems() {
    switch (widget.box) {
      case WriteOn.home:
        HomeSelectedNotes homeProvider =
            Provider.of<HomeSelectedNotes>(context, listen: false);
        homeProvider.clear();
        break;
      case WriteOn.archive:
        ArchiveSelectedNotes archiveProvider =
            Provider.of<ArchiveSelectedNotes>(context, listen: false);
        archiveProvider.clear();
        break;
      default:
    }
  }

  String getAppBarTitle() {
    switch (widget.box) {
      case WriteOn.home:
        return widget.translate.app_name;
      case WriteOn.archive:
        return widget.translate.archive;
      case WriteOn.deleted:
        return widget.translate.trash;
      default:
        return widget.translate.app_name;
    }
  }

  List<Note> getAllNotes() {
    switch (widget.box) {
      case WriteOn.home:
        hN.HomenotesState state =
            BlocProvider.of<hN.HomenotesBloc>(context).state;

        if (state is hN.HomenotesInitial) {
          return <Note>[];
        } else if (state is hN.Loaded) {
          Provider.of<HomeSelectedNotes>(context, listen: false).setList =
              List<Note>.from(state.notes.notes);
          return state.notes.notes;
        }
        return <Note>[];
        break;
      case WriteOn.archive:
        final aN.ArchivedNotesState state =
            BlocProvider.of<aN.ArchivedNotesBloc>(context).state;

        if (state is aN.ArchivedNotesInitial) {
          return <Note>[];
        } else if (state is aN.Loaded) {
          Provider.of<ArchiveSelectedNotes>(context, listen: false).setList =
              List<Note>.from(state.notes);
          return state.notes;
        }
        return <Note>[];
        break;
      default:
        return <Note>[];
    }
  }

  void manageTags() {
    List<Note> selectedNotes = getSelectedItems();
    clearSelectedItems();
    BlocProvider.of<HomeappbarBloc>(context).add(
      AddNote(
        selectedNotes: <Note>[],
      ),
    );
    showModal(
      context: context,
      builder: (_) {
        return TagsListScaffold(
          selectedNotesContext: context,
          notes: selectedNotes,
          box: widget.box,
        );
      },
    );
  }

  void selectAll() {
    BlocProvider.of<HomeappbarBloc>(context).add(
      AddNote(
        selectedNotes: getAllNotes(),
      ),
    );
  }

  void showReminder() {
    List<Note> selectedNotes = getSelectedItems();
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
                  box: widget.box,
                ),
              )
              ..add(AddNote(selectedNotes: <Note>[]));
            listen(HomeAppBarPoUpMenuOption.reminder);
            clearSelectedItems();
          },
          updateReminder: (AlertReminderParams params) {
            BlocProvider.of<HomeappbarBloc>(context)
              ..add(
                PutReminder(
                  selectedNotes: selectedNotes,
                  scheduledDate: params.scheduledDate,
                  repeat: params.repeat,
                  box: widget.box,
                ),
              )
              ..add(AddNote(selectedNotes: <Note>[]));
            listen(HomeAppBarPoUpMenuOption.reminder);
            clearSelectedItems();
          },
        );
      },
    );
  }

  void deleteNotes() {
    List<Note> selectedNotes = getSelectedItems();
    ShowDialog.alertDialog(
      context: context,
      flatText: widget.translate.cancel,
      title: widget.box != WriteOn.deleted
          ? widget.translate.delete_selected_notes
          : widget.translate.move_note_to_trash,
      raisedOnPressed: () {
        BlocProvider.of<HomeappbarBloc>(context)
          ..add(DeleteNotes(selectedNotes: selectedNotes, box: widget.box))
          ..add(AddNote(selectedNotes: <Note>[]));
        listen(HomeAppBarPoUpMenuOption.delete);
        clearSelectedItems();
        ShowSnackBar.show(
          context: context,
          title: widget.translate.done,
          actionMessage: widget.translate.undo,
          action: () {
            BlocProvider.of<HomeappbarBloc>(context)
              ..add(
                UndoDeleteNotes(
                  selectedNotes: selectedNotes,
                  box: widget.box,
                ),
              )
              ..add(
                AddNote(
                  selectedNotes: <Note>[],
                ),
              );
            listen(HomeAppBarPoUpMenuOption.delete);
          },
        );
        Navigator.pop(context);
      },
      raisedText: widget.translate.delete,
      icon: FontAwesomeIcons.trashAlt,
    );
  }

  void archiveNotes() {
    List<Note> selectedNotes = getSelectedItems();
    ShowDialog.alertDialog(
      context: context,
      flatText: widget.translate.cancel,
      title: widget.box == WriteOn.home
          ? widget.translate.archive_selected_notes
          : widget.translate.unarchived_selected_items,
      raisedOnPressed: () {
        BlocProvider.of<HomeappbarBloc>(context)
          ..add(
            ArchiveNotes(
              selectedNotes: selectedNotes,
              box: widget.box,
            ),
          )
          ..add(
            AddNote(
              selectedNotes: <Note>[],
            ),
          );
        listen(HomeAppBarPoUpMenuOption.archive);
        clearSelectedItems();
        Navigator.pop(context);
        ShowSnackBar.show(
          context: context,
          title: widget.translate.done,
          actionMessage: widget.translate.undo,
          action: () {
            BlocProvider.of<HomeappbarBloc>(context)
              ..add(
                UndoArchiveNotes(
                  selectedNotes: selectedNotes,
                  box: widget.box,
                ),
              )
              ..add(
                AddNote(
                  selectedNotes: <Note>[],
                ),
              );
            listen(HomeAppBarPoUpMenuOption.archive);
          },
        );
      },
      raisedText: widget.box != WriteOn.archive
          ? widget.translate.archive
          : widget.translate.unarchive,
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
            List<Note> selectedNotes = getSelectedItems();
            BlocProvider.of<HomeappbarBloc>(context)
              ..add(ChangeColor(
                selectedNotes: selectedNotes,
                color: color,
                box: widget.box,
              ))
              ..add(AddNote(selectedNotes: <Note>[]));
            listen(HomeAppBarPoUpMenuOption.change_color);
            clearSelectedItems();
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
      case HomeAppBarPoUpMenuOption.tags:
        manageTags();
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
            leading: widget.box == WriteOn.home
                ? IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  )
                : BackButton(),
            iconTheme: IconThemeData(
              color: Theme.of(context).iconTheme.color,
            ),
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              getAppBarTitle(),
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
                  clearSelectedItems();
                },
              ),
              title: Text(
                notes.length.toString(),
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline6.color,
                ),
              ),
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
                    PopupMenuItem<HomeAppBarPoUpMenuOption>(
                      value: HomeAppBarPoUpMenuOption.tags,
                      child: ListTile(
                        leading: Icon(Icons.label),
                        title: Text(widget.translate.tags),
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
            leading: widget.box == WriteOn.home
                ? IconButton(
                    icon: AnimatedIcon(
                      icon: AnimatedIcons.menu_close,
                      progress: leadingAnimation,
                    ),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  )
                : BackButton(),
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              getAppBarTitle(),
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

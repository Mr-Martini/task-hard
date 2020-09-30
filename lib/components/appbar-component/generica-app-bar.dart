import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_hard/features/time_preference/presentation/widgets/alert_reminder_container.dart';
import 'package:uuid/uuid.dart';

import '../../Utils/Utils.dart';
import '../../constants.dart';
import '../../controllers/colors-controller/color-controller.dart';
import '../../controllers/common/notifications-common.dart';
import '../../controllers/database-controller/hive-controller.dart';
import '../../controllers/reminder-controller/reminder-controller.dart';
import '../../controllers/selectedValues-controller/selected-values-controller.dart';
import '../../generated/l10n.dart';
import '../../views/about-screen/about-screen.dart';
import '../../views/profile-screen/profile-screen.dart';
import '../../views/settings-screen/settings-screen.dart';
import '../choose-tag-component/choose-component.dart';
import '../color-selector-component/color-selector-component.dart';
import '../edit-tag-component/edit-tage.dart';
import '../icon-components/icon-generic.dart';
import '../text-components/text-generic.dart';
import '../tooltip-component/tooltip-component.dart';

class GenericAppBar extends StatefulWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(55);

  final GlobalKey<ScaffoldState> scaffoldKey;
  final String title;
  final bool isFromArchiveScreen;
  final bool isFromTagScreen;
  final bool isFromSearchScreen;
  final bool isFromHomeScreen;
  final String tagName;
  final Function selectAll;
  final TextEditingController textEditingController;
  final ValueChanged<String> onChanged;
  final FocusNode focusNode;

  GenericAppBar({
    @required this.scaffoldKey,
    @required this.title,
    @required this.isFromArchiveScreen,
    @required this.isFromTagScreen,
    @required this.isFromSearchScreen,
    @required this.isFromHomeScreen,
    @required this.selectAll,
    this.tagName,
    this.textEditingController,
    this.onChanged,
    this.focusNode,
  }) : assert(
          scaffoldKey != null &&
              isFromSearchScreen != null &&
              isFromTagScreen != null &&
              isFromArchiveScreen != null &&
              isFromHomeScreen != null,
        );

  @override
  _GenericAppBarState createState() => _GenericAppBarState();
}

class _GenericAppBarState extends State<GenericAppBar> {
  bool hasReminder = false;
  NotificationsCommon nC = NotificationsCommon();
  HiveController hC = HiveController();
  ColorController cC = ColorController();
  String text;

  bool isEmpty(String text) {
    if (text == '' || text == null) return true;
    return false;
  }

  void checkIfHasReminder(SelectedValuesController sIC, S translate) {
    hasReminder = false;
    if (sIC.getSelectedItems.length > 1) {
      for (var item in sIC.getSelectedItems) {
        if (item['reminderDate'] != null) {
          hasReminder = true;
          return;
        }
      }
    } else {
      List<dynamic> object = sIC.getSelectedItems;
      DateTime reminderDate = object[0]['reminderDate'];
      if (reminderDate == null) {
        hasReminder = false;
        return;
      }
      hasReminder = true;
    }
  }

  void clearSelectedItems(SelectedValuesController sVC) {
    if (sVC.getSelectedItems.isNotEmpty) {
      sVC.clearSelectedItems();
    }
  }

  void showReminder(SelectedValuesController sVC, S translate) {
    showModal(
      configuration: FadeScaleTransitionConfiguration(),
      context: context,
      builder: (BuildContext context) {
        checkIfHasReminder(sVC, translate);
        return AlertReminderContainer(
          hasReminder: hasReminder,
          deleteReminder: () => nC.deleteReminder(
            sVC,
            translate,
            widget.scaffoldKey,
            context,
            hC,
          ),
          updateReminder: (values) {},
        );
      },
    );
  }

  void changeColor(SelectedValuesController sVC, Color color) {
    Navigator.pop(context);

    List notes = List.from(sVC.getSelectedItems);

    sVC.clearSelectedItems();

    for (var note in notes) {
      hC.updateColor(note['key'], color.toString());
    }
  }

  void deleteItems(SelectedValuesController sVC, S translate) {
    List items = List<dynamic>.from(sVC.getSelectedItems);
    sVC.clearSelectedItems();
    Navigator.pop(context);

    for (var note in items) {
      hC.moveToTrash(note['key']);
      ReminderController.cancel(note['reminderKey']);
    }

    Scaffold.of(context).showSnackBar(
      Utils.displaySnackBar(
        '${translate.moved} ${items.length} ${translate.notePlu} ${translate.to} ${translate.trashMinu}',
        context,
        actionMessage: translate.undo,
        onClick: () async {
          for (var note in items) {
            hC.restoreFromTrash(note['key']);
            ReminderController.scheduleNotification(
              note['key'],
              note['title'],
              note['note'],
              note['reminderKey'],
              note['reminderDate'],
              note['repeat'],
            );
          }
        },
      ),
    );
  }

  void archive(SelectedValuesController sVC, S translate) {
    List items = List<dynamic>.from(sVC.getSelectedItems);

    for (var item in items) {
      hC.moveToArchive(item['key']);
    }

    sVC.clearSelectedItems();
    Scaffold.of(context).showSnackBar(
      Utils.displaySnackBar(
        '${translate.moved} ${items.length} ${translate.notePlu} ${translate.to} ${translate.archiveMinu}',
        context,
        actionMessage: translate.undo,
        onClick: () async {
          for (var item in items) {
            hC.restoreFromArchive(item['key']);
          }
        },
      ),
    );
  }

  void showSnack(S translate, List notes, scaffoldKey, String title) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        elevation: 12,
        behavior: SnackBarBehavior.fixed,
        shape: RoundedRectangleBorder(),
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          title,
          style: TextStyle(color: Theme.of(context).textTheme.headline6.color),
        ),
        action: SnackBarAction(
          textColor: Theme.of(context).buttonColor,
          label: translate.undo,
          onPressed: () {
            for (var note in notes) {
              hC.moveToArchive(note['key']);
            }
          },
        ),
      ),
    );
  }

  void unarchive(SelectedValuesController sVC, S translate) {
    List allNotes = List.from(sVC.getSelectedItems);

    Utils.alertDialog(
      context,
      sVC.getSelectedItems.length > 1
          ? '${translate.restore} ${allNotes.length} ${translate.notes} ?'
          : translate.restore_selected_note,
      () => Navigator.pop(context),
      translate.no,
      () async {
        Navigator.pop(context);
        List notes = List<dynamic>.from(sVC.getSelectedItems);

        for (var note in notes) {
          hC.restoreFromArchive(note['key']);
        }

        sVC.clearSelectedItems();
        allNotes = [];

        showSnack(
          translate,
          notes,
          widget.scaffoldKey,
          '${notes.length} ${translate.notes} ${translate.restored}',
        );
      },
      translate.unarchive,
      icon: IconGeneric(
        androidIcon: Icons.unarchive,
        iOSIcon: CupertinoIcons.folder_solid,
        semanticLabel: translate.restore,
        toolTip: translate.restore,
        color: Colors.white,
        size: 20,
      ),
      material: true,
    );
  }

  void removeTag(SelectedValuesController sVC, S translate) {
    List notes = List.from(sVC.getSelectedItems);
    sVC.clearSelectedItems();

    for (var note in notes) {
      hC.deleteTagFromNote(note['key'], widget.tagName);
    }

    Scaffold.of(context).showSnackBar(
      Utils.displaySnackBar(
        translate.done,
        context,
        actionMessage: translate.undo,
        onClick: () {
          for (var note in notes) {
            hC.putTagOnNote(note['key'], widget.tagName);
          }
        },
      ),
    );
  }

  void showUndoSnack({
    @required Function undo,
    @required GlobalKey<ScaffoldState> scaffoldKey,
    @required S translate,
  }) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        elevation: 12,
        behavior: SnackBarBehavior.fixed,
        shape: RoundedRectangleBorder(),
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          translate.done,
          style: TextStyle(color: Theme.of(context).textTheme.headline6.color),
        ),
        action: SnackBarAction(
          textColor: Theme.of(context).buttonColor,
          label: translate.undo,
          onPressed: undo,
        ),
      ),
    );
  }

  ///this function should be called inside
  ///ChooseTag
  void updateTagModal(SelectedValuesController sVC, String tagName) {
    ///creates a copy of the selected notes
    List notes = List.from(sVC.getSelectedItems);

    ///iterates over each note and calls [putTagOnNote]
    for (var note in notes) {
      ///get the note key
      String key = note['key'];

      hC.putTagOnNote(key, tagName);
    }
  }

  ///this functions should be called by the [ChooseTag] component
  void deleteTagModal(SelectedValuesController sVC, String tagName) {
    ///creates a copy of the selected notes
    List notes = List.from(sVC.getSelectedItems);

    ///iterates over each note, calls [deleteTagFromNote]
    for (var note in notes) {
      ///get the note key
      String key = note['key'];

      hC.deleteTagFromNote(key, tagName);
    }
  }

  ///this functions calls the [ChooseTag] component
  void chooseTag(SelectedValuesController sVC) {
    ///get the selected items
    List notes = sVC.getSelectedItems;

    ///check if there are more than 1 selected items
    ///since the functions are different for individual
    ///and multiple selected items
    if (notes.length > 1) {
      ///calls showModalBottomSheet with a stateFul builder,
      ///so the bottom sheet can call setState and rebuild itSelf
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setModalState) {
              return ChooseTag(
                updateTag: (String tagName) {
                  updateTagModal(sVC, tagName);

                  ///setState must be called so the bottom sheet
                  ///can rebuild itSelf
                  setModalState(() {});
                },
                deleteTag: (String tagName) {
                  deleteTagModal(sVC, tagName);

                  ///setState must be called so the bottom sheet
                  ///can rebuild itSelf
                  setModalState(() {});
                },
                multiple: true,
              );
            },
          );
        },
      );
    } else {
      ///gets the key of the first note
      String noteKey = notes[0]['key'];

      showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, setModalState) {
              return ChooseTag(
                ///if there's only one selected note, the
                ///key should be passed so [ChooseTag] can
                ///verify which tags the note has
                noteKey: noteKey,
                updateTag: (String tagName) {
                  updateTagModal(sVC, tagName);

                  ///setState must be called so the bottom sheet
                  ///can rebuild itSelf
                  setModalState(() {});
                },
                deleteTag: (String tagName) {
                  deleteTagModal(sVC, tagName);

                  ///setState must be called so the bottom sheet
                  ///can rebuild itSelf
                  setModalState(() {});
                },
                multiple: null,
              );
            },
          );
        },
      );
    }
  }

  ///This function should be used when the user TYPES a new tag///
  void addTagDialog(SelectedValuesController sVC, String tagName, S translate) {
    ///create a copy of all the selected notes.///
    List notes = List.from(sVC.getSelectedItems);

    ///clear the selected notes and pop context
    sVC.clearSelectedItems();
    Navigator.pop(context);

    ///iterates over each note, calls putTagOnNote to put a
    ///single tag on a single note
    for (var note in notes) {
      ///get note key///
      String key = note['key'];

      ///write tag on the current note///
      hC.putTagOnNote(key, tagName);
    }

    ///verify if there's a tag with that name already
    ///then change the [hasTag] value
    bool hasTag = false;

    for (var tag in hC.getTags()) {
      if (tag['name'] == tagName) {
        hasTag = true;
        break;
      }
    }

    ///if there's not tag with that name, creates one
    if (!hasTag) {
      ///uses [Uuid] v4 to create a unique key for this tag
      String key = Uuid().v4();

      ///this function creates a tag
      hC.putTag(tagName, key);
    }

    ///now the undo snackbar should be presented to the user.
    ///calls Utils class to show a snackbar
    ///the undo snack doesn't undo the creation of the tag
    ///it only removes the tag from the notes
    Utils.displaySnackBar(
      translate.done,
      context,
      actionMessage: translate.undo,
      onClick: () {
        ///iterates over each notes. Calls [deleteTagFromNote]
        ///to delete one tag from one note at a time
        for (var note in notes) {
          ///get note key
          String key = note['key'];

          hC.deleteTagFromNote(key, tagName);
        }
      },
    );
  }

  ///This function should be executed when the user taps the DELETE button
  ///from the alertDialog
  void deleteTagDialog(SelectedValuesController sVC, S translate) {
    ///creates a copy of all selected notes
    List notes = List.from(sVC.getSelectedItems);

    ///clear selected items and pop context
    sVC.clearSelectedItems();
    Navigator.pop(context);

    ///iterates over each note, deleting all tags from the note
    for (var note in notes) {
      ///get the note key
      String key = note['key'];

      hC.deleteAllTagsFromNote(key);
    }
  }

  void addTag(SelectedValuesController sVC, S translate) {
    ///get all selected notes.///
    List notes = sVC.getSelectedItems;

    ///hasTag verify if any note has a tag, so the delete button
    ///can appear
    bool hasTag = false;

    for (var note in notes) {
      List<dynamic> tags = note['tags'] ?? [];
      if (tags.isNotEmpty) {
        hasTag = true;
        break;
      }
    }

    ///show dialog for edit tag or choose a
    ///already existing tag for multiple items
    showDialog(
      context: context,
      builder: (BuildContext context) {
        ///EditTag is a custom UI for editing tag
        ///or choosing one
        return EditTag(
          deleteTag: () => deleteTagDialog(sVC, translate),
          updateTag: (String tagName) => addTagDialog(sVC, tagName, translate),
          hasTag: hasTag,
          chooseTag: () => chooseTag(sVC),
        );
      },
    );
  }

  void onSelected(String choice, S translate, SelectedValuesController sVC) {
    if (choice == translate.select_all) {
      widget.selectAll();
    } else if (choice == translate.archive) {
      archive(sVC, translate);
    } else if (choice == translate.unarchive) {
      unarchive(sVC, translate);
    } else if (choice == translate.remove_tag) {
      removeTag(sVC, translate);
    } else if (choice == translate.tag) {
      addTag(sVC, translate);
    }
  }

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    String title = widget.title;
    String tagName = widget.tagName;
    bool isFromArchiveScreen = widget.isFromArchiveScreen;
    bool isFromTagScreen = widget.isFromTagScreen;
    bool isFromSearchScreen = widget.isFromSearchScreen;
    bool isFromHomeScreen = widget.isFromHomeScreen;
    FocusNode focusNode = widget.focusNode;
    TextEditingController textEditingController = widget.textEditingController;
    ValueChanged<String> onChanged = widget.onChanged;

    return Consumer<SelectedValuesController>(
      builder: (context, sVC, widget) {
        if (sVC.getSelectedItems.isEmpty) {
          if (isFromTagScreen) {
            return AppBar(
              iconTheme: IconThemeData(
                color: Colors.grey[400],
              ),
              leading: BackButton(
                onPressed: () {
                  if (sVC.getSelectedItems.isNotEmpty) {
                    sVC.clearSelectedItems();
                  }
                  Navigator.pop(context);
                },
              ),
              title: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 0.8),
                duration: Duration(milliseconds: 800),
                builder: (context, value, child) {
                  if (value == 0.8) {
                    return TextField(
                      autofocus: false,
                      controller: textEditingController,
                      autocorrect: true,
                      keyboardType: TextInputType.text,
                      onChanged: (String newText) {
                        text = newText;
                        onChanged(newText);
                      },
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: translate.search_hint_text,
                        prefixIcon: IconGeneric(
                          androidIcon: Icons.search,
                          iOSIcon: CupertinoIcons.search,
                          color: Colors.grey,
                          semanticLabel: translate.search,
                          toolTip: translate.search,
                        ),
                        suffixIcon: isEmpty(text)
                            ? null
                            : IconButton(
                                onPressed: () {
                                  text = '';
                                  onChanged('');
                                  textEditingController.text = '';
                                },
                                icon: IconGeneric(
                                  androidIcon: Icons.clear,
                                  iOSIcon: CupertinoIcons.clear,
                                  semanticLabel: translate.clear,
                                  toolTip: translate.clear,
                                ),
                              ),
                      ),
                    );
                  }
                  return ScaleAnimatedTextKit(
                    repeatForever: false,
                    totalRepeatCount: 1,
                    duration: Duration(milliseconds: 800),
                    text: [tagName],
                    textStyle: TextStyle(
                      color: Theme.of(context).textTheme.headline6.color,
                    ),
                  );
                },
                child: TextField(
                  autofocus: false,
                  controller: textEditingController,
                  autocorrect: true,
                  keyboardType: TextInputType.text,
                  onChanged: (String newText) {
                    text = newText;
                    onChanged(newText);
                  },
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: translate.search_hint_text,
                    prefixIcon: IconGeneric(
                      androidIcon: Icons.search,
                      iOSIcon: CupertinoIcons.search,
                      color: Colors.grey,
                      semanticLabel: translate.search,
                      toolTip: translate.search,
                    ),
                    suffixIcon: isEmpty(text)
                        ? null
                        : IconButton(
                            onPressed: () {
                              text = '';
                              onChanged('');
                              textEditingController.text = '';
                            },
                            icon: IconGeneric(
                              androidIcon: Icons.clear,
                              iOSIcon: CupertinoIcons.clear,
                              semanticLabel: translate.clear,
                              toolTip: translate.clear,
                            ),
                          ),
                  ),
                ),
              ),
            );
          } else if (isFromSearchScreen) {
            return AppBar(
              leading: null,
              title: TextField(
                autofocus: false,
                controller: textEditingController,
                autocorrect: true,
                focusNode: focusNode,
                keyboardType: TextInputType.text,
                onChanged: (String newText) {
                  text = newText;
                  onChanged(newText);
                },
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: translate.search_hint_text,
                  prefixIcon: IconGeneric(
                    androidIcon: Icons.search,
                    iOSIcon: CupertinoIcons.search,
                    color: Colors.grey,
                    semanticLabel: translate.search,
                    toolTip: translate.search,
                  ),
                  suffixIcon: isEmpty(text)
                      ? null
                      : IconButton(
                          onPressed: () {
                            text = '';
                            onChanged('');
                            textEditingController.text = '';
                          },
                          icon: IconGeneric(
                            androidIcon: Icons.clear,
                            iOSIcon: CupertinoIcons.clear,
                            semanticLabel: translate.clear,
                            toolTip: translate.clear,
                          ),
                        ),
                ),
              ),
            );
          } else if (isFromHomeScreen) {
            return AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              iconTheme: IconThemeData(color: Colors.grey[500]),
              elevation: 0,
              title: TextGeneric(
                text: S.of(context).app_name,
                letterSpacing: 1.5,
                fontSize: kSectionTitleSize,
                bold: FontWeight.w900,
              ),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                  icon: CircleAvatar(
                    backgroundImage: AssetImage('images/ProfilePhoto.jpg'),
                    radius: 16,
                  ),
                  onPressed: () {
                    showModal(
                      configuration: FadeScaleTransitionConfiguration(),
                      context: context,
                      builder: (context) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        title: TextGeneric(
                          text: translate.quick_actions,
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ToolTipComponent(
                              message: translate.tooltip_go_to_profile_screen,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(
                                      context, ProfileScreen.id);
                                },
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        AssetImage('images/ProfilePhoto.jpg'),
                                  ),
                                  title: TextGeneric(
                                    text: 'Marcos Martini',
                                    fontSize: 14,
                                  ),
                                  subtitle: TextGeneric(
                                    text: 'marcosmartini765@gmail.com',
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                            Divider(),
                            Container(
                              height: 160,
                              child: ListView(
                                padding: EdgeInsets.zero,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(
                                          context, SettingsScreen.id);
                                    },
                                    child: ListTile(
                                      title: TextGeneric(
                                        text: translate.settings,
                                      ),
                                      leading: IconGeneric(
                                        androidIcon: Icons.settings,
                                        iOSIcon: CupertinoIcons.settings,
                                        toolTip: translate.app_settings,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => Navigator.pushNamed(
                                        context, AboutScreen.id),
                                    child: ListTile(
                                      title: TextGeneric(text: translate.about),
                                      leading: IconGeneric(
                                        androidIcon: Icons.info,
                                        iOSIcon: CupertinoIcons.info,
                                        toolTip: translate.app_about,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: ListTile(
                                      title:
                                          TextGeneric(text: translate.sign_out),
                                      leading: IconGeneric(
                                        androidIcon: Icons.exit_to_app,
                                        iOSIcon: CupertinoIcons.person_solid,
                                        toolTip: translate.sign_out,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          }

          return AppBar(
            iconTheme: IconThemeData(color: Colors.grey[500]),
            leading: BackButton(
              onPressed: () {
                if (sVC.getSelectedItems.isNotEmpty) {
                  sVC.clearSelectedItems();
                }
                Navigator.pop(context);
              },
            ),
            title: TextGeneric(
              text: title,
              fontSize: kSectionTitleSize,
            ),
            centerTitle: true,
          );
        }
        return AppBar(
          iconTheme: IconThemeData(color: Colors.grey[500]),
          leading: IconButton(
            icon: IconGeneric(
              androidIcon: Icons.close,
              iOSIcon: CupertinoIcons.clear,
              semanticLabel: translate.clear,
              toolTip: translate.clear,
            ),
            onPressed: () => clearSelectedItems(sVC),
          ),
          title: TextGeneric(text: sVC.getSelectedItems.length.toString()),
          actions: [
            IconButton(
              onPressed: () => showReminder(sVC, translate),
              icon: IconGeneric(
                androidIcon: Icons.add_alert,
                iOSIcon: CupertinoIcons.clock_solid,
                semanticLabel: translate.add_a_reminder,
                toolTip: translate.add_a_reminder,
              ),
            ),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    ),
                  ),
                  context: context,
                  builder: (BuildContext context) => ColorSelector(
                    onTap: (Color color) {
                      changeColor(sVC, color);
                    },
                  ),
                );
              },
              icon: IconGeneric(
                androidIcon: Icons.palette,
                iOSIcon: CupertinoIcons.tag_solid,
                semanticLabel: translate.change_color,
                toolTip: translate.change_color,
              ),
            ),
            IconButton(
              onPressed: () {
                Utils.alertDialog(
                  context,
                  sVC.getSelectedItems.length > 1
                      ? translate.delete_selected_notes
                      : translate.delete_selected_note,
                  () => Navigator.pop(context),
                  translate.no,
                  () => deleteItems(sVC, translate),
                  translate.delete,
                  icon: IconGeneric(
                    androidIcon: FontAwesomeIcons.trashAlt,
                    iOSIcon: CupertinoIcons.delete_solid,
                    semanticLabel: translate.delete,
                    toolTip: translate.delete,
                    color: Colors.white,
                    size: 16,
                  ),
                );
              },
              icon: IconGeneric(
                androidIcon: FontAwesomeIcons.solidTrashAlt,
                iOSIcon: FontAwesomeIcons.solidTrashAlt,
                semanticLabel: translate.delete,
                toolTip: translate.delete,
                size: 19,
              ),
            ),
            StatefulBuilder(
              builder: (context, setState) => PopupMenuButton(
                onSelected: (String choice) {
                  onSelected(choice, translate, sVC);
                },
                itemBuilder: (BuildContext context) {
                  Map<String, IconGeneric> choices = {
                    translate.select_all: IconGeneric(
                      androidIcon: Icons.select_all,
                      iOSIcon: CupertinoIcons.check_mark_circled_solid,
                      semanticLabel: translate.select_all,
                      toolTip: translate.select_all,
                    ),
                    translate.info: IconGeneric(
                      androidIcon: Icons.info,
                      iOSIcon: CupertinoIcons.info,
                      semanticLabel: translate.info,
                      toolTip: translate.info,
                    ),
                  };
                  if (isFromArchiveScreen) {
                    choices.addAll(<String, IconGeneric>{
                      translate.unarchive: IconGeneric(
                        androidIcon: Icons.archive,
                        iOSIcon: CupertinoIcons.folder_solid,
                        semanticLabel: translate.unarchive,
                        toolTip: translate.unarchive,
                      )
                    });
                  } else {
                    choices.addAll(<String, IconGeneric>{
                      translate.archive: IconGeneric(
                        androidIcon: Icons.archive,
                        iOSIcon: CupertinoIcons.folder_solid,
                        semanticLabel: translate.archive,
                        toolTip: translate.archive,
                      )
                    });
                  }
                  if (isFromTagScreen) {
                    choices.addAll(<String, IconGeneric>{
                      translate.remove_tag: IconGeneric(
                        androidIcon: Icons.label,
                        iOSIcon: CupertinoIcons.tag_solid,
                        semanticLabel: translate.remove_tag,
                        toolTip: translate.remove_tag,
                      )
                    });
                  } else {
                    choices.addAll(<String, IconGeneric>{
                      translate.tag: IconGeneric(
                        androidIcon: Icons.label,
                        iOSIcon: CupertinoIcons.tag_solid,
                        semanticLabel: translate.tag,
                        toolTip: translate.tag,
                      )
                    });
                  }
                  return choices.keys.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: ListTile(
                        title: TextGeneric(text: choice),
                        leading: choices[choice],
                      ),
                    );
                  }).toList();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

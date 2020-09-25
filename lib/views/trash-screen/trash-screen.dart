import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/Utils.dart';
import '../../components/appbar-component/trash-app-bar-component.dart';
import '../../components/empty-folder-component/empty-folder.dart';
import '../../components/icon-components/icon-generic.dart';
import '../../components/information-box-component/information-box-component.dart';
import '../../components/notes-components/card-note-component.dart';
import '../../components/text-components/text-generic.dart';
import '../../controllers/common/sort-timestamp.dart';
import '../../controllers/database-controller/hive-controller.dart';
import '../../controllers/reminder-controller/reminder-controller.dart';
import '../../controllers/selectedValues-controller/selected-values-controller.dart';
import '../../controllers/view-controller/view-controller.dart';
import '../../generated/l10n.dart';
import '../home-screen/home-screen.dart';
import '../new-task-screen/deleted-task.dart';

class TrashScreen extends StatefulWidget {
  static const String id = 'trash_screen';

  @override
  _TrashScreenState createState() => _TrashScreenState();
}

class _TrashScreenState extends State<TrashScreen> {
  List allNotes = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  HiveController hC = HiveController();

  void showSimpleSnack(String title, scaffoldKey) {
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
      ),
    );
  }

  void showSnack(S translate, String title, List items, scaffoldKey) {
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
          onPressed: () async {
            for (var note in items) {
              hC.deleteNote(note['key']);
              ReminderController.cancel(note['reminderKey']);
            }
          },
        ),
      ),
    );
  }

  List filter(List raw) {
    var aux = raw.where((element) => element['trash'] == true);
    return aux.toList();
  }

  void writeTrashMessagePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('already_seen_message', true);
  }

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);
    SelectedValuesController sIC =
        Provider.of<SelectedValuesController>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        if (sIC.getSelectedItems.isNotEmpty) {
          sIC.clearSelectedItems();
          return false;
        }
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: TrashAppBar(
          cancelSelection: () {
            sIC.clearSelectedItems();
          },
          onPop: () {
            if (sIC.getSelectedItems.isNotEmpty) {
              sIC.clearSelectedItems();
            }
            Navigator.pop(context);
          },
          selectAll: () {
            if (sIC.getSelectedItems.length == allNotes.length) {
              sIC.clearSelectedItems();
              return;
            }
            sIC.setSelectedItems = allNotes;
          },
          restore: () async {
            if (allNotes.isEmpty) return;

            Utils.alertDialog(
              context,
              sIC.getSelectedItems.length > 1
                  ? '${translate.restore} ${sIC.getSelectedItems.length} ${translate.notes}?'
                  : translate.restore_selected_note,
              () => Navigator.pop(context),
              translate.no,
              () async {
                Navigator.pop(context);
                List items = List.from(sIC.getSelectedItems);
                sIC.clearSelectedItems();

                for (var item in items) {
                  hC.restoreFromTrash(item['key']);
                  ReminderController.scheduleNotification(
                    item['key'],
                    item['title'],
                    item['note'],
                    item['reminderKey'],
                    item['reminderDate'],
                    item['repeat'],
                  );
                }

                showSnack(
                    translate,
                    '${items.length} ${translate.notes} ${translate.restored}',
                    items,
                    _scaffoldKey);
              },
              translate.Ok,
            );
          },
          deleteAll: () async {
            Utils.alertDialog(
              context,
              sIC.getSelectedItems.length > 1
                  ? translate.delete_selected_notes
                  : translate.delete_selected_note,
              () => Navigator.pop(context),
              translate.no,
              () async {
                Navigator.pop(context);
                List items = List<dynamic>.from(sIC.getSelectedItems);
                sIC.clearSelectedItems();

                for (var item in items) {
                  hC.deleteNote(item['key']);
                  ReminderController.cancel(item['reminderKey']);
                }

                showSimpleSnack(
                    '${items.length} ${translate.notePlu} ${translate.deleted}',
                    _scaffoldKey);
              },
              translate.Ok,
            );
          },
        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box('notes').listenable(),
          builder: (context, Box<dynamic> box, widget) {
            List raw = box.values.toList();
            raw = filter(raw);
            allNotes = raw;
            if (raw.isEmpty) {
              return EmptyFolder(
                androidIcon: FontAwesomeIcons.trashAlt,
                title: translate.empty_trash,
                iOSIcon: FontAwesomeIcons.trashAlt,
                subTitle: translate.notes_your_delete,
                toolTip: translate.deleted_notes,
              );
            } else {
              List data = SortByTimestamp.sort(raw);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    InformationBox(
                      title: translate.trash_will_clean,
                      action: FlatButton(
                        onPressed: () {},
                        child: TextGeneric(text: translate.empty_trash),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Consumer<ViewController>(
                      builder: (context, vC, child) => Expanded(
                        child: StaggeredGridView.countBuilder(
                          crossAxisCount: 2,
                          scrollDirection: Axis.vertical,
                          physics: BouncingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) =>
                              CardNote(
                            onTap: () {
                              if (sIC.getSelectedItems.isEmpty) {
                                Navigator.pushNamed(
                                  context,
                                  DeletedTaskScreen.id,
                                  arguments: Arguments(
                                    key: data[index]['key'],
                                    note: data[index]['note'],
                                    title: data[index]['title'],
                                    color: data[index]['color'],
                                    reminderDate: data[index]['reminderDate'],
                                    reminderKey: data[index]['reminderKey'],
                                    expired: data[index]['expired'],
                                    repeat: data[index]['repeat'],
                                    ignoreTap: false,
                                  ),
                                );
                              }
                            },
                            onLongPress: () {},
                            title: data[index]['title'],
                            note: data[index]['note'],
                            color: data[index]['color'],
                            notesCount: data.length,
                            alarmToolTip: translate.alarm,
                            reminderDate: data[index]['reminderDate'],
                            repeat: data[index]['repeat'],
                            maxHeight: vC.getMaxHeight,
                            minHeight: vC.getMinHeight,
                            expired: data[index]['expired'],
                            isSelected: (bool isSelected) {
                              if (isSelected) {
                                sIC.setSelectedItem = data[index];
                              } else {
                                sIC.removeSelectedItem(data[index]);
                              }
                            },
                          ),
                          staggeredTileBuilder: (int index) =>
                              StaggeredTile.fit(vC.getCrossAxisCellCount),
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (allNotes.isEmpty) {
              showSimpleSnack(translate.empty_trash, _scaffoldKey);
              return null;
            }

            Utils.alertDialog(
              context,
              translate.perma_delete_question,
              () => Navigator.pop(context),
              translate.no,
              () {
                List items = List<dynamic>.from(allNotes);
                allNotes = [];

                Navigator.pop(context);
                sIC.clearSelectedItems();

                for (var item in items) {
                  hC.deleteNote(item['key']);
                }

                showSimpleSnack(
                    '${items.length} ${translate.notes} ${translate.deleted}',
                    _scaffoldKey);
              },
              translate.Ok,
            );
          },
          backgroundColor: Theme.of(context).buttonColor,
          child: IconGeneric(
            androidIcon: Icons.delete_forever,
            iOSIcon: Icons.delete_forever,
            semanticLabel: translate.restore_all_notes_question,
            toolTip: translate.restore_all_notes_question,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

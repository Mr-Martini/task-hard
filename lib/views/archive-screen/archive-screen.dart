import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../Utils/Utils.dart';
import '../../components/appbar-component/generica-app-bar.dart';
import '../../components/empty-folder-component/empty-folder.dart';
import '../../components/icon-components/icon-generic.dart';
import '../../components/notes-components/card-note-component.dart';
import '../../controllers/common/notifications-common.dart';
import '../../controllers/common/sort-timestamp.dart';
import '../../controllers/database-controller/hive-controller.dart';
import '../../controllers/selectedValues-controller/selected-values-controller.dart';
import '../../controllers/view-controller/view-controller.dart';
import '../../generated/l10n.dart';
import '../home-screen/home-screen.dart' show Arguments;
import '../new-task-screen/new-task-screen.dart';

class ArchiveScreen extends StatefulWidget {
  static const String id = 'archive_screen';

  @override
  _ArchiveScreenState createState() => _ArchiveScreenState();
}

class _ArchiveScreenState extends State<ArchiveScreen> {
  List allNotes = [];
  HiveController hC = HiveController();
  NotificationsCommon nC = NotificationsCommon();

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

  void showSimpleSnack(S translate, scaffoldKey) {
    scaffoldKey.currentState.showSnackBar(
      SnackBar(
        elevation: 12,
        behavior: SnackBarBehavior.fixed,
        shape: RoundedRectangleBorder(),
        backgroundColor: Theme.of(context).primaryColor,
        content: Text(
          translate.no_notes_to_restore,
          style: TextStyle(color: Theme.of(context).textTheme.headline6.color),
        ),
      ),
    );
  }

  List filter(List raw) {
    var aux = raw.where((element) {
      bool isArchived() {
        if (element['archived'] == true) {
          return true;
        }
        return false;
      }

      bool isDeleted() {
        if (element['trash'] == true) {
          return true;
        }
        return false;
      }

      return isArchived() && !isDeleted();
    });
    return aux.toList();
  }

  void selectAll(SelectedValuesController sVC) {
    if (sVC.getSelectedItems.length == allNotes.length) {
      sVC.clearSelectedItems();
      return;
    }
    sVC.setSelectedItems = allNotes;
  }

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    final _scaffoldKey = GlobalKey<ScaffoldState>();

    SelectedValuesController sIC =
        Provider.of<SelectedValuesController>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        if (sIC.getSelectedItems.length >= 1) {
          sIC.clearSelectedItems();
          return false;
        }
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: GenericAppBar(
          scaffoldKey: _scaffoldKey,
          title: translate.archived,
          isFromArchiveScreen: true,
          isFromTagScreen: false,
          isFromSearchScreen: false,
          selectAll: () => selectAll(sIC),
          isFromHomeScreen: false,
        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box('notes').listenable(),
          builder: (context, Box<dynamic> box, widget) {
            List raw = box.values.toList();
            raw = filter(raw);
            allNotes = raw;
            if (raw.isEmpty) {
              return EmptyFolder(
                androidIcon: Icons.archive,
                title: translate.no_notes_archived,
                iOSIcon: Icons.folder,
                subTitle: translate.notes_your_archive,
                toolTip: translate.archived_notes,
              );
            } else {
              List data = SortByTimestamp.sort(raw);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
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
                                  NewTask.id,
                                  arguments: Arguments(
                                    key: data[index]['key'],
                                    note: data[index]['note'],
                                    title: data[index]['title'],
                                    color: data[index]['color'],
                                    reminderDate: data[index]['reminderDate'],
                                    reminderKey: data[index]['reminderKey'],
                                    ignoreTap: false,
                                    archived: true,
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
          backgroundColor: Theme.of(context).buttonColor,
          onPressed: () async {
            if (allNotes.isEmpty) {
              showSimpleSnack(translate, _scaffoldKey);
              return null;
            }

            Utils.alertDialog(
              context,
              translate.restore_all_notes_question,
              () => Navigator.pop(context),
              translate.no,
              () async {
                Navigator.pop(context);
                List items = allNotes;
                sIC.clearSelectedItems();

                for (var item in items) {
                  hC.restoreFromArchive(item['key']);
                }

                showSnack(translate, items, _scaffoldKey,
                    '${translate.restored} ${items.length} ${translate.notes}');

                allNotes = [];
              },
              translate.Ok,
            );
          },
          child: IconGeneric(
            androidIcon: Icons.unarchive,
            iOSIcon: CupertinoIcons.folder_solid,
            semanticLabel: translate.restore_all,
            toolTip: translate.restore_all,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

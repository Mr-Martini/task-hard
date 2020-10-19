import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../components/appbar-component/generica-app-bar.dart';
import '../../components/decent-listtile-component/decent-listtile-component.dart';
import '../../components/empty-folder-component/empty-folder.dart';
import '../../components/notes-components/card-note-component.dart';
import '../../controllers/common/notifications-common.dart';
import '../../controllers/common/search-algorithm.dart';
import '../../controllers/database-controller/hive-controller.dart';
import '../../controllers/search-screen-focus/search-screen-focus.dart';
import '../../controllers/selectedValues-controller/selected-values-controller.dart';
import '../../controllers/view-controller/view-controller.dart';
import '../../generated/l10n.dart';
import '../archive-screen/archive-screen.dart';
import '../home-screen/home-screen.dart' show Arguments;
import '../new-task-screen/new-task-screen.dart';
import '../trash-screen/trash-screen.dart';

class SearchScreen extends StatefulWidget {
  static const String id = 'search_screen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  FocusNode _clickAWay = FocusNode();
  TextEditingController _textEditingController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List allNotes = [];
  String text;
  bool hasReminder = false;
  HiveController hC = HiveController();
  NotificationsCommon nC = NotificationsCommon();

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

  List filter(List raw) {
    if (isEmpty(text)) return [];

    var aux = raw.where(
      (element) {
        bool isArchived(element) {
          if (element['archived'] == true) {
            return true;
          }
          return false;
        }

        bool isDeleted(element) {
          if (element['trash'] == true) {
            return true;
          }
          return false;
        }

        return !isDeleted(element) && !isArchived(element);
      },
    );
    return aux.toList();
  }

  @override
  void initState() {
    super.initState();
    SearchScreenFocus.initializeFocus();
  }

  void onChanged(String newText) {
    setState(() {
      text = newText;
    });
  }

  void selectAll(SelectedValuesController sVC) {
    if (sVC.getSelectedItems.length == allNotes.length) {
      sVC.clearSelectedItems();
      return;
    }
    sVC.setSelectedItems = allNotes;
  }

  @override
  void dispose() {
    SearchScreenFocus.dispose();
    _clickAWay.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  bool isEmpty(String aux) {
    if (aux == '' || aux == null) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);
    SelectedValuesController sIC =
        Provider.of<SelectedValuesController>(context, listen: false);

    return GestureDetector(
      onTap: () {
        SearchScreenFocus.unFocus();
        _clickAWay.requestFocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          if (sIC.getSelectedItems.isNotEmpty) {
            sIC.clearSelectedItems();
            return false;
          }
          return true;
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: GenericAppBar(
            scaffoldKey: _scaffoldKey,
            title: null,
            isFromArchiveScreen: false,
            isFromTagScreen: false,
            isFromSearchScreen: true,
            isFromHomeScreen: false,
            selectAll: () => selectAll(sIC),
            textEditingController: _textEditingController,
            onChanged: onChanged,
            focusNode: SearchScreenFocus.focusNode,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: DecentListTile(
                            iOSIcon: CupertinoIcons.folder_solid,
                            androidIcon: Icons.archive,
                            text: translate.archived,
                            semanticLabel: translate.archived_notes,
                            toolTip: translate.archived_notes,
                            onTap: () {
                              if (sIC.getSelectedItems.isNotEmpty) {
                                sIC.clearSelectedItems();
                              }
                              Navigator.pushNamed(context, ArchiveScreen.id);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Flexible(
                          child: DecentListTile(
                            iOSIcon: FontAwesomeIcons.solidTrashAlt,
                            androidIcon: FontAwesomeIcons.solidTrashAlt,
                            text: translate.trash,
                            semanticLabel: translate.deleted_notes,
                            toolTip: translate.deleted_notes,
                            iconSize: 20,
                            onTap: () {
                              if (sIC.getSelectedItems.isNotEmpty) {
                                sIC.clearSelectedItems();
                              }
                              Navigator.pushNamed(context, TrashScreen.id);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ValueListenableBuilder(
                    valueListenable: Hive.box('notes').listenable(),
                    builder: (context, Box<dynamic> box, widget) {
                      List raw = box.values.toList();
                      List notes = filter(raw);
                      notes = SearchAlgorithm.search(notes, text);
                      allNotes = notes;
                      if (notes.isEmpty && isEmpty(text)) {
                        return EmptyFolder(
                          androidIcon: Icons.search,
                          title: translate.tap_button_search,
                          iOSIcon: Icons.search,
                          subTitle: '',
                          toolTip: translate.search,
                        );
                      } else if (notes.isEmpty && !isEmpty(text)) {
                        return EmptyFolder(
                          androidIcon: Icons.search,
                          title: translate.nothing_found,
                          iOSIcon: Icons.search,
                          subTitle: '',
                          toolTip: translate.search,
                        );
                      } else {
                        List data = notes;
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(
                                height: 8,
                              ),
                              Consumer<ViewController>(
                                builder: (context, vC, child) =>
                                    StaggeredGridView.countBuilder(
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.vertical,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
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
                                            reminderDate: data[index]
                                                ['reminderDate'],
                                            reminderKey: data[index]
                                                ['reminderKey'],
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
                                      StaggeredTile.fit(
                                          vC.getCrossAxisCellCount),
                                  mainAxisSpacing: 4.0,
                                  crossAxisSpacing: 4.0,
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
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

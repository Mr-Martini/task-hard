import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../components/appbar-component/generica-app-bar.dart';
import '../../components/create-note-bottom/create-note-bottom.dart';
import '../../components/empty-folder-component/empty-folder.dart';
import '../../components/icon-components/icon-generic.dart';
import '../../components/notes-components/card-note-component.dart';
import '../../controllers/common/search-algorithm.dart';
import '../../controllers/common/sort-timestamp.dart';
import '../../controllers/selectedValues-controller/selected-values-controller.dart';
import '../../controllers/view-controller/view-controller.dart';
import '../../generated/l10n.dart';
import '../home-screen/home-screen.dart' show Arguments;
import '../new-task-screen/new-task-screen.dart';

class TagScreen extends StatefulWidget {
  static const String id = 'tag_screen';

  @override
  _TagScreenState createState() => _TagScreenState();
}

class _TagScreenState extends State<TagScreen> {
  List allNotes = [];
  String text;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textEditingController = TextEditingController();

  List filter(Iterable<dynamic> raw, String tagName) {
    var aux = raw.where(
      (element) {
        bool isDeleted() {
          if (element['trash'] == true) return true;
          return false;
        }

        bool isArchived() {
          if (element['archived'] == true) return true;
          return false;
        }

        bool hasTag(String tagName) {
          List<dynamic> tags = element['tags'];
          return tags.contains(tagName);
        }

        return !isDeleted() && !isArchived() && hasTag(tagName);
      },
    );
    return aux.toList();
  }

  void selectAll(SelectedValuesController sVC) {
    if (sVC.getSelectedItems.length == allNotes.length) {
      sVC.clearSelectedItems();
      return;
    }
    sVC.setSelectedItems = allNotes;
  }

  void onChanged(String newText) {
    setState(() {
      text = newText;
    });
  }

  bool isEmpty(String text) {
    if (text == '' || text == null) return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    Arguments args = ModalRoute.of(context).settings.arguments;

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
        appBar: GenericAppBar(
          scaffoldKey: _scaffoldKey,
          title: args.tagName,
          isFromArchiveScreen: false,
          isFromTagScreen: true,
          isFromSearchScreen: false,
          isFromHomeScreen: false,
          tagName: args.tagName,
          selectAll: () => selectAll(sIC),
          textEditingController: textEditingController,
          onChanged: onChanged,
        ),
        body: ValueListenableBuilder(
          valueListenable: Hive.box('notes').listenable(),
          builder: (BuildContext context, Box<dynamic> box, widget) {
            if (box.values.isEmpty) {
              return EmptyFolder(
                androidIcon: Icons.label,
                title: translate.no_notes_this_tag,
                iOSIcon: CupertinoIcons.tag_solid,
                toolTip: translate.tag,
              );
            }
            Iterable<dynamic> raw = box.values;
            List data = filter(raw, args.tagName);

            allNotes = data;
            data = SortByTimestamp.sort(data);
            data = SearchAlgorithm.search(data, text);

            if (data.isEmpty && isEmpty(text)) {
              return EmptyFolder(
                androidIcon: Icons.label,
                title: translate.no_notes_this_tag,
                iOSIcon: CupertinoIcons.tag_solid,
                toolTip: translate.tag,
              );
            }

            if (data.isEmpty && !isEmpty(text)) {
              return EmptyFolder(
                androidIcon: Icons.search,
                title: translate.nothing_found,
                toolTip: translate.search,
                iOSIcon: Icons.search,
              );
            }

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
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).buttonColor,
          onPressed: () {
            showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
              context: context,
              builder: (BuildContext context) {
                return CreateNoteBottom(
                  tagName: args.tagName,
                );
              },
            );
          },
          child: IconGeneric(
            color: Colors.white,
            androidIcon: Icons.add,
            iOSIcon: CupertinoIcons.add,
            semanticLabel: translate.new_note,
            toolTip: translate.new_note,
          ),
        ),
      ),
    );
  }
}

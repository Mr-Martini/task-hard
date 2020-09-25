import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:task_hard/components/color-bubble-component/color-bubble-component.dart';
import 'package:task_hard/components/empty-folder-component/empty-folder.dart';
import 'package:task_hard/components/icon-components/icon-generic.dart';
import 'package:task_hard/controllers/colors-controller/color-controller.dart';
import 'package:task_hard/controllers/common/search-algorithm.dart';
import 'package:task_hard/controllers/database-controller/hive-controller.dart';
import 'package:task_hard/generated/l10n.dart';

class AllNotesBottomSheet extends StatefulWidget {
  final String tagName;

  AllNotesBottomSheet({@required this.tagName});

  @override
  _AllNotesBottomSheetState createState() => _AllNotesBottomSheetState();
}

class _AllNotesBottomSheetState extends State<AllNotesBottomSheet> {
  ColorController cC = ColorController();
  HiveController hC = HiveController();
  String text;
  int limit = 10;

  bool isEmpty(String text) {
    if (text == null || text == '') return true;
    return false;
  }

  void onChange(String newText) {
    text = newText;
  }

  @override
  void dispose() {
    text = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    var raw = Hive.box('notes').values;

    Color color = Theme.of(context).buttonColor;

    if (raw.isEmpty) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: EmptyFolder(
          androidIcon: Icons.note,
          title: translate.empty_notes,
          toolTip: translate.notes,
          iOSIcon: Icons.note,
        ),
      );
    }

    var filter = raw.where((element) =>
        element['tagName'] != widget.tagName &&
        element['trash'] != true &&
        element['archived'] != true);

    List notes = filter.toList();

    if (notes.isEmpty) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: EmptyFolder(
          androidIcon: Icons.note,
          title: translate.empty_notes,
          toolTip: translate.notes,
          iOSIcon: Icons.note,
        ),
      );
    }

    notes = SearchAlgorithm.search(notes, text);

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            notes.length > 6 || !isEmpty(text)
                ? TextField(
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    prefixIcon: IconGeneric(
                      androidIcon: Icons.search,
                      iOSIcon: CupertinoIcons.search,
                      semanticLabel: translate.search,
                      toolTip: translate.search,
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: color, width: 1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: color, width: 1),
                    ),
                    hintText: translate.search_hint_text,
                  ),
                  onChanged: onChange,
                )
                : SizedBox(
                    height: 2,
                  ),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  if (isEmpty(notes[index]['title']) &&
                      isEmpty(notes[index]['note'])) {
                    return Container();
                  } else if (isEmpty(notes[index]['title']) &&
                      !isEmpty(notes[index]['note'])) {
                    return ListTile(
                      leading: ColorBubbleComponent(
                        color: cC.getColor(notes[index]['color']),
                        onTap: null,
                        isSelected: false,
                      ),
                      title: Container(
                        child: Text(
                          notes[index]['note'],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            hC.putTagOnNote(
                                notes[index]['key'], widget.tagName);
                          });
                        },
                        icon: IconGeneric(
                          androidIcon: Icons.add,
                          iOSIcon: CupertinoIcons.add,
                          semanticLabel: translate.add,
                          toolTip: translate.add,
                        ),
                      ),
                    );
                  } else if (!isEmpty(notes[index]['title']) &&
                      isEmpty(notes[index]['note'])) {
                    return ListTile(
                      leading: ColorBubbleComponent(
                        color: cC.getColor(notes[index]['color']),
                        onTap: () {},
                        isSelected: false,
                      ),
                      title: Container(
                        child: Text(
                          notes[index]['title'],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            hC.putTagOnNote(
                                notes[index]['key'], widget.tagName);
                          });
                        },
                        icon: IconGeneric(
                          androidIcon: Icons.add,
                          iOSIcon: CupertinoIcons.add,
                          semanticLabel: translate.add,
                          toolTip: translate.add,
                        ),
                      ),
                    );
                  }
                  return ListTile(
                    leading: ColorBubbleComponent(
                      color: cC.getColor(notes[index]['color']),
                      onTap: () {},
                      isSelected: false,
                    ),
                    title: Container(
                      child: Text(
                        notes[index]['title'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    subtitle: Container(
                      child: Text(
                        notes[index]['note'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        setState(() {
                          hC.putTagOnNote(notes[index]['key'], widget.tagName);
                        });
                      },
                      icon: IconGeneric(
                        androidIcon: Icons.add,
                        iOSIcon: CupertinoIcons.add,
                        semanticLabel: translate.add,
                        toolTip: translate.add,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:task_hard/Utils/Utils.dart';
import 'package:task_hard/components/color-selector-component/color-selector-component.dart';
import 'package:task_hard/components/edit-tag-component/update-tag-info.dart';
import 'package:task_hard/components/icon-components/icon-generic.dart';
import 'package:task_hard/components/text-components/text-generic.dart';
import 'package:task_hard/controllers/database-controller/hive-controller.dart';
import 'package:task_hard/controllers/selectedValues-controller/selected-values-controller.dart';
import 'package:task_hard/generated/l10n.dart';

class TagsAppBar extends StatefulWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(55);

  final ValueChanged<String> onChanged;
  final TextEditingController textEditingController;

  TagsAppBar({
    @required this.onChanged,
    @required this.textEditingController,
  });

  @override
  _TagsAppBarState createState() => _TagsAppBarState();
}

class _TagsAppBarState extends State<TagsAppBar> {
  SelectedValuesController sVCF;
  HiveController hC = HiveController();

  String text;

  void changeColor(Color color) async {
    List tags = List.from(sVCF.getSelectedItems);

    Navigator.pop(context);
    sVCF.clearSelectedItems();

    for (var tag in tags) {
      hC.updateTagColor(color.toString(), tag['key']);
    }
  }

  void deleteTag() {
    for (var tag in sVCF.getSelectedItems) {
      String tagKey = tag['key'];
      String tagName = tag['name'];
      hC.deleteTag(tagKey);

      for (var note in hC.getAll()) {
        hC.deleteTagFromNote(note['key'], tagName);
      }
    }
    sVCF.clearSelectedItems();
    Navigator.pop(context);
  }

  void updateTagInfo(String newTagName, BuildContext context) {
    List tags = sVCF.getSelectedItems;
    String tagKey = tags[0]['key'];
    sVCF.clearSelectedItems();
    Navigator.pop(context);
    hC.updateTagName(tagKey, newTagName);
  }

  bool isEmpty() {
    if (text == null || text == '') return true;
    return false;
  }

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    SelectedValuesController sVCT =
        Provider.of<SelectedValuesController>(context, listen: true);

    sVCF = Provider.of<SelectedValuesController>(context, listen: true);

    return sVCT.getSelectedItems.isEmpty
        ? AppBar(
            title: TextField(
              autofocus: false,
              controller: widget.textEditingController,
              autocorrect: true,
              keyboardType: TextInputType.text,
              onChanged: (String newText) {
                text = newText;
                widget.onChanged(newText);
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
                suffixIcon: isEmpty()
                    ? null
                    : IconButton(
                        onPressed: () {
                          text = '';
                          widget.onChanged('');
                          widget.textEditingController.text = '';
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
          )
        : AppBar(
            leading: IconButton(
              icon: IconGeneric(
                androidIcon: Icons.close,
                iOSIcon: CupertinoIcons.clear,
                semanticLabel: translate.tooltip_previous_screen,
                toolTip: translate.tooltip_previous_screen,
              ),
              onPressed: () {
                sVCF.clearSelectedItems();
              },
            ),
            title: TextGeneric(text: sVCT.getSelectedItems.length.toString()),
            actions: [
              sVCT.getSelectedItems.length == 1
                  ? IconButton(
                      icon: IconGeneric(
                        androidIcon: Icons.edit,
                        iOSIcon: CupertinoIcons.pen,
                        semanticLabel: translate.edit_note,
                        toolTip: translate.edit_note,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return UpdateTagInfo(
                              title: translate.update_tag,
                              hintText: translate.edit_tag_name,
                              updateTag: (String newTagName) {
                                updateTagInfo(newTagName, context);
                              },
                            );
                          },
                        );
                      },
                    )
                  : Container(),
              IconButton(
                icon: IconGeneric(
                  androidIcon: Icons.palette,
                  semanticLabel: translate.change_color,
                  toolTip: translate.change_color,
                ),
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
                      onTap: changeColor,
                    ),
                  );
                },
              ),
              IconButton(
                icon: IconGeneric(
                  androidIcon: FontAwesomeIcons.trashAlt,
                  iOSIcon: CupertinoIcons.delete_solid,
                  semanticLabel: translate.delete,
                  toolTip: translate.delete,
                  size: 19,
                ),
                onPressed: () {
                  Utils.alertDialogWithContent(
                      context,
                      sVCT.getSelectedItems.length > 1
                          ? '${translate.delete} ${translate.tags}?'
                          : '${translate.delete} ${translate.tag}?',
                      () => Navigator.pop(context),
                      translate.no,
                      () => deleteTag(),
                      translate.Ok,
                      translate.this_will_delete_tag_note);
                },
              ),
            ],
          );
  }
}

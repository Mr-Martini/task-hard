import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_hard/components/empty-folder-component/empty-folder.dart';
import 'package:task_hard/components/text-components/text-generic.dart';
import 'package:task_hard/constants.dart';
import 'package:task_hard/controllers/database-controller/hive-controller.dart';
import 'package:task_hard/generated/l10n.dart';

class ChooseTag extends StatefulWidget {
  final ValueChanged<String> updateTag;
  final Function deleteTag;
  final String noteKey;
  final bool multiple;

  ChooseTag({
    @required this.updateTag,
    this.noteKey,
    this.deleteTag,
    @required this.multiple,
  }) : assert(multiple == null && noteKey != null ||
            multiple != null && noteKey == null);

  @override
  _ChooseTagState createState() => _ChooseTagState();
}

class _ChooseTagState extends State<ChooseTag> {
  List<dynamic> multipleTags = [];

  @override
  Widget build(BuildContext context) {
    HiveController hC = HiveController();

    var tags = hC.getTags();

    S translate = S.of(context);

    var note;
    List<dynamic> tagsOnNote = [];

    if (widget.noteKey != null) {
      note = hC.getNote(widget.noteKey);
      tagsOnNote = note['tags'] ?? [];
    }

    if (tags == null || tags.isEmpty || tags.length == 0) {
      return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: EmptyFolder(
          androidIcon: Icons.label,
          title: translate.no_tags,
          iOSIcon: CupertinoIcons.tag_solid,
          toolTip: translate.no_tags,
        ),
      );
    }
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextGeneric(
              text: translate.choose_a_tag,
              fontSize: kSectionTitleSize,
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tags.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.label),
                    title: TextGeneric(text: tags[index]['name']),
                    trailing: widget.noteKey == null
                        ? Checkbox(
                            activeColor: Theme.of(context).buttonColor,
                            value: multipleTags.contains(tags[index]['name']),
                            onChanged: (bool notContains) {
                              if (!notContains) {
                                multipleTags.remove(tags[index]['name']);
                                widget.deleteTag(tags[index]['name']);
                              } else {
                                widget.updateTag(tags[index]['name']);
                                if (!multipleTags
                                    .contains(tags[index]['name'])) {
                                  multipleTags.add(tags[index]['name']);
                                }
                              }
                            },
                          )
                        : Checkbox(
                            activeColor: Theme.of(context).buttonColor,
                            value: tagsOnNote.contains(tags[index]['name']),
                            onChanged: (bool notContains) {
                              if (!notContains) {
                                ///Delete tag, returns tagName
                                widget.deleteTag(tags[index]['name']);
                              } else {
                                ///Update tag, returns tagName
                                widget.updateTag(tags[index]['name']);
                              }
                            },
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

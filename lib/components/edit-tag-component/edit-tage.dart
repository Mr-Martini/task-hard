import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_hard/components/icon-components/icon-generic.dart';
import 'package:task_hard/components/text-components/text-generic.dart';
import 'package:task_hard/generated/l10n.dart';

class EditTag extends StatefulWidget {
  final bool hasTag;
  final ValueChanged<String> updateTag;
  final Function deleteTag;
  final Function chooseTag;

  EditTag({
    @required this.updateTag,
    @required this.hasTag,
    @required this.deleteTag,
    @required this.chooseTag,
  });

  @override
  _EditTagState createState() => _EditTagState();
}

class _EditTagState extends State<EditTag> {
  String text;

  void onChange(String newText) {
    setState(() {
      text = newText;
    });
  }

  bool isEmpty(text) {
    if (text == null || text == '') {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).buttonColor;
    S translate = S.of(context);

    return AlertDialog(
      title: TextGeneric(
        text: widget.hasTag ? translate.update_tag : translate.add_a_tag,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: color, width: 1),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: color, width: 1),
                  ),
                  hintText: translate.tag_example,
                  labelText: translate.type_a_new_tag,
                  labelStyle: TextStyle(color: color)),
              onChanged: onChange,
            ),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pop(context);
                widget.chooseTag();
              },
              color: color,
              child: ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: IconGeneric(
                  androidIcon: Icons.label,
                  iOSIcon: CupertinoIcons.tag_solid,
                  semanticLabel: translate.tag,
                  toolTip: translate.tag,
                  color: Colors.white,
                ),
                title: AutoSizeText(
                  translate.choose_a_tag,
                  presetFontSizes: [16, 14, 12, 10, 8],
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        widget.hasTag
            ? FlatButton(
                onPressed: widget.deleteTag,
                child: AutoSizeText(
                  translate.delete,
                  presetFontSizes: [14, 13, 12, 11, 10, 9, 8],
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headline6.color,
                  ),
                ),
              )
            : Container(),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: TextGeneric(text: translate.cancel),
        ),
        RaisedButton(
          color: isEmpty(text) ? Colors.transparent : color,
          onPressed: isEmpty(text)
              ? null
              : () {
                  widget.updateTag(text.trim());
                },
          child: TextGeneric(
            text: translate.Ok,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

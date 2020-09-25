import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_hard/components/text-components/text-generic.dart';
import 'package:task_hard/generated/l10n.dart';

class UpdateTagInfo extends StatefulWidget {
  final ValueChanged<String> updateTag;
  final String title;
  final String hintText;

  UpdateTagInfo({
    @required this.updateTag,
    @required this.title,
    @required this.hintText,
  });

  @override
  _UpdateTagInfoState createState() => _UpdateTagInfoState();
}

class _UpdateTagInfoState extends State<UpdateTagInfo> {
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
      title: TextGeneric(text: widget.title),
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
                  labelText: widget.hintText,
                  labelStyle: TextStyle(color: color)),
              onChanged: onChange,
            ),
          ],
        ),
      ),
      actions: [
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

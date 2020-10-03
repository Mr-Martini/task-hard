import 'package:flutter/material.dart';
import 'package:task_hard/generated/l10n.dart';

class AddTag extends StatefulWidget {
  AddTag({Key key}) : super(key: key);

  @override
  _AddTagState createState() => _AddTagState();
}

class _AddTagState extends State<AddTag> {
  String text;
  FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void onChanged(String newText) {
    text = newText;
  }

  @override
  Widget build(BuildContext context) {
    final S translate = S.of(context);

    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          title: Container(
            height: 40,
            child: TextField(
              focusNode: _focusNode,
              textAlignVertical: TextAlignVertical.center,
              onChanged: onChanged,
              cursorColor: Theme.of(context).buttonColor,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).buttonColor,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          actions: [
            FlatButton(
              textColor: Theme.of(context).buttonColor,
              onPressed: () {},
              child: Text(translate.add),
            ),
          ],
        ),
      ),
    );
  }
}

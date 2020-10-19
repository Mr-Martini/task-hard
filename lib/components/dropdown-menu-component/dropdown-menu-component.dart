import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../icon-components/icon-generic.dart';
import '../text-components/text-generic.dart';

class DropDownMenu extends StatelessWidget {
  final String title;
  final List<PopupMenuEntry> child;
  final bool hasError;
  final String errorMessage;

  DropDownMenu({
    @required this.title,
    @required this.child,
    this.hasError,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(80, 200, 80, 0),
          items: child,
        );
      },
      child: Container(
        height: hasError ? 50 : 40,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 2, color: Colors.grey),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextGeneric(text: title),
                IconGeneric(
                  androidIcon: Icons.arrow_drop_down,
                  iOSIcon: CupertinoIcons.down_arrow,
                  semanticLabel: title,
                  toolTip: title,
                ),
              ],
            ),
            hasError
                ? Flexible(
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

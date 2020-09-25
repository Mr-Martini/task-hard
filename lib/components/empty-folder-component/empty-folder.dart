import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_hard/components/icon-components/icon-generic.dart';
import 'package:task_hard/constants.dart';
import 'package:auto_size_text/auto_size_text.dart';

class EmptyFolder extends StatelessWidget {
  final IconData androidIcon;
  final IconData iOSIcon;
  final String title;
  final String subTitle;
  final String toolTip;

  EmptyFolder({
    @required this.androidIcon,
    @required this.title,
    @required this.iOSIcon,
    this.subTitle,
    @required this.toolTip,
  });

  @override
  Widget build(BuildContext context) {
    Color itemsColor = Theme.of(context).primaryColor == Colors.white
        ? Colors.grey[600]
        : Colors.grey[400];

    double width = MediaQuery.of(context).size.width * 0.6;
    double height = MediaQuery.of(context).size.height * 0.6;

    return Center(
      child: Container(
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconGeneric(
              androidIcon: androidIcon,
              iOSIcon: iOSIcon,
              semanticLabel: toolTip,
              toolTip: toolTip,
              size: kEmptyFolderIconSize,
              color: Theme.of(context).buttonColor,
            ),
            SizedBox(
              height: 16,
            ),
            AutoSizeText(
              title,
              maxLines: 3,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              presetFontSizes: [kEmptyFolderTitleSize, 16, 14, 12, 10, 8],
              style: TextStyle(
                color: itemsColor,
                fontSize: kEmptyFolderTitleSize,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}

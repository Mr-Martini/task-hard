import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_hard/components/icon-components/icon-generic.dart';
import 'package:task_hard/components/text-components/text-generic.dart';
import 'package:task_hard/generated/l10n.dart';

class InformationBox extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget action;

  InformationBox({
    @required this.title,
    this.subTitle,
    this.action,
  }) : assert(title != null);

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).primaryColor == Colors.white
              ? Colors.grey[300]
              : Colors.grey[800],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: IconGeneric(
                androidIcon: Icons.info,
                iOSIcon: CupertinoIcons.info,
                semanticLabel: translate.important,
                toolTip: translate.important,
              ),
              title: TextGeneric(text: title),
              subtitle: subTitle != null
                  ? TextGeneric(
                      text: subTitle,
                      color: Colors.grey,
                      fontSize: 14,
                    )
                  : null,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: action ??
                  Container(
                    width: 0,
                    height: 0,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

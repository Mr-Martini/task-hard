import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_hard/components/icon-components/icon-generic.dart';
import 'package:task_hard/components/text-components/text-generic.dart';
import 'package:task_hard/components/tooltip-component/tooltip-component.dart';

class DecentListTile extends StatelessWidget {
  final IconData androidIcon;
  final IconData iOSIcon;
  final String semanticLabel;
  final String toolTip;
  final String text;
  final Function onTap;
  final double iconSize;

  DecentListTile(
      {@required this.iOSIcon,
      @required this.androidIcon,
      @required this.text,
      @required this.onTap,
      this.toolTip,
        this.iconSize,
      this.semanticLabel,})
      : assert(iOSIcon != null && androidIcon != null && text != null);

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return ToolTipComponent(
      message: toolTip,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: primaryColor == Colors.white
                  ? Colors.grey[400]
                  : Colors.grey[700],
            ),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconGeneric(
                androidIcon: androidIcon,
                iOSIcon: iOSIcon,
                semanticLabel: semanticLabel ?? '',
                toolTip: toolTip ?? '',
                size: iconSize,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
              ),
              TextGeneric(text: text),
            ],
          ),
        ),
      ),
    );
  }
}

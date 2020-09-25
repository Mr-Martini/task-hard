import 'package:flutter/material.dart';
import 'package:task_hard/components/text-components/text-generic.dart';
import 'package:task_hard/constants.dart';
import 'package:task_hard/components/icon-components/icon-generic.dart';

class ButtonComponentTwo extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final Color textColor;
  final IconData androidIcon;
  final String sematincLabel;
  final String tooltip;
  final IconData iOSIcon;

  ButtonComponentTwo({
    @required this.onPressed,
    @required this.text,
    this.textColor,
    @required this.iOSIcon,
    this.sematincLabel,
    @required this.androidIcon,
    this.color,
    this.tooltip,
  }) : assert(androidIcon != null && iOSIcon != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kContainerBoxWidth,
      height: kContainerBoxHeight,
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: color ?? Colors.black26),
        color: color ?? Colors.black26,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconGeneric(
                androidIcon: androidIcon,
                iOSIcon: iOSIcon,
                semanticLabel: sematincLabel ?? '',
                color: Colors.white,
                toolTip: tooltip ?? '',
              ),
              TextGeneric(
                text: text,
                color: textColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

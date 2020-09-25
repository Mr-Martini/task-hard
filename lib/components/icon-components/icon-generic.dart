import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:task_hard/components/tooltip-component/tooltip-component.dart';

class IconGeneric extends StatelessWidget {
  final IconData androidIcon;
  final IconData iOSIcon;
  final String semanticLabel;
  final String toolTip;
  final double size;
  final Color color;

  IconGeneric(
      {this.androidIcon,
      this.iOSIcon,
      this.color,
      this.size,
      this.toolTip,
      this.semanticLabel})
      : assert(androidIcon != null || iOSIcon != null);

  @override
  Widget build(BuildContext context) {
    return ToolTipComponent(
      message: toolTip ?? null,
      child: Icon(
        Platform.isAndroid ? androidIcon : iOSIcon,
        color: color != null ? color : Colors.grey,
        semanticLabel: semanticLabel ?? '',
        size: size ?? IconTheme.of(context).size,
      ),
    );
  }
}

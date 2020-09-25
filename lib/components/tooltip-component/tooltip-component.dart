import 'package:flutter/material.dart';

class ToolTipComponent extends StatelessWidget {
  final String message;
  final Widget child;

  ToolTipComponent({@required this.message, @required this.child})
      : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      textStyle: TextStyle(
        color: Theme.of(context).textTheme.headline6.color,
      ),
      message: message ?? '',
      child: child,
    );
  }
}

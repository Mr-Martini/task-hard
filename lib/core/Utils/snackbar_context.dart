import 'package:flutter/material.dart';

abstract class ShowSnackBar {
  static void show({
    @required BuildContext context,
    @required String title,
    String actionMessage,
    VoidCallback action,
    Color color,
    Color textColor,
  }) {
    final snackbar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        title,
        style: TextStyle(
          color: textColor ?? Theme.of(context).textTheme.headline6.color,
        ),
      ),
      elevation: 12,
      backgroundColor: color ?? Theme.of(context).primaryColor,
      action: actionMessage != null
          ? SnackBarAction(
              label: actionMessage,
              textColor: Theme.of(context).buttonColor,
              onPressed: action,
            )
          : null,
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }
}

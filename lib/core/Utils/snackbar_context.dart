import 'package:flutter/material.dart';

abstract class ShowSnackBar {
  static void show({
    @required BuildContext context,
    @required String title,
    String actionMessage,
    VoidCallback action,
  }) {
    final snackbar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).textTheme.headline6.color,
        ),
      ),
      elevation: 12,
      backgroundColor: Theme.of(context).primaryColor,
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

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:task_hard/components/text-components/text-generic.dart';

class Utils {
  static SnackBar displaySnackBar(String message, BuildContext context,
      {String actionMessage, VoidCallback onClick}) {
    return SnackBar(
      elevation: 12,
      behavior: SnackBarBehavior.fixed,
      shape: RoundedRectangleBorder(),
      backgroundColor: Theme.of(context).primaryColor,
      content: Text(
        message,
        style: TextStyle(color: Theme.of(context).textTheme.headline6.color),
      ),
      action: (actionMessage != null)
          ? SnackBarAction(
              textColor: Theme.of(context).buttonColor,
              label: actionMessage,
              onPressed: () {
                return onClick();
              },
            )
          : null,
    );
  }

  static alertDialog(BuildContext context, String title, Function flatOnPressed,
      String flatText, Function raisedOnPressed, String raisedText,
      {Widget icon, bool material = false}) {
    if (Platform.isAndroid) {
      showModal(
        configuration: FadeScaleTransitionConfiguration(),
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          title: TextGeneric(
            text: title,
            bold: FontWeight.bold,
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: flatOnPressed,
              child: TextGeneric(text: flatText),
            ),
            icon != null
                ? RaisedButton(
                    onPressed: raisedOnPressed,
                    color: Theme.of(context).buttonColor,
                    child: material
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              icon,
                              SizedBox(
                                width: 8,
                              ),
                              TextGeneric(
                                text: raisedText,
                                color: Colors.white,
                              ),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              icon,
                              SizedBox(
                                width: 8,
                              ),
                              TextGeneric(
                                text: raisedText,
                                color: Colors.white,
                              ),
                            ],
                          ),
                  )
                : RaisedButton(
                    onPressed: raisedOnPressed,
                    color: Theme.of(context).buttonColor,
                    child: TextGeneric(
                      text: raisedText,
                      color: Colors.white,
                    ),
                  ),
          ],
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: TextGeneric(text: title),
          actions: <Widget>[
            FlatButton(
              onPressed: flatOnPressed,
              child: TextGeneric(
                text: flatText,
                bold: FontWeight.bold,
              ),
            ),
            icon != null
                ? RaisedButton(
              onPressed: raisedOnPressed,
              color: Theme.of(context).buttonColor,
              child: material
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon,
                  SizedBox(
                    width: 8,
                  ),
                  TextGeneric(
                    text: raisedText,
                    color: Colors.white,
                  ),
                ],
              )
                  : Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon,
                  SizedBox(
                    width: 8,
                  ),
                  TextGeneric(
                    text: raisedText,
                    color: Colors.white,
                  ),
                ],
              ),
            )
                : RaisedButton(
                    onPressed: raisedOnPressed,
                    color: Theme.of(context).buttonColor,
                    child: TextGeneric(
                      text: raisedText,
                      color: Colors.white,
                    ),
                  ),
          ],
        ),
      );
    }
  }

  static alertDialogWithContent(
      BuildContext context,
      String title,
      Function flatOnPressed,
      String flatText,
      Function raisedOnPressed,
      String raisedText,
      String subTitle,
      {Widget icon, bool material = false}) {
    if (Platform.isAndroid) {
      showModal(
        configuration: FadeScaleTransitionConfiguration(),
        context: context,
        builder: (BuildContext context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          title: TextGeneric(
            text: title,
            bold: FontWeight.bold,
          ),
          content: TextGeneric(
            text: subTitle,
            color: Colors.grey,
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: flatOnPressed,
              child: TextGeneric(text: flatText),
            ),
            icon != null
                ? RaisedButton(
              onPressed: raisedOnPressed,
              color: Theme.of(context).buttonColor,
              child: material
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon,
                  SizedBox(
                    width: 8,
                  ),
                  TextGeneric(
                    text: raisedText,
                    color: Colors.white,
                  ),
                ],
              )
                  : Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon,
                  SizedBox(
                    width: 8,
                  ),
                  TextGeneric(
                    text: raisedText,
                    color: Colors.white,
                  ),
                ],
              ),
            )
                : RaisedButton(
                    onPressed: raisedOnPressed,
                    color: Theme.of(context).buttonColor,
                    child: TextGeneric(
                      text: raisedText,
                      color: Colors.white,
                    ),
                  ),
          ],
        ),
      );
    } else {
      showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: TextGeneric(text: title),
          content: TextGeneric(
            text: subTitle,
            color: Colors.grey,
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: flatOnPressed,
              child: TextGeneric(
                text: flatText,
                bold: FontWeight.bold,
              ),
            ),
            icon != null
                ? RaisedButton(
              onPressed: raisedOnPressed,
              color: Theme.of(context).buttonColor,
              child: material
                  ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon,
                  SizedBox(
                    width: 8,
                  ),
                  TextGeneric(
                    text: raisedText,
                    color: Colors.white,
                  ),
                ],
              )
                  : Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                mainAxisSize: MainAxisSize.min,
                children: [
                  icon,
                  SizedBox(
                    width: 8,
                  ),
                  TextGeneric(
                    text: raisedText,
                    color: Colors.white,
                  ),
                ],
              ),
            )
                : RaisedButton(
                    onPressed: raisedOnPressed,
                    color: Theme.of(context).buttonColor,
                    child: TextGeneric(
                      text: raisedText,
                      color: Colors.white,
                    ),
                  ),
          ],
        ),
      );
    }
  }
}

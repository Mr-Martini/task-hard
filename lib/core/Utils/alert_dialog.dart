import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

abstract class ShowDialog {
  static alertDialog({
    @required BuildContext context,
    @required String flatText,
    @required String title,
    @required Function raisedOnPressed,
    @required String raisedText,
    IconData icon,
    bool material = false,
  }) {
    showModal(
      configuration: FadeScaleTransitionConfiguration(),
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: RoundedRectangleBorder(),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text(flatText),
          ),
          icon != null
              ? RaisedButton(
                  onPressed: raisedOnPressed,
                  color: Theme.of(context).buttonColor,
                  child: material
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              icon,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              raisedText,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              icon,
                              size: 16,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              raisedText,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                )
              : RaisedButton(
                  onPressed: raisedOnPressed,
                  color: Theme.of(context).buttonColor,
                  child: Text(
                    raisedText,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

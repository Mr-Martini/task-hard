import 'package:flutter/material.dart';

import '../../constants.dart';
import '../text-components/text-generic.dart';

class ButtonComponentOne extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color textColor;
  final Color color;

  ButtonComponentOne({
    @required this.onPressed,
    @required this.text,
    this.color,
    this.textColor,
  });

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

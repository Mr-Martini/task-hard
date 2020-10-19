import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../icon-components/icon-generic.dart';

class ColorBubbleComponent extends StatelessWidget {
  final Color color;
  final Function onTap;
  final bool isSelected;

  ColorBubbleComponent({
    @required this.color,
    @required this.onTap,
    @required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      customBorder: CircleBorder(),
      containedInkWell: false,
      highlightShape: BoxShape.circle,
      radius: 45,
      onTap: onTap,
      child: isSelected
          ? Material(
              elevation: 12,
              shape: CircleBorder(),
              color: Colors.transparent,
              child: Stack(
                fit: StackFit.passthrough,
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                  IconGeneric(
                    androidIcon: Icons.check,
                    iOSIcon: CupertinoIcons.check_mark,
                    color: Colors.white,
                  )
                ],
              ),
            )
          : Material(
              elevation: 12,
              shape: CircleBorder(),
              color: Colors.transparent,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
    );
  }
}

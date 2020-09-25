import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../controllers/colors-controller/color-controller.dart';
import '../color-bubble-component/color-bubble-component.dart';

class ColorSelector extends StatelessWidget {
  final Function onTap;

  ColorSelector({
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ColorController cC = ColorController();

    return Container(
      height: MediaQuery.of(context).size.height * 0.13,
      decoration: BoxDecoration(
        border: Border.all(width: 0, color: Colors.transparent),
        color: Colors.transparent,
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: cC.getListOfColors.length,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(8),
        itemBuilder: (BuildContext context, int index) {
          return ColorBubbleComponent(
            color: cC.getListOfColors[index],
            onTap: () => onTap(cC.getListOfColors[index]),
            isSelected: false,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 16,
          );
        },
      ),
    );
  }
}

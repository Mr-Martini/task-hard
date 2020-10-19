import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/colors-controller/color-controller.dart';
import '../../controllers/selectedValues-controller/selected-values-controller.dart';
import '../text-components/text-generic.dart';

class TagBubble extends StatefulWidget {
  final String title;
  final IconData icon;
  final String color;
  final Function onTap;
  final ValueChanged<bool> isSelected;

  TagBubble({
    @required this.title,
    @required this.icon,
    @required this.color,
    @required this.onTap,
    @required this.isSelected,
  });

  @override
  _TagBubbleState createState() => _TagBubbleState();
}

class _TagBubbleState extends State<TagBubble> {
  bool isSelected = false;

  Color getColor(String color) {
    ColorController cC = ColorController();
    return cC.getColor(color);
  }

  Color getTextColor(String color) {
    ColorController cC = ColorController();
    if (cC.getColor(color) == Colors.white) {
      return Colors.black87;
    } else if (cC.getColor(color) == null) {
      if (Theme.of(context).primaryColor == Colors.white) {
        return Colors.black87;
      }
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    SelectedValuesController sVCT =
        Provider.of<SelectedValuesController>(context, listen: true);

    if (sVCT.getSelectedItems.length == 0) {
      isSelected = false;
    }

    return Container(
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).primaryColor == Colors.white
              ? Colors.grey[500]
              : Colors.grey[800],
        ),
        color: isSelected
            ? Colors.grey
            : getColor(widget.color) ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (sVCT.getSelectedItems.isEmpty) {
              widget.onTap();
            } else {
              setState(() {
                isSelected = !isSelected;
              });
              widget.isSelected(isSelected);
            }
          },
          onLongPress: () {
            setState(() {
              isSelected = !isSelected;
            });
            widget.isSelected(isSelected);
          },
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  widget.icon ?? Icons.label,
                  size: 40,
                  color: getTextColor(widget.color),
                ),
                TextGeneric(
                  text: widget.title,
                  color: getTextColor(widget.color),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

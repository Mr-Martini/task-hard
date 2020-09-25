import 'package:flutter/material.dart';
import 'package:task_hard/components/text-components/text-generic.dart';

class ChipWithBottomSheet extends StatelessWidget {
  final String label;
  final String message;
  final Function onTap;
  final Color textColor;
  final Color backgroundColor;

  ChipWithBottomSheet({
    @required this.label,
    @required this.message,
    @required this.onTap,
    @required this.textColor,
    @required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      child: Tooltip(
        message: message,
        child: Chip(
          backgroundColor: backgroundColor,
          label: TextGeneric(
            text: label,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

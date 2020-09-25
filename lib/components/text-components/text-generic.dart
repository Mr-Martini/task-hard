import 'package:flutter/material.dart';

class TextGeneric extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final double letterSpacing;
  final FontWeight bold;
  final TextAlign textAlign;

  TextGeneric({
    @required this.text,
    this.color,
    this.fontSize,
    this.letterSpacing,
    this.bold,
    this.textAlign,
  }) : assert(text != null);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.start,
      style: TextStyle(
        fontSize: fontSize ?? 16,
        letterSpacing: letterSpacing ?? 0,
        fontWeight: bold ?? FontWeight.normal,
      ),
    );
  }
}

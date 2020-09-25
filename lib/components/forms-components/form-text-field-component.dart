import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class FormTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final TextInputType textInputType;
  final TextInputAction textInputAction;
  final int maxLines;
  final int minLines;
  final IconData androidIcon;
  final IconData iosIcon;
  final TextEditingController controller;
  final Function handleSubmitted;

  FormTextField(
      {@required this.textInputAction,
      @required this.textInputType,
      @required this.androidIcon,
      @required this.iosIcon,
      @required this.hintText,
      @required this.labelText,
      @required this.maxLines,
      @required this.minLines,
      @required this.controller,
      this.handleSubmitted});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          accentColor: Theme.of(context).buttonColor,
          primaryColor: Theme.of(context).primaryColor == Colors.white
              ? Theme.of(context).buttonColor
              : Colors.white),
      child: TextFormField(
        textInputAction: textInputAction,
        controller: controller,
        onFieldSubmitted: handleSubmitted,
        keyboardType: textInputType,
        maxLines: maxLines,
        minLines: minLines,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle:
              TextStyle(color: Theme.of(context).textTheme.bodyText1.color),
          hintText: hintText,
          prefixIcon: Icon(
            Platform.isAndroid ? androidIcon : iosIcon,
          ),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).buttonColor)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).buttonColor)),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).buttonColor)),
        ),
      ),
    );
  }
}

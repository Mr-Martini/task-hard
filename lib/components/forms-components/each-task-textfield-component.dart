import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class EachTasKTextFieldComponent extends StatelessWidget {
  final bool checked;
  final Function onSubmitted;
  final TextEditingController controller;
  final Function onCheckBoxChanged;
  final String hintText;
  final TextInputAction textInputAction;
  final Function onTextChanged;

  EachTasKTextFieldComponent({
    @required this.controller,
    @required this.checked,
    @required this.onSubmitted,
    @required this.onCheckBoxChanged,
    @required this.textInputAction,
    this.onTextChanged,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(fontSize: 18),
      autofocus: true,
      autocorrect: true,
      onChanged: onTextChanged,
      onSubmitted: onSubmitted,
      textInputAction: textInputAction,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Checkbox(
          focusNode: FocusNode(canRequestFocus: false, skipTraversal: true),
          value: checked,
          onChanged: onCheckBoxChanged,
        ),
        hintText: hintText,
        border: InputBorder.none,
        hintStyle: TextStyle(fontSize: 18),
      ),
      minLines: 1,
      maxLines: null,
    );
  }
}

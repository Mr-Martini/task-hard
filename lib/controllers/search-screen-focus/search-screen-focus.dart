import 'package:flutter/cupertino.dart';

abstract class SearchScreenFocus {

  static FocusNode focusNode = FocusNode();

  static void initializeFocus() {
    focusNode = FocusNode();
  }

  static void makeFocus() {
    focusNode.requestFocus();
  }

  static void unFocus() {
    focusNode.unfocus();
  }

  static void dispose() {
    focusNode.dispose();
  }

}
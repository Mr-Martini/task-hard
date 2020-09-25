import 'package:flutter/cupertino.dart';

class ViewController with ChangeNotifier {
  String _value = 'Staggered';

  String get getValue => _value;

  int get getCrossAxisCellCount {
    if (_value == 'Staggered') {
      return 1;
    } else if (_value == 'Rectangle') {
      return 1;
    } else {
      return 2;
    }
  }

  double get getMinHeight {
    if (_value == 'Staggered') {
      return 100;
    } else if (_value == 'Rectangle') {
      return 130;
    } else {
      return 80;
    }
  }

  double get getMaxHeight {
    if (_value == 'Staggered') {
      return 400;
    } else if (_value == 'Rectangle') {
      return 130;
    } else {
      return 140;
    }
  }

  set setValue(String newValue) {
    _value = newValue;
    notifyListeners();
  }
}

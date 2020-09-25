import 'package:flutter/material.dart';

class ColorController {
  static Color _teal = Colors.teal;
  static Color _orange = Color(0xffb53d00);
  static Color _purple = Color(0xff38006b);
  static Color _blue = Color(0xff003c8f);
  static Color _green = Color(0xff1b5e20);
  static Color _yellow = Color(0xffc17900);
  static Color _brawn = Color(0xff4e342e);
  static Color _white = Colors.white;
  static Color _dark = Color(0xff212121);

  get getTeal => _teal;

  get getOrange => _orange;

  get getPurple => _purple;

  get getBlue => _blue;

  get getGreen => _green;

  get getYellow => _yellow;

  get getBrawn => _brawn;

  get getWhite => _white;

  get getDark => _dark;

  Map<String, Color> _colors = {
    _teal.toString(): _teal,
    _orange.toString(): _orange,
    _purple.toString(): _purple,
    _blue.toString(): _blue,
    _green.toString(): _green,
    _yellow.toString(): _yellow,
    _brawn.toString(): _brawn,
    _white.toString(): _white,
    _dark.toString(): _dark,
  };

  List<Color> get getListOfColors {
    return <Color>[
      _teal,
      _orange,
      _purple,
      _blue,
      _green,
      _yellow,
      _brawn,
      _white,
      _dark,
    ];
  }

  Color getColor(String color) {
    if (_colors.containsKey(color)) {
      return _colors[color];
    } else {
      return null;
    }
  }
}

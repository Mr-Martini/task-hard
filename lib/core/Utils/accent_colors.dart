import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AccentColors {
  static const Color _lightPurple = Color(0xff5c007a);
  static const Color _darkPurple = Color(0xffc158dc);
  static const Color _lightYellow = Color(0xffffc107);
  static const Color _darkYellow = Color(0xfffff350);
  static const Color _lightPink = Color(0xffb0003a);
  static const Color _darkPink = Color(0xffff6090);
  static const Color _lightOrange = Color(0xfffb8c00);
  static const Color _darkOrange = Color(0xfffb8c00);
  static const Color _lightGreen = Color(0xff00701a);
  static const Color _darkGreen = Color(0xff76d275);
  static const Color _lightRed = Color(0xffba000d);
  static const Color _darkRed = Color(0xfff05545);
  static const Color _teal = Colors.teal;
  static const Color _blue = Colors.blue;

  static Map<String, Map<String, Color>> _colors = {
    'purple': {
      'dark': _darkPurple,
      'light': _lightPurple,
    },
    'yellow': {
      'dark': _darkYellow,
      'light': _lightYellow,
    },
    'teal': {
      'dark': _teal,
      'light': _teal,
    },
    'pink': {
      'dark': _darkPink,
      'light': _lightPink,
    },
    'blue': {
      'dark': _blue,
      'light': _blue,
    },
    'orange': {
      'dark': _darkOrange,
      'light': _lightOrange,
    },
    'green': {
      'dark': _darkGreen,
      'light': _lightGreen,
    },
    'red': {
      'dark': _darkRed,
      'light': _lightRed,
    }
  };

  static String getColorName(Color color) {
    Map<Color, String> lightColors = {
      _lightPurple: 'purple',
      _lightYellow: 'yellow',
      _teal: 'teal',
      _lightPink: 'pink',
      _blue: 'blue',
      _lightOrange: 'orange',
      _lightGreen: 'green',
      _lightRed: 'red',
    };
    Map<Color, String> darkColors = {
      _darkPurple: 'purple',
      _darkYellow: 'yellow',
      _teal: 'teal',
      _darkPink: 'pink',
      _blue: 'blue',
      _darkOrange: 'orange',
      _darkGreen: 'green',
      _darkRed: 'red',
    };
    if (lightColors.containsKey(color)) {
      return lightColors[color];
    } else if (darkColors.containsKey(color)) {
      return darkColors[color];
    }
    return 'blue';
  }

  static List<Color> _lightColors = <Color>[
    _lightPurple,
    _lightYellow,
    _teal,
    _lightPink,
    _blue,
    _lightOrange,
    _lightGreen,
    _lightRed,
  ];

  static List<Color> _darkColors = <Color>[
    _darkPurple,
    _darkYellow,
    _teal,
    _darkPink,
    _blue,
    _darkOrange,
    _darkGreen,
    _darkRed,
  ];

  static List<Color> get getDarkColors => _darkColors;
  static List<Color> get getLightColors => _lightColors;
  static Map<String, Map<String, Color>> get getColors => _colors;

  static Color getLightColor(String color) {
    if (_colors.containsKey(color)) {
      return _colors[color]['light'];
    }
    return _blue;
  }

  static Color getDarkColor(String color) {
    if (_colors.containsKey(color)) {
      return _colors[color]['dark'];
    }
    return _blue;
  }
}

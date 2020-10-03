import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AccentColors {
  static const Color _lightPurple = Color(0xff5c007a);
  static const Color _darkPurple = Color(0xffc158dc);
  static const Color _lightYellow = Color(0xffffc107);
  static const Color _darkYellow = Color(0xffffd149);
  static const Color _lightPink = Color(0xffb0003a);
  static const Color _darkPink = Color(0xffff6090);
  static const Color _lightOrange = Color(0xfffb8c00);
  static const Color _darkOrange = Color(0xfffb8c00);
  static const Color _lightGreen = Color(0xff00701a);
  static const Color _darkGreen = Color(0xff4c8c4a);
  static const Color _lightRed = Color(0xffba000d);
  static const Color _darkRed = Color(0xfff05545);
  static const Color _lightTeal = Colors.teal;
  static const Color _darkTeal = Color(0xff52c7b8);
  static const Color _lightBlue = Colors.blue;
  static const Color _darkBlue = Color(0xff6ec6ff);

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
      'dark': _darkTeal,
      'light': _lightTeal,
    },
    'pink': {
      'dark': _darkPink,
      'light': _lightPink,
    },
    'blue': {
      'dark': _darkBlue,
      'light': _lightBlue,
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
      _lightTeal: 'teal',
      _lightPink: 'pink',
      _lightBlue: 'blue',
      _lightOrange: 'orange',
      _lightGreen: 'green',
      _lightRed: 'red',
    };
    Map<Color, String> darkColors = {
      _darkPurple: 'purple',
      _darkYellow: 'yellow',
      _darkTeal: 'teal',
      _darkPink: 'pink',
      _darkBlue: 'blue',
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
    _lightTeal,
    _lightPink,
    _lightBlue,
    _lightOrange,
    _lightGreen,
    _lightRed,
  ];

  static List<Color> _darkColors = <Color>[
    _darkPurple,
    _darkYellow,
    _darkTeal,
    _darkPink,
    _darkBlue,
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
    return _lightBlue;
  }

  static Color getDarkColor(String color) {
    if (_colors.containsKey(color)) {
      return _colors[color]['dark'];
    }
    return _darkBlue;
  }
}

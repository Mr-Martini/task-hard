import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';

class SharedAxisHorizontal extends PageRouteBuilder {
  final Widget page;
  final RouteSettings settings;
  SharedAxisHorizontal({this.page, this.settings})
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) =>
    page,
    settings: settings,
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) =>
        SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          child: child,
        ),
  );
}
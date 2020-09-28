import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:task_hard/features/home_notes/presentation/pages/home_page.dart';
import 'package:task_hard/views/search-screen/search-screen.dart';
import 'package:task_hard/views/tags-screen/tags-screen.dart';

class Decider extends StatefulWidget {
  final selected;

  Decider(this.selected);

  @override
  _DeciderState createState() => _DeciderState();
}

class _DeciderState extends State<Decider> {
  List<Widget> _selectedPage = [
    HomePage(),
    SearchScreen(),
    TagsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      transitionBuilder: (Widget child, Animation<double> primaryAnimation,
          Animation<double> secondaryAnimation) {
        return SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.scaled,
          child: child,
        );
      },
      child: _selectedPage[widget.selected],
    );
  }
}

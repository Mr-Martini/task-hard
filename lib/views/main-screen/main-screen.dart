import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/decider-component/decider-component.dart';
import '../../controllers/database-controller/hive-controller.dart';
import '../../controllers/search-screen-focus/search-screen-focus.dart';
import '../../controllers/selectedValues-controller/selected-values-controller.dart';
import '../../generated/l10n.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main_screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selected = 0;

  void _onScreenTapped(int index, SelectedValuesController sIC) {
    if (index == 1 && _selected == 1) {
      SearchScreenFocus.makeFocus();
    }
    if (sIC.getSelectedItems.isNotEmpty) {
      sIC.clearSelectedItems();
    }
    setState(() {
      _selected = index;
    });
  }

  @override
  void initState() {
    super.initState();
    clearTrash();
  }

  void clearTrash() {
    Timer(Duration(seconds: 7), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String date = prefs.getString('trash_date') ?? null;

      if (date == null) {
        DateTime future = DateTime.now().add(Duration(days: 14));
        await prefs.setString(
            'trash_date', future.millisecondsSinceEpoch.toString());
      } else {
        int millisecondsSinceEpoch = int.tryParse(date);
        DateTime dateTime =
            DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
        DateTime now = DateTime.now();
        if (dateTime.isBefore(now)) {
          HiveController hC = HiveController();
          for (var note in hC.getAll()) {
            if (note['trash'] == true) {
              hC.deleteNote(note['key']);
            }
          }
          DateTime future = DateTime.now().add(Duration(days: 14));
          await prefs.setString(
              'trash_date', future.millisecondsSinceEpoch.toString());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);
    SelectedValuesController sIC =
        Provider.of<SelectedValuesController>(context, listen: false);
    if (Platform.isAndroid) {
      return Scaffold(
        body: Decider(_selected),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: translate.home),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: translate.search,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.label),
              label: translate.tags,
            ),
          ],
          currentIndex: _selected,
          onTap: (int index) => _onScreenTapped(index, sIC),
          elevation: 12,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Theme.of(context).buttonColor,
          unselectedItemColor: Colors.grey[500],
        ),
      );
    } else {
      return CupertinoTabScaffold(
        backgroundColor: Theme.of(context).primaryColor,
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: translate.home,
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search),
              label: translate.search,
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.tag_solid),
              label: translate.tags,
            ),
          ],
        ),
        tabBuilder: (context, index) {
          if (sIC.getSelectedItems.isNotEmpty) {
            sIC.clearSelectedItems();
          }
          return Decider(index);
        },
      );
    }
  }
}

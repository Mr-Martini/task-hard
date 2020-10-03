import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../components/appbar-component/generica-app-bar.dart';
import '../../components/empty-folder-component/empty-folder.dart';
import '../../components/icon-components/icon-generic.dart';
import '../../controllers/common/notifications-common.dart';
import '../../controllers/common/sort-timestamp.dart';
import '../../controllers/database-controller/hive-controller.dart';
import '../../controllers/selectedValues-controller/selected-values-controller.dart';
import '../../controllers/view-controller/view-controller.dart';
import '../../core/widgets/side-drawer-component.dart';
import '../../generated/l10n.dart';
import '../new-task-screen/new-task-screen.dart';

class Arguments {
  final String key;
  final title;
  final note;
  final String color;
  final DateTime reminderDate;
  final int reminderKey;
  final bool ignoreTap;
  final DateTime createdAt;
  final bool archived;
  final bool expired;
  final String repeat;
  final String tagName;

  Arguments({
    @required this.key,
    this.note,
    this.title,
    this.color,
    this.reminderDate,
    this.reminderKey,
    this.ignoreTap,
    this.createdAt,
    this.archived,
    this.expired,
    this.repeat,
    this.tagName,
  });
}

class HomeScreen extends StatefulWidget {
  static const id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> allNotes = [];
  bool hasReminder = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  HiveController hC = HiveController();
  NotificationsCommon nC = NotificationsCommon();

  void selectAll(SelectedValuesController sVC) {
    if (sVC.getSelectedItems.length == allNotes.length) {
      sVC.clearSelectedItems();
      return;
    }
    sVC.setSelectedItems = allNotes;
  }

  List filter(List raw) {
    var aux = raw.where(
      (element) {
        bool isArchived(element) {
          if (element['archived'] == true) {
            return true;
          }
          return false;
        }

        bool isDeleted(element) {
          if (element['trash'] == true) {
            return true;
          }
          return false;
        }

        return !isDeleted(element) && !isArchived(element);
      },
    );
    return aux.toList();
  }

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);
    SelectedValuesController sIC =
        Provider.of<SelectedValuesController>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerComponent(),
        appBar: GenericAppBar(
          scaffoldKey: _scaffoldKey,
          title: translate.app_name,
          isFromArchiveScreen: false,
          isFromTagScreen: false,
          isFromSearchScreen: false,
          isFromHomeScreen: true,
          selectAll: () => selectAll(sIC),
        ),
        body: WillPopScope(
          onWillPop: () async {
            if (sIC.getSelectedItems.isEmpty) {
              return true;
            } else {
              sIC.clearSelectedItems();
              return false;
            }
          },
          child: ValueListenableBuilder(
            valueListenable: Hive.box('notes').listenable(),
            builder: (context, Box<dynamic> box, widget) {
              List raw = box.values.toList();
              raw = filter(raw);
              allNotes = raw;
              if (raw.isEmpty) {
                return EmptyFolder(
                  androidIcon: Icons.note,
                  title: translate.empty_notes,
                  iOSIcon: Icons.note,
                  subTitle: translate.empty_home_notes,
                  toolTip: translate.notes,
                );
              } else {
                List data = SortByTimestamp.sort(raw);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 8,
                      ),
                      Consumer<ViewController>(
                        builder: (context, vC, child) => Expanded(
                          child: StaggeredGridView.countBuilder(
                            crossAxisCount: 2,
                            scrollDirection: Axis.vertical,
                            physics: BouncingScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) =>
                                Container(),
                            staggeredTileBuilder: (int index) =>
                                StaggeredTile.fit(vC.getCrossAxisCellCount),
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).buttonColor,
          tooltip: translate.tooltip_create_note,
          onPressed: () {
            String key = Uuid().v4();
            Navigator.pushNamed(
              context,
              NewTask.id,
              arguments: Arguments(
                key: key,
                note: null,
                title: null,
                reminderKey: key.hashCode,
                ignoreTap: false,
                createdAt: DateTime.now(),
              ),
            );
          },
          child: IconGeneric(
            androidIcon: Icons.create,
            iOSIcon: CupertinoIcons.create,
            color: Colors.white,
            toolTip: translate.tooltip_create_note,
          ),
        ),
      ),
    );
  }
}

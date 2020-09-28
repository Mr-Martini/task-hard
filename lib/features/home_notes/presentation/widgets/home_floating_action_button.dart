import 'package:task_hard/core/Utils/arguments.dart';
import 'package:flutter/material.dart';
import 'package:task_hard/features/note/presentation/pages/task_container.dart';
import 'package:task_hard/generated/l10n.dart';
import 'package:uuid/uuid.dart';
import 'package:task_hard/page-transitions/slide_bottom_route.dart';

class HomeFloatingActionButton extends StatelessWidget {
  const HomeFloatingActionButton({
    Key key,
    @required this.translate,
    @required GlobalKey<ScaffoldState> scaffoldKey,
  })  : _scaffoldKey = scaffoldKey,
        super(key: key);

  final S translate;
  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      clipBehavior: Clip.antiAlias,
      backgroundColor: Theme.of(context).buttonColor,
      tooltip: translate.new_note,
      onPressed: () {
        String key = Uuid().v4();
        Navigator.push(
          context,
          SlideBottomRoute(
            offset: Offset(1, 1),
            page: TaskContainer(),
            settings: RouteSettings(
              arguments: Arguments(
                title: null,
                note: null,
                color: Theme.of(context).primaryColor,
                key: key,
                scaffoldKey: _scaffoldKey,
              ),
            ),
          ),
        );
      },
      child: Icon(
        Icons.edit,
        color: Colors.white,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/Utils/arguments.dart';
import '../../../../core/Utils/write_on.dart';
import '../../../../generated/l10n.dart';
import '../../../../page-transitions/slide_bottom_route.dart';
import '../../../note/presentation/pages/task_container.dart';

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
                box: WriteOn.home,
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

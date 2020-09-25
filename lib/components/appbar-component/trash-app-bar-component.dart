import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_hard/components/icon-components/icon-generic.dart';
import 'package:task_hard/components/text-components/text-generic.dart';
import 'package:task_hard/constants.dart';
import 'package:task_hard/controllers/selectedValues-controller/selected-values-controller.dart';
import 'package:task_hard/generated/l10n.dart';
import 'package:provider/provider.dart';

class TrashAppBar extends StatefulWidget implements PreferredSizeWidget {
  Size get preferredSize => new Size.fromHeight(55);

  final Function onPop;
  final Function selectAll;
  final Function restore;
  final Function deleteAll;
  final Function cancelSelection;

  TrashAppBar({
    @required this.onPop,
    @required this.restore,
    @required this.selectAll,
    @required this.deleteAll,
    @required this.cancelSelection,
  });

  @override
  _TrashAppBarState createState() => _TrashAppBarState();
}

class _TrashAppBarState extends State<TrashAppBar> {
  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);
    SelectedValuesController sIC =
        Provider.of<SelectedValuesController>(context, listen: true);

    if (sIC.getSelectedItems.isNotEmpty) {
      return AppBar(
        leading: IconButton(
          icon: IconGeneric(
            androidIcon: Icons.close,
            iOSIcon: CupertinoIcons.clear_thick,
            semanticLabel: translate.cancel_selection,
            toolTip: translate.cancel_selection,
          ),
          onPressed: widget.cancelSelection,
        ),
        title: TextGeneric(text: sIC.getSelectedItems.length.toString()),
        actions: <Widget>[
          IconButton(
            icon: IconGeneric(
              androidIcon: Icons.delete_forever,
              iOSIcon: CupertinoIcons.delete,
              semanticLabel: translate.delete,
              toolTip: translate.delete,
            ),
            onPressed: widget.deleteAll,
          ),
          IconButton(
            icon: IconGeneric(
              androidIcon: Icons.restore_from_trash,
              iOSIcon: Icons.restore_from_trash,
              semanticLabel: translate.restore,
              toolTip: translate.restore,
            ),
            onPressed: widget.restore,
          ),
          IconButton(
            icon: IconGeneric(
              androidIcon: Icons.select_all,
              iOSIcon: CupertinoIcons.check_mark_circled_solid,
              semanticLabel: translate.select_all,
              toolTip: translate.select_all,
            ),
            onPressed: widget.selectAll,
          ),
        ],
      );
    } else {
      return AppBar(
        leading: IconButton(
          icon: IconGeneric(
            androidIcon: Icons.arrow_back,
            iOSIcon: CupertinoIcons.back,
            semanticLabel: translate.tooltip_previous_screen,
            toolTip: translate.tooltip_previous_screen,
          ),
          onPressed: () {
            widget.onPop();
          },
        ),
        title: TextGeneric(
          text: translate.trash,
          fontSize: kSectionTitleSize,
        ),
        actions: <Widget>[
          IconButton(
            icon: IconGeneric(
              androidIcon: Icons.select_all,
              iOSIcon: CupertinoIcons.check_mark_circled_solid,
              semanticLabel: translate.select_all,
              toolTip: translate.select_all,
            ),
            onPressed: widget.selectAll,
          ),
        ],
      );
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_hard/components/all-notes-bottom-sheet/all-notes-bottom-sheet.dart';
import 'package:task_hard/components/icon-components/icon-generic.dart';
import 'package:task_hard/components/text-components/text-generic.dart';
import 'package:task_hard/controllers/database-controller/hive-controller.dart';
import 'package:task_hard/generated/l10n.dart';
import 'package:task_hard/views/home-screen/home-screen.dart' show Arguments;
import 'package:task_hard/views/new-task-screen/new-task-screen.dart';
import 'package:uuid/uuid.dart';

class CreateNoteBottom extends StatelessWidget {
  final String tagName;

  CreateNoteBottom({@required this.tagName});

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
            HiveController hC = HiveController();

            String key = Uuid().v4();

            hC.putTagOnNote(key, tagName);

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
          child: ListTile(
            leading: IconGeneric(
              androidIcon: Icons.note,
              iOSIcon: CupertinoIcons.news_solid,
              semanticLabel: translate.compose_new_note,
              toolTip: translate.compose_new_note,
            ),
            title: TextGeneric(text: translate.compose_new_note),
            trailing: IconGeneric(
              androidIcon: Icons.create,
              iOSIcon: CupertinoIcons.pen,
              semanticLabel: translate.compose_new_note,
              toolTip: translate.compose_new_note,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.pop(context);
            showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return AllNotesBottomSheet(tagName: tagName);
              },
            );
          },
          child: ListTile(
            leading: IconGeneric(
              androidIcon: Icons.note,
              iOSIcon: CupertinoIcons.news_solid,
              semanticLabel: translate.choose_a_note,
              toolTip: translate.choose_a_note,
            ),
            title: TextGeneric(text: translate.choose_a_note),
          ),
        ),
      ],
    );
  }
}

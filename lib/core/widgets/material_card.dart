import 'package:flutter/material.dart';

import '../../features/note/domain/entities/note.dart';
import '../../generated/l10n.dart';
import '../Utils/date_formater.dart';

class MaterialCard extends StatelessWidget {
  final ValueChanged<bool> onTap;
  final ValueChanged<bool> onLongPress;
  final bool isSelected;
  final Note note;

  const MaterialCard({
    Key key,
    @required this.note,
    @required this.onTap,
    @required this.onLongPress,
    @required this.isSelected,
  }) : super(key: key);

  Widget buildTags() {
    if (note.tags == null || note.tags.isEmpty) {
      return Container();
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: note.tags.length,
      itemBuilder: (context, index) {
        Color cardColor =
            note.color ?? Theme.of(context).scaffoldBackgroundColor;
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Chip(
              elevation: 8,
              backgroundColor: isSelected ? Colors.grey : cardColor,
              label: Text(
                note.tags[index],
                style: TextStyle(
                  color: cardColor == Colors.white
                      ? Typography.blackRedmond.bodyText1.color
                      : Typography.whiteRedmond.bodyText1.color,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    const double opacity = 0.7;

    Color cardColor = note.color ?? Theme.of(context).primaryColor;

    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: cardColor == Colors.white
            ? Typography.blackRedmond
            : Typography.whiteRedmond,
        iconTheme: IconThemeData(
          color: cardColor == Colors.white ? Colors.black87 : Colors.white,
        ),
      ),
      child: InkWell(
        onTap: () {
          onTap(isSelected);
        },
        onLongPress: () {
          onLongPress(isSelected);
        },
        child: Container(
          constraints: BoxConstraints(
            maxHeight: 350,
            minHeight: 80,
          ),
          child: Card(
            color: isSelected ? Colors.grey : cardColor,
            elevation: 4,
            clipBehavior: Clip.antiAlias,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  title: Text(
                    note.title ?? '',
                    maxLines: 2,
                  ),
                  subtitle: note.reminder != null
                      ? Column(
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Opacity(
                                  opacity: opacity,
                                  child: Icon(
                                    Icons.alarm,
                                    size: 18,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Flexible(
                                  child: Opacity(
                                    opacity: opacity,
                                    child: Text(
                                      DateFormater.format(
                                        context: context,
                                        translate: translate,
                                        date: note.reminder,
                                        repeat: note.repeat,
                                      ),
                                      style: TextStyle(
                                        decoration: note.expired
                                            ? TextDecoration.lineThrough
                                            : TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider()
                          ],
                        )
                      : Divider(),
                ),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Opacity(
                      opacity: opacity,
                      child: Text(
                        note.note ?? '',
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ),
                buildTags(),
                ButtonBar(
                  alignment: MainAxisAlignment.start,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

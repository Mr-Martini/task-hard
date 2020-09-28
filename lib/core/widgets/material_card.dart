import 'package:flutter/material.dart';
import 'package:task_hard/core/Utils/date_formater.dart';
import 'package:task_hard/generated/l10n.dart';

class MaterialCard extends StatelessWidget {
  final String title;
  final String note;
  final String repeat;
  final ValueChanged<bool> onTap;
  final ValueChanged<bool> onLongPress;
  final DateTime reminder;
  final Color color;
  final bool expired;
  final bool isSelected;

  const MaterialCard({
    Key key,
    @required this.title,
    @required this.note,
    @required this.repeat,
    @required this.onTap,
    @required this.onLongPress,
    @required this.reminder,
    @required this.color,
    @required this.expired,
    @required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    const double opacity = 0.7;

    Color cardColor = color ?? Theme.of(context).primaryColor;

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
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                ListTile(
                  title: Text(
                    title ?? '',
                    maxLines: 2,
                  ),
                  subtitle: reminder != null
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
                                        date: reminder,
                                        repeat: repeat,
                                      ),
                                      style: TextStyle(
                                        decoration: expired
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
                        note ?? '',
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                ),
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

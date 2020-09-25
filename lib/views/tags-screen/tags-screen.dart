import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:task_hard/components/appbar-component/tags-screen-app-bar.dart';
import 'package:task_hard/components/edit-tag-component/update-tag-info.dart';
import 'package:task_hard/components/empty-folder-component/empty-folder.dart';
import 'package:task_hard/components/icon-components/icon-generic.dart';
import 'package:task_hard/components/tag-bubble-component/tag-buble-component.dart';
import 'package:task_hard/controllers/common/search-algorithm.dart';
import 'package:task_hard/controllers/database-controller/hive-controller.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_hard/controllers/selectedValues-controller/selected-values-controller.dart';
import 'package:task_hard/generated/l10n.dart';
import 'package:task_hard/views/home-screen/home-screen.dart';
import 'package:task_hard/views/tags-screen/tag-screen.dart';
import 'package:uuid/uuid.dart';

class TagsScreen extends StatefulWidget {
  static const String id = 'tags_screen';

  @override
  _TagsScreenState createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  HiveController hC = HiveController();
  TextEditingController textEditingController = TextEditingController();
  String text;

  void updateTag(String tagName, BuildContext context) {
    Navigator.pop(context);
    String key = Uuid().v4();
    hC.putTag(tagName, key);
  }

  bool isEmpty(String text) {
    if (text == null || text == '') return true;
    return false;
  }

  void handleChange(String newText) {
    setState(() {
      text = newText;
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SelectedValuesController sVC =
        Provider.of<SelectedValuesController>(context, listen: false);

    S translate = S.of(context);

    return Scaffold(
      appBar: TagsAppBar(
        onChanged: handleChange,
        textEditingController: textEditingController,
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box('tags').listenable(),
        builder: (context, Box<dynamic> box, widget) {
          var raw = box.values;
          List values = SearchAlgorithm.searchTag(raw.toList(), text);
          if (values.isEmpty && isEmpty(text)) {
            return EmptyFolder(
              androidIcon: Icons.label,
              title: translate.no_tags,
              iOSIcon: CupertinoIcons.tag_solid,
              toolTip: translate.no_tags,
            );
          }

          if (values.isEmpty && !isEmpty(text)) {
            return EmptyFolder(
              androidIcon: Icons.search,
              title: translate.nothing_found,
              iOSIcon: CupertinoIcons.search,
              toolTip: translate.search,
            );
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: StaggeredGridView.countBuilder(
                crossAxisCount: 2,
                physics: BouncingScrollPhysics(),
                staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
                itemCount: values.length,
                itemBuilder: (BuildContext context, int index) {
                  return TagBubble(
                    title: values[index]['name'],
                    icon: values[index]['icon'],
                    color: values[index]['color'],
                    onTap: () {
                      if (sVC.getSelectedItems.isEmpty) {
                        Navigator.pushNamed(
                          context,
                          TagScreen.id,
                          arguments: Arguments(
                            key: 'key',
                            tagName: values[index]['name'],
                          ),
                        );
                      }
                    },
                    isSelected: (bool isSelected) {
                      if (isSelected) {
                        sVC.setSelectedItem = values[index];
                      } else {
                        sVC.removeSelectedItem(values[index]);
                      }
                    },
                  );
                }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).buttonColor,
        onPressed: () {
          showModal(
            configuration: FadeScaleTransitionConfiguration(),
            context: context,
            builder: (BuildContext context) {
              return UpdateTagInfo(
                title: translate.add_a_tag,
                hintText: translate.type_a_new_tag,
                updateTag: (String tagName) {
                  updateTag(tagName, context);
                },
              );
            },
          );
        },
        child: IconGeneric(
          androidIcon: Icons.add,
          iOSIcon: CupertinoIcons.add,
          semanticLabel: translate.add_a_tag,
          toolTip: translate.add_a_tag,
          color: Colors.white,
        ),
        tooltip: translate.add_a_tag,
      ),
    );
  }
}

import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:task_hard/components/empty-folder-component/empty-folder.dart';
import 'package:uuid/uuid.dart';

import '../../../../components/icon-components/icon-generic.dart';
import '../../../../components/side-drawer-component/side-drawer-component.dart';
import '../../../../components/text-components/text-generic.dart';
import '../../../../components/tooltip-component/tooltip-component.dart';
import '../../../../core/Utils/arguments.dart';
import '../../../../core/widgets/material_card.dart';
import '../../../../dependency_container.dart';
import '../../../../generated/l10n.dart';
import '../../../../views/about-screen/about-screen.dart';
import '../../../../views/profile-screen/profile-screen.dart';
import '../../../../views/settings-screen/settings-screen.dart';
import '../../../note/presentation/pages/task_container.dart';
import '../bloc/homenotes_bloc.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home_page';

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).iconTheme.color,
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          translate.app_name,
          style: TextStyle(
            color: Theme.of(context).textTheme.headline6.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundImage: AssetImage('images/ProfilePhoto.jpg'),
              radius: 16,
            ),
            onPressed: () {
              showModal(
                configuration: FadeScaleTransitionConfiguration(),
                context: context,
                builder: (context) => AlertDialog(
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(),
                  title: TextGeneric(
                    text: translate.quick_actions,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ToolTipComponent(
                        message: translate.tooltip_go_to_profile_screen,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, ProfileScreen.id);
                          },
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                                  AssetImage('images/ProfilePhoto.jpg'),
                            ),
                            title: TextGeneric(
                              text: 'Marcos Martini',
                              fontSize: 14,
                            ),
                            subtitle: TextGeneric(
                              text: 'marcosmartini765@gmail.com',
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      Divider(),
                      Container(
                        height: 160,
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(context, SettingsScreen.id);
                              },
                              child: ListTile(
                                title: TextGeneric(
                                  text: translate.settings,
                                ),
                                leading: IconGeneric(
                                  androidIcon: Icons.settings,
                                  iOSIcon: CupertinoIcons.settings,
                                  toolTip: translate.app_settings,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () =>
                                  Navigator.pushNamed(context, AboutScreen.id),
                              child: ListTile(
                                title: TextGeneric(text: translate.about),
                                leading: IconGeneric(
                                  androidIcon: Icons.info,
                                  iOSIcon: CupertinoIcons.info,
                                  toolTip: translate.app_about,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: ListTile(
                                title: TextGeneric(text: translate.sign_out),
                                leading: IconGeneric(
                                  androidIcon: Icons.exit_to_app,
                                  iOSIcon: CupertinoIcons.person_solid,
                                  toolTip: translate.sign_out,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      drawer: DrawerComponent(),
      body: BlocProvider(
        create: (context) => sl<HomenotesBloc>(),
        child: BlocBuilder<HomenotesBloc, HomenotesState>(
          builder: (context, state) {
            if (state is HomenotesInitial) {
              BlocProvider.of<HomenotesBloc>(context).add(GetHomeNotes());
            } else if (state is Loaded) {
              if (state.notes.notes.isEmpty) {
                return EmptyFolder(
                  androidIcon: Icons.note,
                  title: translate.empty_home_notes,
                  iOSIcon: Icons.note,
                  toolTip: translate.notes,
                );
              }
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: StaggeredGridView.countBuilder(
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                  mainAxisSpacing: 4.0,
                  crossAxisSpacing: 4.0,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  itemCount: state.notes.notes.length,
                  crossAxisCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    var note = state.notes.notes[index];
                    return MaterialCard(
                      key: Key(note.key),
                      title: note.title,
                      note: note.note,
                      color: note.color,
                      reminder: note.reminder,
                      repeat: note.repeat,
                      expired: note.expired,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          TaskContainer.id,
                          arguments: Arguments(
                            color: note.color ?? Theme.of(context).primaryColor,
                            title: note.title,
                            note: note.note,
                            key: note.key,
                            scaffoldKey: _scaffoldKey,
                          ),
                        );
                      },
                    );
                  },
                ),
              );
            }
            return Container();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        clipBehavior: Clip.antiAlias,
        backgroundColor: Theme.of(context).buttonColor,
        tooltip: translate.new_note,
        onPressed: () {
          String key = Uuid().v4();
          Navigator.pushNamed(
            context,
            TaskContainer.id,
            arguments: Arguments(
              color: Theme.of(context).primaryColor,
              title: null,
              note: null,
              key: key,
              scaffoldKey: _scaffoldKey,
            ),
          );
        },
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }
}

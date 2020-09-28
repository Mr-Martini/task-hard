import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_hard/core/widgets/profile_icon_button.dart';
import 'package:task_hard/features/home_app_bar/presentation/bloc/homeappbar_bloc.dart';
import 'package:task_hard/features/note/domain/entities/note.dart';
import 'package:task_hard/generated/l10n.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  HomeAppBar({Key key}) : super(key: key);

  @override
  _HomeAppBarState createState() => _HomeAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(55);
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  Widget build(BuildContext context) {
    S translate = S.of(context);

    return BlocBuilder<HomeappbarBloc, HomeappbarState>(
      builder: (context, state) {
        if (state is HomeappbarInitial) {
          return AppBar(
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
              ProfileIconButton(),
            ],
          );
        } else if (state is Loaded) {
          var notes = state.selectedNotes.selectedNotes;
          if (notes.length >= 1) {
            return AppBar(
              leading: IconButton(
                icon: Icon(Icons.clear),
                onPressed: () {
                  BlocProvider.of<HomeappbarBloc>(context).add(
                    AddNote(
                      selectedNotes: <Note>[],
                    ),
                  );
                },
              ),
              title: Text(notes.length.toString()),
              actions: [
                IconButton(
                  icon: Icon(Icons.add_alert),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            );
          }
          return AppBar(
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
              ProfileIconButton(),
            ],
          );
        }
        return Container();
      },
    );
  }
}

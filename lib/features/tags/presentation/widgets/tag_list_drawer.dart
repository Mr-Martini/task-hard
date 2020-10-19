import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dependency_container.dart';
import '../../../../generated/l10n.dart';
import '../bloc/tags_bloc.dart';

class TagsListDrawer extends StatefulWidget {
  TagsListDrawer({Key key}) : super(key: key);

  @override
  _TagsListDrawerState createState() => _TagsListDrawerState();
}

class _TagsListDrawerState extends State<TagsListDrawer> {
  @override
  Widget build(BuildContext context) {
    final S translate = S.of(context);

    return BlocProvider(
      create: (context) => sl<TagsBloc>(),
      child: BlocBuilder<TagsBloc, TagsState>(
        builder: (context, state) {
          if (state is TagsInitial) {
            BlocProvider.of<TagsBloc>(context).add(GetOnlyTags());
          } else if (state is Loaded) {
            List<String> tags = state.tags;
            if (tags.isEmpty) {
              return Container();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                  child: Opacity(
                    opacity: 0.7,
                    child: Text(translate.tags),
                  ),
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: tags.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Icon(Icons.label),
                      title: Text(tags[index]),
                    );
                  },
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}

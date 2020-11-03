import 'package:flutter/material.dart';

import 'features/archive_notes/presentation/pages/archive_notes.dart';
import 'features/home_notes/presentation/pages/home_page.dart';
import 'features/note/presentation/pages/task_container.dart';
import 'page-transitions/fade.dart';
import 'page-transitions/scale-route.dart';
import 'page-transitions/shared-axis-horizontal.dart';
import 'page-transitions/slide-right-route.dart';
import 'page-transitions/slide_bottom_route.dart';
import 'views/about-screen/about-screen.dart';
import 'views/feedback-screen/feedback-screen.dart';
import 'views/main-screen/main-screen.dart';
import 'views/new-task-screen/deleted-task.dart';
import 'views/new-task-screen/new-task-screen.dart';
import 'views/profile-screen/profile-screen.dart';
import 'views/search-screen/search-screen.dart';
import 'views/settings-screen/account.dart';
import 'views/settings-screen/general.dart';
import 'views/settings-screen/personalization-screen.dart';
import 'views/settings-screen/settings-screen.dart';
import 'views/tags-screen/tag-screen.dart';
import 'views/tags-screen/tags-screen.dart';
import 'views/trash-screen/trash-screen.dart';

class AnnoyingRouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case MainScreen.id:
        return MaterialPageRoute(
            builder: (_) => MainScreen(), settings: routeSettings);
      case HomePage.id:
        return SharedAxisHorizontal(page: HomePage(), settings: routeSettings);
      case SettingsScreen.id:
        return SlideRightRoute(page: SettingsScreen(), settings: routeSettings);
      case ProfileScreen.id:
        return SlideRightRoute(page: ProfileScreen(), settings: routeSettings);
      case FeedBackScreen.id:
        return FadeRoute(page: FeedBackScreen(), settings: routeSettings);
      case NewTask.id:
        return ScaleRoute(page: NewTask(), settings: routeSettings);
      case SearchScreen.id:
        return SharedAxisHorizontal(
            page: SearchScreen(), settings: routeSettings);
      case Personalization.id:
        return FadeRoute(page: Personalization(), settings: routeSettings);
      case Account.id:
        return FadeRoute(page: Account(), settings: routeSettings);
      case ArchivedNotesScreen.id:
        return FadeRoute(page: ArchivedNotesScreen(), settings: routeSettings);
      case TrashScreen.id:
        return FadeRoute(page: TrashScreen(), settings: routeSettings);
      case GeneralScreen.id:
        return FadeRoute(page: GeneralScreen(), settings: routeSettings);
      case TagsScreen.id:
        return FadeRoute(page: TagsScreen(), settings: routeSettings);
      case TagScreen.id:
        return FadeRoute(page: TagScreen(), settings: routeSettings);
      case DeletedTaskScreen.id:
        return ScaleRoute(page: DeletedTaskScreen(), settings: routeSettings);
      case AboutScreen.id:
        return SlideRightRoute(page: AboutScreen(), settings: routeSettings);
      case TaskContainer.id:
        return SlideBottomRoute(page: TaskContainer(), settings: routeSettings);
      default:
        return MaterialPageRoute(builder: (_) => MainScreen());
    }
  }
}

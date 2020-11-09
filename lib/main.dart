import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'dependency_container.dart' as di;
import 'dependency_container.dart';
import 'features/home_notes/presentation/bloc/homenotes_bloc.dart';
import 'features/taged_notes_home/presentation/bloc/tagednoteshomebloc_bloc.dart';
import 'features/theme/presentation/bloc/theme_bloc.dart';
import 'features/theme/presentation/widgets/top_main.dart';
import 'features/time_preference/presentation/bloc/timepreference_bloc.dart';
import 'features/visualization_option/presentation/bloc/visualizationoption_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/LICENSE.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  await Hive.initFlutter();

  await di.init();

  runApp(TaskHard());
}

class TaskHard extends StatefulWidget {
  @override
  _TaskHardState createState() => _TaskHardState();
}

class _TaskHardState extends State<TaskHard> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: di.sl.getAsync<ThemeBloc>(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (_) => sl<HomenotesBloc>(),
                ),
                BlocProvider(
                  create: (_) => sl<TimepreferenceBloc>(),
                ),
                BlocProvider<ThemeBloc>(
                  create: (_) => snapshot.data,
                ),
                BlocProvider(
                  create: (_) => sl<TagednoteshomeblocBloc>(),
                ),
                BlocProvider(
                  create: (_) => sl<VisualizationOptionBloc>(),
                ),
              ],
              child: TopMain(),
            );
          }
          return Container();
        }
        return Container();
      },
    );
  }
}

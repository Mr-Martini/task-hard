import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/selectedValues-controller/selected-values-controller.dart';
import 'controllers/view-controller/view-controller.dart';
import 'dependency_container.dart' as di;
import 'dependency_container.dart';
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

  FlutterSecureStorage storage = FlutterSecureStorage();

  String keyAsString = await storage.read(key: 'key');

  List<int> key = [];

  if (keyAsString == null) {
    key = Hive.generateSecureKey();
    String encKey = jsonEncode(key);
    await storage.write(key: 'key', value: encKey);
  } else {
    List<dynamic> aux = jsonDecode(keyAsString);
    key = List<int>.from(aux);
  }

  var futures = <Future>[];

  futures.addAll([
    Hive.openBox('notes', encryptionKey: key),
    Hive.openBox('tags'),
  ]);

  await Future.wait(futures);

  runApp(HigherProvider());
}

class HigherProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SelectedValuesController()),
        ChangeNotifierProvider(create: (_) => ViewController()),
      ],
      child: TaskHard(),
    );
  }
}

class TaskHard extends StatefulWidget {
  @override
  _TaskHardState createState() => _TaskHardState();
}

class _TaskHardState extends State<TaskHard> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    getViewPreference();
  }

  void getViewPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String sharedValue = prefs.getString('view') ?? 'Staggered';

    ViewController viewController =
        Provider.of<ViewController>(context, listen: false);

    viewController.setValue = sharedValue;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<ThemeBloc>(),
        ),
        BlocProvider(
          create: (_) => sl<TimepreferenceBloc>(),
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
}

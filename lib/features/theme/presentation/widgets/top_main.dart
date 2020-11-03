import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../../../annoying-route-generator.dart';
import '../../../../generated/l10n.dart';
import '../../../../views/main-screen/main-screen.dart';
import '../bloc/theme_bloc.dart';

class TopMain extends StatefulWidget {
  const TopMain({
    Key key,
  }) : super(key: key);

  @override
  _TopMainState createState() => _TopMainState();
}

class _TopMainState extends State<TopMain> {
  @override
  void didChangeDependencies() {
    BlocProvider.of<ThemeBloc>(context).add(GetTheme());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (state is Loaded) {
          return MaterialApp(
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              S.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            initialRoute: MainScreen.id,
            onGenerateRoute: AnnoyingRouteGenerator.generateRoute,
            theme: state.theme.themeData,
            darkTheme: state.theme.darkTheme,
          );
        } else if (state is Error) {
          return Container(
            color: Colors.red,
          );
        }
        return Container(
          color: Colors.blue,
        );
      },
    );
  }
}

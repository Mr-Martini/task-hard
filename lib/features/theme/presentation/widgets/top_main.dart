import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../../../annoying-route-generator.dart';
import '../../../../generated/l10n.dart';
import '../../../../views/main-screen/main-screen.dart';
import '../bloc/theme_bloc.dart';

class TopMain extends StatelessWidget {
  const TopMain({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        if (state is ThemeInitial) {
          BlocProvider.of<ThemeBloc>(context).add(GetTheme());
        } else if (state is Loaded) {
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
          return Container();
        }
        return Container();
      },
    );
  }
}

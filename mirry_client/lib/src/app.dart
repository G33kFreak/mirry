import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mirry_client/src/config/routes.dart';
import 'package:mirry_client/src/config/theme.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerDelegate: _router.delegate(
          navRestorationScopeId: 'app',
        ),
        routeInformationParser: _router.defaultRouteParser(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        onGenerateTitle: (BuildContext context) =>
            AppLocalizations.of(context)!.appTitle,
        themeMode: ThemeMode.dark,
        darkTheme: AppTheme.mainTheme,
      );
}

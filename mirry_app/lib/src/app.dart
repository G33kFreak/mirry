import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mirry/src/config/routes.dart';
import 'package:mirry/src/config/theme/app_theme.dart';
import 'package:mirry/src/services/services_wrapper/services_provider.dart';
import 'package:mirry/src/services/services_wrapper/services_wrapper.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) => ServicesProvider(
        child: MaterialApp.router(
          routerDelegate: _router.delegate(
            // Providing a navRestorationScopeId allows the Navigator built by the
            // router to restore the navigation stack when a user leaves and
            // returns to the app after it has been killed while running in the
            // background.
            navRestorationScopeId: 'app',
          ),
          routeInformationParser: _router.defaultRouteParser(),

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          theme: AppTheme.defaultTheme,

          builder: (context, child) => ServicesWrapper(
            router: _router,
            child: child!,
          ),
        ),
      );
}

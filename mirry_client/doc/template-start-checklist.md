# 🍾 Set up the template

Starting a new project? Do this steps:

- [x] Set new package name. Replace all `com.monterail.flutter.template` strings to your desired package name, eg. `com.company.app`.

> Important: You have to also rename a folder structure in `android/app/src/main/kotlin` from `com/monterail/flutter/template` to match the package name, eg. `com/company/app` (yes, you'll have to delete one level of directories). Without this change, built Android apps will not launch.

- [ ] Set Sentry DSN in `environment/.dev-variables` and `environment/.prod-variables`. It can be the same value, reported entries are tagged with `development` or `production` respectively.
- [x] Set proper *APP_NAME* in `environment/.dev-variables` and `environment/.prod-variables`. Development name should have an `[dev]` prefix to easily distinguish it from the prod app.
- [x] Replace `appTitle` in `lib/src/localization/app_en.arb` to actual app title.
- [ ] Replace the app logo and update the splashscreen with `make update-splashscreen`.
- [x] Set proper project name in `pubspec.yaml` and replace all `package:template` occurances in Dart code to `package:${your_app_name}`.

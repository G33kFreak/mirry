import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mirry/src/config/routes/loading.dart';
import 'package:mirry/src/config/routes/main.dart';
import 'package:mirry/src/config/routes/welcome.dart';

part 'routes.gr.dart';

class Routes {
  static const welcome = WelcomeRouteHelper();
  static const main = MainRouteHelper();
  static const loading = LoadingRouteHelper();
}

@AdaptiveAutoRouter(routes: [
  AutoRoute(
    page: LoadingRouteHelper.widget,
    path: LoadingRouteHelper.path,
    initial: true,
  ),
  CustomRoute(
    page: WelcomeRouteHelper.widget,
    path: WelcomeRouteHelper.path,
    transitionsBuilder: TransitionsBuilders.fadeIn,
  ),
  AutoRoute(
    page: MainRouteHelper.widget,
    path: MainRouteHelper.path,
  )
])
class AppRouter extends _$AppRouter {}

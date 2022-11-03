import 'package:mirry/src/config/routes/routes.dart';
import 'package:mirry/src/modules/welcome_screen/view/welcome_screen_view.dart';
export 'package:mirry/src/modules/welcome_screen/view/welcome_screen_view.dart';

class MainRouteHelper extends ParameterlessRouteHelper {
  static const path = '/';
  static const widget = WelcomeScreenView;
  const MainRouteHelper() : super(path: path);
}

import 'package:mirry/src/config/routes/routes.dart';
import 'package:mirry/src/modules/welcome_screen/view/welcome_screen_view.dart';
export 'package:mirry/src/modules/welcome_screen/view/welcome_screen_view.dart';

class WelcomeRouteHelper extends ParameterlessRouteHelper {
  static const path = '/welcome';
  static const widget = WelcomeScreenView;
  const WelcomeRouteHelper() : super(path: path);
}

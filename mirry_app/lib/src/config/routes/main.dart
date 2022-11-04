import 'package:mirry/src/config/routes/routes.dart';
import 'package:mirry/src/modules/main_screen/view/main_screen_view.dart';
export 'package:mirry/src/modules/main_screen/view/main_screen_view.dart';

class MainRouteHelper extends ParameterlessRouteHelper {
  static const path = '/main';
  static const widget = MainScreenView;
  const MainRouteHelper() : super(path: path);
}

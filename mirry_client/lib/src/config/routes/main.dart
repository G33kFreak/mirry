import 'package:mirry_client/src/config/routes/routes.dart';
import 'package:mirry_client/src/modules/main_screen/view/main_screen_view.dart';
export 'package:mirry_client/src/modules/main_screen/view/main_screen_view.dart';

class MainRouteHelper extends ParameterlessRouteHelper {
  static const path = '/';
  static const widget = MainScreenWidget;
  const MainRouteHelper() : super(path: path);
}

import 'package:mirry/src/config/routes/routes.dart';
import 'package:mirry/src/modules/loading_screen/view/loading_screen_view.dart';
export 'package:mirry/src/modules/loading_screen/view/loading_screen_view.dart';

class LoadingRouteHelper extends ParameterlessRouteHelper {
  static const path = '/';
  static const widget = LoadingScreenView;
  const LoadingRouteHelper() : super(path: path);
}

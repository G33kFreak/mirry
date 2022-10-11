import 'package:mirry_client/src/config/routes/routes.dart';
import 'package:mirry_client/src/modules/cubit_screen/view/cubit_view.dart';
export 'package:mirry_client/src/modules/cubit_screen/view/cubit_view.dart';

class CubitRouteHelper extends RouteHelper<String> {
  static const path = '/cubit/:title';
  static const widget = CubitView;

  const CubitRouteHelper() : super(path: path);

  @override
  String generatePath(String title) =>
      absolutePath.replaceFirst(':title', title);
}

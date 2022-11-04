import 'package:mirry/src/config/routes/routes.dart';
import 'package:mirry/src/modules/upload_face_screen/view/upload_face_screen_view.dart';
export 'package:mirry/src/modules/upload_face_screen/view/upload_face_screen_view.dart';

class UploadFaceRouteHelper extends ParameterlessRouteHelper {
  static const path = '/upload-face';
  static const widget = UploadFaceScreenView;
  const UploadFaceRouteHelper() : super(path: path);
}

import 'package:dio/dio.dart';
import 'package:mirry/src/environment/variables.dart';
import 'package:mirry/src/repositories/mirry_connection/mirry_connection_repository.dart';

class BaseUrlInterceptor implements InterceptorsWrapper {
  final IMirryConnectionRepository _mirryConnectionRepository;

  const BaseUrlInterceptor({
    required IMirryConnectionRepository mirryConnectionRepository,
  }) : _mirryConnectionRepository = mirryConnectionRepository;

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final baseUrl = await _mirryConnectionRepository.getBaseUrlIp();

    if (baseUrl != null) {
      options.baseUrl = 'http://$baseUrl:${EnvironmentVariables.mirryPort}';
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }
}

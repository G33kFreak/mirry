import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_status_code/http_status_code.dart';
import 'package:mirry/src/repositories/tokens/tokens_repository.dart';

const unauthCodes = [StatusCode.UNAUTHORIZED, StatusCode.FORBIDDEN];

class AuthInterceptor implements InterceptorsWrapper {
  final ITokensRepository _tokensRepository;

  const AuthInterceptor({
    required ITokensRepository tokensRepository,
  }) : _tokensRepository = tokensRepository;

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    if (unauthCodes.contains(statusCode)) {
      try {
        final cloneRequest = await _refreshProcess(err);
        return handler.resolve(cloneRequest);
      } catch (_) {
        await _tokensRepository.deleteTokens();
        return handler.next(err);
      }
    }

    return handler.next(err);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final tokens = await _tokensRepository.getTokens();

    if (tokens != null) {
      options.headers[HttpHeaders.authorizationHeader] = tokens.accessToken;
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    handler.next(response);
  }

  Future<Response<dynamic>> _refreshProcess(DioError err) async {
    final refreshToken = (await _tokensRepository.getTokens())!.refreshToken;

    final newTokens = await _tokensRepository.performRefreshTokens(
      Dio(),
      refreshToken: refreshToken,
    );

    err.requestOptions.headers[HttpHeaders.authorizationHeader] =
        'Bearer ${newTokens?.accessToken}';

    final newOptions = Options(
      method: err.requestOptions.method,
      headers: err.requestOptions.headers,
    );
    final cloneRequest = await Dio().request(
      err.requestOptions.path,
      data: err.requestOptions.data,
      queryParameters: err.requestOptions.queryParameters,
      cancelToken: err.requestOptions.cancelToken,
      onSendProgress: err.requestOptions.onSendProgress,
      onReceiveProgress: err.requestOptions.onReceiveProgress,
      options: newOptions,
    );

    return cloneRequest;
  }
}

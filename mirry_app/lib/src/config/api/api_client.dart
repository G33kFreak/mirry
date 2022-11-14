import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mirry/src/config/api/auth_interceptor.dart';
import 'package:mirry/src/config/api/base_url_interceptor.dart';
import 'package:mirry/src/repositories/mirry_connection/mirry_connection_repository.dart';
import 'package:mirry/src/repositories/tokens/tokens_repository.dart';

class ApiClient {
  final ITokensRepository _tokensRepository;
  final IMirryConnectionRepository _mirryConnectionRepository;

  const ApiClient({
    required ITokensRepository tokensRepository,
    required IMirryConnectionRepository mirryConnectionRepository,
  })  : _tokensRepository = tokensRepository,
        _mirryConnectionRepository = mirryConnectionRepository;

  Dio _createApiClient() {
    final dio = Dio(
      BaseOptions(
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(BaseUrlInterceptor(
      mirryConnectionRepository: _mirryConnectionRepository,
    ));

    (dio.transformer as DefaultTransformer).jsonDecodeCallback = parseJson;

    return dio;
  }

  Dio get httpClient => _createApiClient();

  Dio get authenticatedHttpClient {
    final dio = _createApiClient();
    dio.interceptors.add(AuthInterceptor(
      tokensRepository: _tokensRepository,
    ));

    return dio;
  }
}

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}
